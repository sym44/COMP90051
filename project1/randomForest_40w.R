library(randomForest)

rf_model <- randomForest(as.factor(exist)~df$fromin+df$fromout+df$toin+df$toout+df$fromrate
                         +df$torate+df$width+df$cofrom+df$coto, ntree = 30);
rfcv(df, as.factor(exist), cv.fold = 10)

