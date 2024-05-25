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

# Plot for each method
![K-mean WSS](https://github.com/qifan-code/cluster_project/assets/64823500/b9ea05ff-3c08-4fa0-b1e3-a41ceaf5e422)
For WSS, I need find "knee" point which means before this point, slope is very high, but after this point, the plot becomes flatten. 
![K-mean Sil](https://github.com/qifan-code/cluster_project/assets/64823500/d7ede7d8-d8d1-48ce-94bd-5bf57d29b861)
For Silhouette score, I need find the highest one. 
![K-mean gap](https://github.com/qifan-code/cluster_project/assets/64823500/6aa81bda-ef35-4c1b-817a-18a757c2368f)
For gap stastic, I need to find max SE.sim and that row represents for the best cluster
![K-median WSS](https://github.com/qifan-code/cluster_project/assets/64823500/3c675a56-194e-4a57-8f01-58d0e1c32725)
This is WSS for K-median method, I cant find any "knee" points therefore on the table above under k-median WSS method, I mark "X". 
![K-median sil](https://github.com/qifan-code/cluster_project/assets/64823500/255a1351-41d3-491e-a87d-804a35377ff7)
This is K-median Silhouette score plot. 






