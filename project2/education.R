library(gdata);
library(ggplot2)

# All diversity attributes without categorical attributes
education_ds = read.xls("education.xlsx", sheet = 1, header = TRUE);

d = dist(scale(education_ds[,2:67]));
fit = cmdscale(d, eig = TRUE, k = 2);

x = fit$points[,1];
y = fit$points[,2];
plot(x, y, main = "dataset_education_classical_MDS", xlab = "Coordinate 1", ylab = "Coordinate 2", pch = 19);
text(x, y, labels = dataset_diversity[,1], cex = .7, pos = 3)


# all education attributes less the population
education_ds_2 = read.xls("education.xlsx", sheet = 2, header = TRUE);

d = dist(scale(education_ds_2[,2:38]));
fit_education = cmdscale(d, eig = TRUE, k = 2);

x = fit_education$points[,1];
y = fit_education$points[,2];
plot(x, y, main = "education_classical_MDS", xlab = "x1", ylab = "x2", pch = 19);
text(x, y, labels = dataset_diversity[,1], cex = .7, pos = 3)


# all education attributes less the population and households
education_ds_3 = read.xls("education.xlsx", sheet = 3, header = TRUE);

d = dist(scale(education_ds_3[,2:31]));
fit = cmdscale(d, eig = TRUE, k = 2);

x = fit$points[,1];
y = fit$points[,2];
plot(x, y, main = "dataset_education_3_classical_MDS", xlab = "Coordinate 1", ylab = "Coordinate 2", pch = 19);
text(x, y, labels = dataset_diversity[,1], cex = .7, pos = 3)



fit_education_kmeans = kmeans(fit_education$points, 4, iter.max = 500)
cluster = factor(fit_education_kmeans$cluster)
centers = as.data.frame(fit_education_kmeans$centers)
aggregate(fit_education$points, by = list(fit_education_kmeans$cluster), FUN = mean)
finalData = data.frame(fit_education$points, fit_education_kmeans$cluster)

ggplot(data = education_ds_2[,2:38], aes(x = fit_education$points[,1], y = fit_education$points[,2], color = cluster, label = education_ds_2[,1])) + geom_point() + geom_text(size = 3)
