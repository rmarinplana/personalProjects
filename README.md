# Machine-Learning-and-NLP-Text-Classification
Machine Learning and NLP: Text Classification using python, scikit-learn, and Spacy

1.	Introduction
Text classification, the process of classifying text documents into classes based on their topic, is a common application of NLPand ML. In general, text classification is both a multiclass and multi-label classification problem, meaning there are multiple classes to choose from when labeling an input and each input might correspond to more than one class. Multi-label classification is often tackled in two ways: one-vs-rest, which decomposes the classification problem into k independent binary classification problems,training a separate classifier for each of the k possible output labels, and adaptive algorithms, which try to predict all labels at once along with a confidence ranking associated with each label. 
In this project, we first take the one-vs-rest approach by training four binary classification models, one for each of the four classes of the AG News dataset, using SGD-based classifiers with unigram, bigram, and trigram representations of the text. We tune the n-grams and the alpha regularization constant of the models using grid search and 5-fold cross-validation. We also tune the thresholds of one of these classifiers to experiment with high-recall and high-precision classifiers and discuss the potential trade-offs and applications for these settings. We then experiment with multiclass methods that decide one among the four classes at once, and werun an analysis on whatunigrams and bigrams the model learned for each class. Finally, we run the classifiers onto unseen articles compiled in the Articles dataset found on Kaggle to evaluate if there is noticeable divergence in their performance. 
2.	Experimental Setup & Dataset
To conduct our experiments, we use the scikit-learn machine learning suite and the Natural Language Processing Toolkit. All source code from the project can be found appended at the end of the report.
The two datasets we use to develop our classifiers are from past Kaggle competitions. The AG News dataset is a collection of news articles categorized into one of the four classes: Science, Sports, World, and Business. Additionally, each article is labeled with four binary labels, one per category. The Articles dataset contains news articles from 2015 and 2016 categorized into one of two classes: Sports, and Business. This dataset can be found byclicking the following link:Articles.csv
3.	Feature Extraction
To retrieve information from our articles, we define a convenience function to create an sklearn text analyzer. The text analyzer extracts n-grams, up to a given n. The resulting representation is a bag-of-n-grams. Besides tokenizing text into n-grams, this analyzer also removes punctuation and other characters, lowercases all words, and even removes some words, such as “I”. 
4.	Experiments, Results, & Discussion
a.	Binary Classifiers
We train four binary classification models, one for each of the four classes (Science, Sports, World, and Business), using an SGD classifier. Weexperiment with different alpha regularization constants and the number of n-grams for each model until we find the combinations that work best using grid search and 5-fold cross-validation, with Accuracy as the performance metric.
Cross-validation reports:
Science Binary Classifier

Alpha values trained: 1e-3, 1e-6, 1e-9, 1e-12. 
N-gram range: (1, 1), (1, 2), (1, 3)

 	Sports Binary Classifier

Alpha values trained: 1e-4, 1e-5, 1e-6, 1e-7. 
N-gram range: (1, 1), (1, 2), (1, 3)

 




World Binary Classifier

Alpha values trained: 1e-3, 1e-6, 1e-9, 1e-12. 
N-gram range: (1, 1), (1, 2), (1, 3)

 	


Business Binary Classifier

Alpha values trianed: 1e-4, 1e-5, 1e-6, 1e-7. 
N-gram range: (1, 1), (1, 2), (1, 3)

 

The experiments show that alpha regularization constant 1e-5 performs best, with close values such as 1e-6 and 1e-7 offering similar experimental results. In terms of n-grams, ranges (1,2) and (1,3) perform significantly better than (1,1). 
Metrics of the top model for each class:
Class	Accuracy	Precision	Recall	F-Score
Science	0.94	0.89	0.88	0.88
Sports	0.98	0.96	0.98	0.97
World	0.95	0.92	0.89	0.90
Business	0.94	0.91	0.85	0.88

