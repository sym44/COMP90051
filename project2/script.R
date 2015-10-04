library(gdata);

# All diversity attributes without categorical attributes
dataset_diversity = read.xls("diversity.xlsx", sheet = 2, header = TRUE);

d = dist(dataset_diversity[,2:31]);
fit = cmdscale(d, eig = TRUE, k = 2);

x = fit$points[,1];
y = fit$points[,2];
plot(x, y, main = "MDS", xlab = "Coordinate 1", ylab = "Coordinate 2", pch = 19);
text(x, y, labels = dataset_diversity[,1], cex = .7, pos = 3)
