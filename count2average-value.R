##  算每个物种在所有样本中的平均值

args<-commandArgs(T)

a=read.table(args[1],header=T,row.names=1,sep="\t",quote = "")
sum_a<-matrix(nrow=nrow(a),ncol=1)
for(i in 1:nrow(a)){
	sum_a[i,1]=sum(a[i,1:ncol(a)])/ncol(a)
}
out<-data.frame(a,sum_a)
data<-as.matrix(out)
write.table(data,args[2],sep="\t",row.names=T,col.names=NA,quote=F)

