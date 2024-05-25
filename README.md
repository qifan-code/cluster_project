# cluster_project
This project is aiming for practice and adjust different parameters for classification methods

This dataset is the same dataset with classification method practice before. From the dataset, there are 2 classes of if a patient has heart disease. My goal is to find 2 clusters by practice. 
The programming that I choose is R studio because in R, there are several packages such as PAMK, NbCluster to help me vote to an optimal result.

Here are the results:
Traditional Methods:
|Method|WSS|Silhouettle|Gap Statics|
|------|---|-----------|-----------|
|k-mean|3-6|3          |5          |
|k-median|x|3|3|

Other package in R:
|Method|Number of Clusters|
|------|------------------|
|NbCluster-mean|2, 4|
|NbCluster-median|2|
|NbCluster-centroid|2|
|PAMK|3|
|DBSCAN|2|

