## 算每个样本中的每个物种的相对丰度，用绝对值/每个样本丰度的总和

args<-commandArgs(T)

a=read.table(args[1],header=T,row.names=1,sep="\t",quote = "")
sum_a<-matrix(nrow=nrow(a),ncol=ncol(a))
#col.names(sum_a)=col.names(a)

for(i in 1:ncol(a)){
	for(j in 1:nrow(a)){
		sum_a[j,i]=a[j,i]/sum(a[1:nrow(a),i])## 除以每一列之和
	}
}
data<-as.matrix(sum_a)
colnames(data)=colnames(a)
rownames(data)=rownames(a)

write.table(data,args[2],sep="\t",row.names=T,col.names=NA,quote=F)
