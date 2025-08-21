args<-commandArgs(T)




HRV<- read.table(args[1],header=T,sep="\t")


p_value_HRV<-matrix(nrow=nrow(HRV),ncol=1)


for(i in 1:nrow(HRV)){
        blood<-HRV[i,2:74]
	    balf<-HRV[i,75:147]
	    x<-as.numeric(blood)
        y<-as.numeric(balf)   
		wtest<-wilcox.test(x,y,conf.level=0.95)
        p_value_HRV[i,]<-wtest$p.value
    
}
HRV_pvalue<-data.frame(HRV,p_value_HRV)
data_test = as.matrix(HRV_pvalue)
write.table(data_test,args[2] , quote=F, sep="\t", row.names=T, col.names=NA)
