library(glmnet)


exist_label <- as.factor(trainset$exist);
exist <- trainset$exist;
fromin <- trainset$fromin;
fromout <- trainset$fromout;
toin <- trainset$toin;
toout <- trainset$toout;
fromrate <- trainset$fromrate;
torate <- trainset$torate;
width <- trainset$width;
cofrom <- trainset$cofrom;
coto <- trainset$coto;

df = data.frame(fromin, fromout, toin, toout, fromrate, torate, width, cofrom, coto);
df_std = scale(df)

glmmod <- glmnet(df_std, exist_label, alpha = 1, family = 'binomial')

plot(glmmod, xvar="lambda")
grid()

glmmod
coef(glmmod)[,10]
cv.glmmod <- cv.glmnet(df_std, exist, alpha = 1)
plot(cv.glmmod)
best_lambda <- cv.glmmod$lambda.min
best_lambda
coef(glmmod)[,10]
cv.glmmod <- cv.glmnet(df_std, exist_label, alpha = 1)