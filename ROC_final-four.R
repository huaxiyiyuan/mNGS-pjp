library(pROC)
library(ggplot2)
args<-commandArgs(T)

pdf(args[5])

aSAH1=read.table(args[1],header=T)

aSAH2=read.table(args[2],header=T)

aSAH3=read.table(args[3],header=T)

aSAH4=read.table(args[4],header=T)



rocobj1 <- plot.roc(aSAH1$group,  aSAH1$value, percent=F, print.auc = T, col = "red" ,thresholds="best", print.thres="best" )


rocobj2 <- plot.roc(aSAH2$group,  aSAH2$value, percent=F, print.auc = T, col = "blue", print.auc.y = .4, add = TRUE ,thresholds="best", print.thres="best" )


rocobj3 <- plot.roc(aSAH3$group,  aSAH3$value, percent=F, print.auc = T, col = "green", print.auc.y = .4, add = TRUE ,thresholds="best", print.thres="best" )


rocobj4 <- plot.roc(aSAH4$group,  aSAH4$value, percent=F, print.auc = T, col = "purple", print.auc.y = .4, add = TRUE ,thresholds="best", print.thres="best" )




legend("bottomright", legend=c("mNGS-blood", "mNGS-balf","PCR-blood", "PCR-balf"), col=c("red", "blue","green", "purple"), lwd=2)




roc1 <- roc(aSAH1$group,  aSAH1$value)
roc2 <- roc(aSAH2$group,  aSAH2$value)
roc3 <- roc(aSAH3$group,  aSAH3$value)


ci_auc1 <- ci.auc(roc1)
ci_auc2 <- ci.auc(roc2)
ci_auc3 <- ci.auc(roc3)


ci_auc1
ci_auc2
ci_auc3



test1 <- roc.test(roc1, roc2)
test2 <- roc.test(roc1, roc3)
test3 <- roc.test(roc2, roc3)

test1$p.value
test2$p.value
test3$p.value


test1
test2
test3


 DeLong's test for two ROC curves

data:  roc1 and roc2
D = 1.6255, df = 99.34, p-value = 0.1072
alternative hypothesis: true difference in AUC is not equal to 0
sample estimates:
AUC of roc1 AUC of roc2
  0.8466667   0.6933333


        Bootstrap test for two ROC curves

data:  roc1 and roc3
D = 0.47502, boot.n = 2000, boot.stratified = 1, p-value = 0.6348
alternative hypothesis: true difference in AUC is not equal to 0
sample estimates:
AUC of roc1 AUC of roc2
  0.8466667   0.8116667


        Bootstrap test for two ROC curves

data:  roc2 and roc3
D = -1.1963, boot.n = 2000, boot.stratified = 1, p-value = 0.2316
alternative hypothesis: true difference in AUC is not equal to 0
sample estimates:
AUC of roc1 AUC of roc2
  0.6933333   0.8116667




#添加AUC值、置信区间和p值


#text(0.7, 0.2, col= "red", labels = paste("AUC =", round(rocobj1$auc[[1]], 3), "\n95% CI: [", round(ci_auc1$lower, 3), ", ", round(ci_auc1$upper, 3), "]" ))
#text(0.7, 0.2, col= "blue", labels = paste("AUC =", round(rocobj2$auc[[1]], 3), "\n95% CI: [", round(ci_auc2$lower, 3), ", ", round(ci_auc2$upper, 3), "]" ))
#text(0.7, 0.2, col= "purple", labels = paste("AUC =", round(rocobj3$auc[[1]], 3), "\n95% CI: [", round(ci_auc3$lower, 3), ", ", round(ci_auc3$upper, 3), "]"))