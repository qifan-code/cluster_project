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

The reason why I use k-median is there are outliers in dataset. For K-mean method, it is sensitive to outliers but for K-median method, we can avoid this issue.

Other package in R:
|Method|Number of Clusters|
|------|------------------|
|NbCluster-mean|2, 4|
|NbCluster-median|2|
|NbCluster-centroid|2|
|PAMK|3|
|DBSCAN|2|

# My Challenge: 
1. I cant find NbCluster or PAMK package or any other similar ones in Python.
2. For DBSCAN, I couldnt implement proper eps selection functions. Therefore, my strategy is to use loop. With minimal number of noise points, I select the best silhouette score. And based on original data, there are 2 clusters. Therefore, I am much more prefer to get 2 clusters in DBSCAN.
3. For final cluster plot, I see there are pretty much "noises" so I believe 2 or 3 cluster may not be the optimal solution.
   
# TODO:
1. Implement cluster in Python.
2. Improve cluster methods in both R and Python.

# Plot for each method
![K-mean WSS](https://github.com/qifan-code/cluster_project/assets/64823500/e67b92b2-1d87-4f98-a942-3ddbc7a15688)
For WSS, I need find "knee" point which means before this point, slope is very high, but after this point, the plot becomes flatten. 
![K-mean Sil](https://github.com/qifan-code/cluster_project/assets/64823500/d7ede7d8-d8d1-48ce-94bd-5bf57d29b861)
For Silhouette score, I need find the highest one. 
![K-mean gap](https://github.com/qifan-code/cluster_project/assets/64823500/6aa81bda-ef35-4c1b-817a-18a757c2368f)
For gap stastic, I need to find max SE.sim and that row represents for the best cluster
![K-median WSS](https://github.com/qifan-code/cluster_project/assets/64823500/3c675a56-194e-4a57-8f01-58d0e1c32725)
This is WSS for K-median method, I cant find any "knee" points therefore on the table above under k-median WSS method, I mark "X". 
![K-median sil](https://github.com/qifan-code/cluster_project/assets/64823500/255a1351-41d3-491e-a87d-804a35377ff7)
This is K-median Silhouette score plot. 
![K-median gap](https://github.com/qifan-code/cluster_project/assets/64823500/b62f7953-fb2f-4dcc-a356-1e9743e9635e)
This is K-median Gap Stastic plot
![NbCluster_mean](https://github.com/qifan-code/cluster_project/assets/64823500/6fabbe07-168e-4c97-9eb9-21f84b6a62f6)
This is NbCluster Plot-mean method
![NbCluster_median](https://github.com/qifan-code/cluster_project/assets/64823500/7a146be1-7f9c-4f6e-a1de-0d2ec656ced9)
This is NbCluster Plot-median method
![NbCluster_centroid](https://github.com/qifan-code/cluster_project/assets/64823500/b2d6d9e6-72f4-45da-a024-5b52ebacbebf)
This is NbCluster Plot-centroid method
![PAMK](https://github.com/qifan-code/cluster_project/assets/64823500/f614e57e-d859-4bb9-9523-763e910b92e9)
This is PAMK method Plot
![final_cluster_2](https://github.com/qifan-code/cluster_project/assets/64823500/2df014ce-240b-4ba4-a768-57d02fa1461f)
This is final cluster - 2 clusters
![final_cluster_3](https://github.com/qifan-code/cluster_project/assets/64823500/55c18e9b-f14b-45cd-b08f-7418be509f68)
This is final cluster - 3 clusters



