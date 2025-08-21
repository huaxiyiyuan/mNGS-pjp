
library(ape)

args<-commandArgs(T)

input<-read.table(args[1], header=T, row.names=1)
input<-as.matrix(input)
output<-pcoa(input,correction="none", rn=NULL)
pcoa<-output$vectors[,1:3]
num<-output$values[,"Relative_eig"]
num
write.table(pcoa,args[2], sep="\t", row.names=T, col.names=NA,quote=F)
