args<-commandArgs(T)

a=read.table(args[1],header=TRUE)
b=t(a)
write.table(b,file=args[2],row.names = TRUE,col.names = NA, sep="\t",quote=F)
