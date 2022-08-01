WITH

filtered_orders AS (
  SELECT order_id, city_code
  FROM orders
  WHERE DATE(enters_delivery) = "2021-11-01" AND city_code IN ("GLV", "PLY")
),

orders_bundled_join AS (
  SELECT city_code, (CASE WHEN is_bundled = TRUE AND is_unbundled = FALSE THEN 1 ELSE 0 END) AS is_bundled
  FROM filtered_orders AS fo
  LEFT JOIN bundled_orders AS bo
  ON fo.order_id = bo.order_id
)

SELECT city_code, 100 * SUM(is_bundled) / COUNT(*) AS percentage_bundled_orders,
FROM orders_bundled_join
GROUP BY city_code