library(vegan)
library(reshape2)



args<-commandArgs(T)

a <- read.table(args[1], header=T, row.names=1, sep="\t", stringsAsFactors = FALSE, check.names = FALSE)

Aspe = t(a)


#Aspe

group=read.table(args[2], header=T, row.names=1, sep="\t", stringsAsFactors = FALSE, check.names = FALSE)

# 3. α-多样性指数计算
## 3.1 Shannon.Wiener index
A.shannon=diversity(Aspe,index="shannon")


## 3.2 Simpson index
A.Simpson=diversity(Aspe,index="simpson")


## 3.3 Inverse Simpson index
A.inv=diversity(Aspe,index="inv")


## 3.4 S
A.s=specnumber(Aspe)


## 3.5 Pielou Eveness index
A.pie=A.shannon/log(A.s)


## 3.6 合并多样性指数
A.div=data.frame(A.shannon,A.Simpson,A.pie,A.s,A.inv)



## 3.7 输出为表格形式

write.table(A.div, args[3], sep="\t",row.names=T,col.names= NA, quote=F)




