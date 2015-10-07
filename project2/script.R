library(gdata);

# All diversity attributes without categorical attributes
dataset_diversity = read.xls("diversity.xlsx", sheet = 2, header = TRUE);

d = dist(dataset_diversity[,2:31]);
fit = cmdscale(d, eig = TRUE, k = 2);

x = fit$points[,1];
y = fit$points[,2];
plot(x, y, main = "dataset_diversity_classical_MDS", xlab = "Coordinate 1", ylab = "Coordinate 2", pch = 19);
text(x, y, labels = dataset_diversity[,1], cex = .7, pos = 3)



# All diversity attributes converted to full matrix
dataset_diversity_converted = read.xls("diversity.xlsx", sheet = 3, header = TRUE);


d2 = dist(dataset_diversity_converted[,2:125]);
# with the version of normalized data - but no big improvement
# d2 = dist(scale(dataset_diversity_converted[,2:125]));
fit = cmdscale(d2, eig = TRUE, k = 2);

x = fit$points[,1];
y = fit$points[,2];
plot(x, y, main = "dataset_diversity_converted_classical_MDS", xlab = "Coordinate 1", ylab = "Coordinate 2", pch = 19);
text(x, y, labels = dataset_diversity[,1], cex = .7, pos = 3)



####### With only generic attributes / no country nor language attributes
#######
####### For now the best composition
dataset_diversity_3 = read.xls("diversity.xlsx", sheet = 4, header = TRUE);

#d = dist(dataset_diversity_3[,2:11]);
d = dist(scale(dataset_diversity_3[,2:11]), method = "minkowski")
fit = cmdscale(d, eig = TRUE, k = 2);

x = fit$points[,1];
y = fit$points[,2];
plot(x, y, main = "dataset_diversity_3_classical_MDS", xlab = "Coordinate 1", ylab = "Coordinate 2", pch = 19);
text(x, y, labels = dataset_diversity_3[,1], cex = .7, pos = 3)


######## With country data but no language data
dataset_diversity_4 = read.xls("diversity.xlsx", sheet = 5, header = TRUE);

d = dist(dataset_diversity_4[,2:67]);
fit = cmdscale(d, eig = TRUE, k = 2);

x = fit$points[,1];
y = fit$points[,2];
plot(x, y, main = "dataset_diversity_4_classical_MDS", xlab = "Coordinate 1", ylab = "Coordinate 2", pch = 19);
text(x, y, labels = dataset_diversity_4[,1], cex = .7, pos = 3)


####### With all attributes + population density
dataset_diversity_5 = read.xls("diversity.xlsx", sheet = 6, header = TRUE);

d = dist(dataset_diversity_5[,2:126]);
fit = cmdscale(d, eig = TRUE, k = 2);

x = fit$points[,1];
y = fit$points[,2];
plot(x, y, main = "dataset_diversity_5_classical_MDS", xlab = "Coordinate 1", ylab = "Coordinate 2", pch = 19);
text(x, y, labels = dataset_diversity_4[,1], cex = .7, pos = 3)

#### IsoMap method
library(MASS);
d = dist(dataset_diversity_5);
fit = isoMDS(d, k = 2);
fit

x = fit$points[,1]
y = fit$points[,2]
plot(x, y, main = "dataset_diversity_6_classical_MDS", xlab = "Coordinate 1", ylab = "Coordinate 2", pch = 19);
text(x, y, labels = dataset_diversity_4[,1], cex = .7, pos = 3)


####### With all percentage attributes
dataset_diversity_7 = read.xls("diversity.xlsx", sheet = 7, header = TRUE);

d = dist(scale(dataset_diversity_7[,2:63]));
fit = cmdscale(d, eig = TRUE, k = 2);

x = fit$points[,1];
y = fit$points[,2];
plot(x, y, main = "dataset_diversity_7_classical_MDS", xlab = "Coordinate 1", ylab = "Coordinate 2", pch = 19);
text(x, y, labels = dataset_diversity_7[,1], cex = .7, pos = 3)


####### With all languages percentage attributes
dataset_diversity_8 = read.xls("diversity.xlsx", sheet = 8, header = TRUE);

d = dist(dataset_diversity_8[,2:35]);
fit = cmdscale(d, eig = TRUE, k = 2);

x = fit$points[,1];
y = fit$points[,2];
plot(x, y, main = "dataset_diversity_8_classical_MDS", xlab = "Coordinate 1", ylab = "Coordinate 2", pch = 19);
text(x, y, labels = dataset_diversity_8[,1], cex = .7, pos = 3)




# Determine number of clusters
wss = (nrow(dataset_diversity_8[,2:35]) - 1) * sum(apply(dataset_diversity_8[,2:35], 2, var))
for (i in 2:15) wss[i] = sum(kmeans(dataset_diversity_8[,2:35], centers = i)$withinss)
plot(1:15, wss, type = "b", xlab = "Number of Clusters", ylab = "Within groups sum of squares")

fit_kmeans = kmeans(dataset_diversity_8[,2:35], 5)
aggregate(dataset_diversity_8[,2:35], by = list(fit_kmeans$cluster), FUN = mean)
finalData = data.frame(dataset_diversity_8[,2:35], fit_kmeans$cluster)


library(cluster)
clusplot(dataset_diversity_8[,2:35], fit_kmeans$cluster, color = TRUE, shade = TRUE, labels = 2, lines = 0)


