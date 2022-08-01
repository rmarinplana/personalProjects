WITH

filtered_orders AS (
  SELECT order_id, city_code, pickup_time, enters_delivery, pd_dist,    
  FROM orders
  WHERE DATE(enters_delivery) >= (CURRENT_DATE - 360)
), 

orders_bundled_join AS (
  SELECT fo.*, bundle_id
  FROM filtered_orders AS fo
  LEFT JOIN bundled_orders AS bo
  ON fo.order_id = bo.order_id
), 

create_first_delivery_time AS(
  SELECT city_code, pickup_time, enters_delivery, pd_dist, 
  MIN(enters_delivery) OVER(PARTITION BY bundle_id, order_id) AS first_delivery_time -- used enters_delivery rather than pd_dist to avoid errors in case of 2 bundles having equal pd_dist
  FROM orders_bundled_join
), 

filter_first_delivery AS (
  SELECT city_code, pd_dist, TIMESTAMP_DIFF(enters_delivery ,pickup_time, SECOND) AS delivery_time,
  FROM create_first_delivery_time
  WHERE enters_delivery = first_delivery_time
)

SELECT city_code, SUM(pd_dist) / SUM(delivery_time) AS average_courier_speed_in_meters_per_second
FROM filter_first_delivery
GROUP BY city_code