The table clearly shows that the sports binary classifier has the highest performance. This is likely due to sports articles using a very specific and distinguishable set of words or n-grams. On the other hand, Science, world, and business articles havelower accuracy. From a logical standpoint, we believe this lower performance could be given by two factors: first, the worlds found in science, world, and business articles might not be as specific. Second, some or all of these three classes could be more likely to share common words. The performance is good enough for proof of concept. 
b.	Precision and Recall:
We tune the thresholds of the business class binary classifier to experiment with high-recall and high-precision classifiers. We compare 5 thresholds, -2, -1, 0, 1, and 2, and we plot the precision and recall curve. The resultsfor the positive class are as follows:
Threshold	Accuracy	Precision	Recall	F1-Score
-2	0.32	0.27	1.00	0.42
-1	0.81	0.57	0.97	0.72
0	0.94	0.91	0.85	0.88
1	0.72	0.97	0.57	0.72
2	0.79	0.98	0.15	0.26


The plot clearly shows the precision-recall trade-off. As we increase the threshold for determining if a class is positive, recall of the positive class will decrease but our predictions will get more and more accurate. 
This can be an essential tool when precision is more important than recall or vice-versa. We might select a threshold from the precision-recall curve based on the use-case of the model: a high accuracy use-case could be, for example, to show a user a random article of their preferred category. A high recall use-case could be to pre-classify articles into different classes. A person would only need to manually examine those articles pre-classified as positive, saving time.

c.	Multiclass Classification: 
We train an SGD-based classifier with unigram, bigram, and trigram representations of the text that decides one among the four classes at once. We tune the hyperparameters using grid search and 5-fold cross-validation.We use the search grid parameters that worked best in the previous experiments. They are as follows: Alpha: 1e-4, 1e-5, 1e-6, 1e-7. N-gram range: (1, 1), (1, 2), (1, 3). 
Cross-validation report of top 3fits:
Rank test accuracy	Alpha	N-gram range (Vector)	Mean test accuracy
1	1e-05	(1, 2)	0.9168
2	1e-05	(1, 3)	0.9145
3	1e-06	(1, 3)	0.9125

Top model metrics:
Class	Precision	Recall	F1-Score
Science	0.89	0.90	0.90
Sports	0.95	0.99	0.97
World	0.93	0.90	0.91
Business	0.90	0.88	0.89

The model using alpha 1e-5 and n-gram range (1,2) still performs best.After comparing these metrics from the ones obtained in the binary classification models, we can conclude that the multiclass model performs slightly better than each of the individual binary classifiers. 
d.	N-gram Analysis
We run a fine analysis on the top and bottom 20 n-grams that the model learned for each class. Below you can find a table showing the n-grams that do not seem to be appropriate for the designated class, and the reason why the learning algorithm decided to set that weight.  
Class	Unfitting n-grams	Explanation
Science	yahoo	Many articles from news.yahoo/science
	washington post	Many articles from washingtonpost.com/science
	ft com	Many articles from ft.com/science
	36 billion	$36B lost in data breaches, 36B tons of CO2 emissions
Sports	notre dame	Notre Dame Fighting Irish athletic team, Notre Dame University
World	york stocks	Business and world related articles, classified as world
	york investors	Business and world related articles, classified as world
Business	salvation army	Many articles related to Salvation Army’s business model

e.	Testing the models on unseen recent articles
After doing the required feature engineering, we run the sports and the business binary classifier top performing models (alpha 1e-5, n-gram range (1,2)), onto the Articles dataset. The results are:
Class	Accuracy	Precision	Recall	F-Score
Science	0.99	1.00	0.98	0.99
Business	0.92	1.00	0.83	0.90

There is no noticeable divergence in terms of performance when compared to previous experiments. However,on this dataset precision is considerably higher than recall. This is due to the models being optimized for accuracy in a dataset that was imbalanced towards the negative class.
5.	Conclusions
Text classification is a powerful tool that allows to rapidly get insights from mass data and automate business processes. With the right training datasets, they could be employed to organize, structure, and categorize any kind of text. Potential applications include organizing news articles and legal documents by topics, support tickets by urgency, chat conversations by language, brand mentions by sentiment, and more. The text classifier models we trained, providing that we tune the precision-recall threshold when needed, perform well, and are good enough for proof-of-concept applications.
