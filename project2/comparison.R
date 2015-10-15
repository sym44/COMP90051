library(fpc)

attach(fit_medical_kmeans)
attach(fit_education_kmeans)
attach(fit_diversity_kmeans)


fit_diversity_kmeans$cluster


cluster.stats(d, fit_medical_kmeans$cluster, fit_diversity_kmeans$cluster)
