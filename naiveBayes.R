library(e1071)


# read csv files
trainset = read.csv("result.csv", header = TRUE, sep = ",")
testset = read.csv("testresult.csv", header = TRUE, sep = ",")

train_attr = trainset[,4:9]
test_attr = testset[,4:8]

# fit the model
NB_model = naiveBayes(as.factor(exist)~fromout + fromin + toout + toin, data = train_attr)
NB_pred = predict(NB_model, test_attr)


write.csv(NB_pred, file = "Submission.csv")

# This submission yields an accuracy of 53%