args=commandArgs(T)
	        if (length(args) != 2 ){ print("Rscript pca_plot.r 'table.xls' 'output.xls'")
				q()
			}
data=read.table(args[1],header=T,row.names=1,check.names=F,sep='\t')
#data1=data[1:(ncol(data)-1)]
data1=data
pca <- prcomp(data1,scale=T)
var=summary(pca)[[6]][1:2,]
mat=summary(pca)[[2]]
colname=colnames(mat)
rowname=rownames(mat)
result1=rbind(mat,var[2,])
result=rbind(result1,var[1,])
write.table(matrix(c('group',colname),1,),args[2],sep='\t',quote=F,col.names=F,row.names=F)
write.table(result,args[2],sep='\t',quote=F,col.names=F,row.names=c(rowname,'Proportion of Variance','Standard deviation'),append=T)


