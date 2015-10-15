library(gdata);
library(ggplot2)

# All medical attributes without categorical attributes
medical_ds = read.xls("medical.xlsx", sheet = 2, header = TRUE);

d = dist(medical_ds[,2:185]);
fit = cmdscale(d, eig = TRUE, k = 2);

x = fit$points[,1];
y = fit$points[,2];
plot(x, y, main = "dataset_medical_classical_MDS", xlab = "Coordinate 1", ylab = "Coordinate 2", pch = 19);
text(x, y, labels = dataset_diversity[,1], cex = .7, pos = 3)


# All medical attributes without categorical attributes less 2007, 2012 population
medical_ds_2 = read.xls("medical.xlsx", sheet = 3, header = TRUE);

d = dist(medical_ds_2[,2:170]);
fit = cmdscale(d, eig = TRUE, k = 2);

x = fit$points[,1];
y = fit$points[,2];
plot(x, y, main = "dataset_medical_2_classical_MDS", xlab = "Coordinate 1", ylab = "Coordinate 2", pch = 19);
text(x, y, labels = medical_ds_2[,1], cex = .7, pos = 3)


# All medical attributes without categorical attributes less 2007, 2012 population less many other unrelated
medical_ds_3 = read.xls("medical.xlsx", sheet = 5, header = TRUE);

d = dist(medical_ds_3[,2:58]);
fit = cmdscale(d, eig = TRUE, k = 2);

x = fit$points[,1];
y = fit$points[,2];
plot(x, y, main = "dataset_medical_3_classical_MDS", xlab = "Coordinate 1", ylab = "Coordinate 2", pch = 19);
text(x, y, labels = medical_ds_3[,1], cex = .7, pos = 3)


# All medical attributes without categorical attributes less 2007, 2012 population less many other unrelated
medical_ds_4 = read.xls("medical.xlsx", sheet = 8, header = TRUE);

d = dist(scale(medical_ds_4[,2:43]));
fit_medical = cmdscale(d, eig = TRUE, k = 2);

x = fit_medical$points[,1];
y = fit_medical$points[,2];
plot(x, y, main = "medical_classical_MDS", xlab = "x1", ylab = "x2", pch = 19);
text(x, y, labels = medical_ds_4[,1], cex = .7, pos = 3)



fit_medical_kmeans = kmeans(fit_medical$points, 4, iter.max = 500)
cluster = factor(fit_medical_kmeans$cluster)
centers = as.data.frame(fit_medical_kmeans$centers)
aggregate(fit_medical$points, by = list(fit_medical_kmeans$cluster), FUN = mean)
finalData = data.frame(fit_medical$points, fit_medical_kmeans$cluster)

ggplot(data = education_ds_2[,2:38], aes(x = fit_medical$points[,1], y = fit_medical$points[,2], color = cluster, label = medical_ds_4[,1])) + geom_point() + geom_text(size = 3)
