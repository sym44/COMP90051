library(ISLR)
library(tree)


attach(test_attr)


train_attr = trainset[,4:8]
link_label = as.factor(trainset$exist)

train_attr = data.frame(train_attr,link_label)

# fit the tree model using training data
tree_model = tree(link_label~. , data = train_attr)

plot(tree_model)
text(tree_model,pretty=0)

tree_pred = predict(tree_model, test_attr, type = "class")
mean(tree_pred != )

