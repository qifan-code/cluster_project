cat("\014") # clears console
rm(list = ls()) # clears global environment
try(dev.off(dev.list()["RStudioGD"]), silent = TRUE) # clears plots
try(p_unload(p_loaded(), character.only = TRUE), silent = TRUE) # clears packages
options(scipen = 100) # disables scientific notation for entire R session

library(caTools)
library(rpart)
library(rpart.plot)
library(caret)
library(dplyr)
library(e1071)
library(magrittr)
library(pROC)
library(randomForest)
library(mclust)
library(Metrics)
library(ipred)
library(xgboost)
library(ggplot2)



setwd("C:/Users/39930/Desktop/ALY6040/project")
df <- read.csv("heart.csv")
df

str(df)
#################################################################################
#data cleaning
#################################################################################
df <- na.omit(df)
df
df$Sex <- as.numeric(as.factor(df$Sex))
df$ChestPainType <- as.numeric(as.factor(df$ChestPainType))
df$RestingECG <- as.numeric(as.factor(df$RestingECG))
df$ST_Slope <- as.numeric(as.factor(df$ST_Slope))
df$ExerciseAngina <- as.numeric(as.factor(df$ExerciseAngina))
df$HeartDisease <- as.numeric(as.factor(df$HeartDisease))


#################################################################################
#normalization
#################################################################################
df[, c(1, 4, 5, 8)] <- scale(select(df, c(Age, RestingBP, Cholesterol, MaxHR)))
df_target <- df$HeartDisease
df <- df[, c(seq(1, 11))]

#################################################################################
#K-mean WSS
#################################################################################
kmean_normal <- kmeans(df, 2)
kmean_normal

plot(df[c("Cholesterol", "MaxHR")], col = kmean_normal$cluster)
points(kmean_normal$centers[, c("Cholesterol", "MaxHR")], col = 1:2, pch = 8, cex = 2)


wss <- (nrow(df)-1) * sum(apply(df,2, var))
for (i in 2:20) wss[i] <- sum(kmeans(df, center = i, nstart = 25)$withinss)
plot(1:20, wss, type = "b", col = 10)



#################################################################################
#K-mean Silhouette
#################################################################################
library(cluster)    
library(factoextra) 

k <- c(seq(2, 15, 1))
sic <- c()
for(i in k){
  km <- kmeans(df, centers = i, nstart=25)
  ss <- silhouette(km$cluster, dist(df))
  sic <- c(sic, mean(ss[, 3]))  
}
plot(k, type='b', sic, xlab='Number of clusters', ylab='Average Silhouette Scores', frame=FALSE)


#################################################################################
#K-mean gap statics
#################################################################################
gap_stat <- clusGap(df, FUN = kmeans, K.max = 20, B = 50, d.power = 1)
#B = number of bootstrap samples
#d.power = power apply to euclideam formular
plot(gap_stat, main = "Gap Statistic for K-median Clustering")
gap_values <- gap_stat$Tab[, "gap"]
std_dev <- gap_stat$Tab[, "SE.sim"]
best_k <- maxSE(gap_values, std_dev)
best_k



#################################################################################
#K-median WSS
#################################################################################
library(ClusterR)
library(cluster)
k_median <- pam(df, k = 2, metric = "euclidean")

wss <- c()
for (i in 2:20) {
  k_median <- pam(df, k = i, metric = "euclidean")
  wss <- c(wss, sum(k_median$clusinfo[, "av_diss"]))
}
plot(2:20, wss, type = "b", col = 10)

#################################################################################
#K-median Silhoette
#################################################################################
sil <- c()
for (i in 2:20){
  k_median <- pam(df, k = i, metric = "euclidean")
  sil <- c(sil, mean(silhouette(k_median$clustering, dist(df, method = "euclidean"))[, 3]))
}

plot(2:20, sil, type = "b", pch = 19, frame = FALSE,
     xlab = "Number of clusters K",
     ylab = "Average silhouette width",
     main = "Silhouette Method for K-median Clustering")

#################################################################################
#K-median gap statics
#################################################################################
gap_stat <- clusGap(df, FUN = pam, K.max = 20, B = 50, d.power = 1)
gap_values <- gap_stat$Tab[, "gap"]
std_dev <- gap_stat$Tab[, "SE.sim"]
best_k <- maxSE(gap_values, std_dev)
best_k


#################################################################################
#NBcluster
#################################################################################
library(NbClust)
df_nb <- data.matrix(df)
nc_normal <- NbClust(df_nb, min.nc = 2, max.nc = 20, method = "kmeans")
bar_normal <- table(nc_normal$Best.n[1, ])
bar_normal


nc_normal <- NbClust(df_nb, min.nc = 2, max.nc = 20, method = "median")
bar_normal <- table(nc_normal$Best.n[1, ])
bar_normal

nc_normal <- NbClust(df_nb, min.nc = 2, max.nc = 20, method = "centroid")
bar_normal <- table(nc_normal$Best.n[1, ])
bar_normal

#################################################################################
#PAMK
#################################################################################
library(fpc)
df_pamk <- data.matrix(df)
pamk_normal <- pamk(df_pamk, 2:20)
pamk_normal

pamk_normal$nc
pamk_normal$pamobject$medoids

table(df_target, pamk_normal$pamobject$clustering)

layout(matrix(c(1, 2), 1, 2))
plot(pamk_normal$pamobject)
layout(matrix(1))

#################################################################################
#DBSCAN
#################################################################################
library(dbscan)
kNNdistplot(df, k = 2)
abline(h = 2.15, col = "green")


num_noise <- c()
k <- c()
eps_lst <- c()
sic <- c()
for (i in seq(1, 5, 0.001)){
  db_normal <- dbscan(df, eps = i, minPts = ncol(df)+1)
  num_noise <- c(num_noise, sum(db_normal$cluster == 0))
  k <- c(k, length(unique(db_normal$cluster)))
  eps_lst <- c(eps_lst, i)
  ss <- silhouette(db_normal$cluster, dist(df))
  sic <- c(sic, mean(ss[,3]))
}

dbscan_table1 <- data.frame(
  "k" = k, 
  "eps" = eps_lst, 
  "noise" = num_noise, 
  "silhouette" = sic
)
dbscan_table1 <- dbscan_table1[order(-dbscan_table1$silhouette),]
dbscan_table1




db_normal <- dbscan(df, eps = 2.888, minPts = ncol(df)+1)
noise <- which(db_normal$cluster == 0)
df <- df[-noise, ]




kNNdistplot(df, k = 1)
abline(h = 2.15, col = "green")

num_noise <- c()
k <- c()
eps_lst <- c()
for (i in seq(1.5, 5, 0.001)){
  db_normal <- dbscan(df, eps = i, minPts = ncol(df)+1)
  num_noise <- c(num_noise, sum(db_normal$cluster == 0))
  k <- c(k, length(unique(db_normal$cluster)))
  eps_lst <- c(eps_lst, i)
}

dbscan_table2 <- data.frame(
  "k" = k, 
  "eps" = eps_lst, 
  "noise" = num_noise
)
dbscan_table2 <- dbscan_table2[order(dbscan_table2$noise),]
dbscan_table2


#################################################################################
#Final Cluster Plot
#################################################################################
#library(fviz_cluster)
layout(matrix(c(1, 2), 1, 2))

km.res <- kmeans(df, 2, nstart = 10)
fviz_cluster(km.res, df, ellipse.type = "norm")

km.res <- kmeans(df, 3, nstart = 10)
fviz_cluster(km.res, df, ellipse.type = "norm")

layout(matrix(1))






