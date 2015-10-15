library(gdata);
library(ggplot2)

# All medical attributes without categorical attributes
location_ds = read.xls("location.xlsx", sheet = 3, header = TRUE);

d = dist(location_ds[,2:77]);
fit = cmdscale(d, eig = TRUE, k = 2);

x = fit$points[,1];
y = fit$points[,2];
plot(x, y, main = "dataset_location_classical_MDS", xlab = "Coordinate 1", ylab = "Coordinate 2", pch = 19);
text(x, y, labels = dataset_diversity[,1], cex = .7, pos = 3)
