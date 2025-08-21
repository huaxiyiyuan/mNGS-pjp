library("ggplot2")
library("grid")
library("gtable")
args<-commandArgs(T)

pc_table1 <- read.table(args[1],header = T,row.names = 1,sep="\t")


pc1 = "PCoA1 ( 35.40%)"
pc2 = "PCoA2 ( 16.68%)"
gnum <- nlevels(as.factor(pc_table1[,3]))
gcol <- rainbow(gnum)

pdf(args[2])
ggplot(data=pc_table1,aes(x=PCoA1,y=PCoA2)) + 
    geom_point(size=7,shape=21,aes(fill=Group),colour="#FFFFFF") +
    scale_fill_manual(values=gcol) + 
    xlab(pc1) + ylab(pc2) + 
    geom_vline(xintercept=0,linetype="longdash") + 
    geom_hline(yintercept=0,linetype="longdash") +
    labs(fill="Group")+
    theme_set(theme_bw())+
    theme(panel.grid.major=element_line(colour=NA))+
    theme(panel.grid.minor=element_line(colour=NA))+
    theme(axis.text.x=element_text(size=14,colour="black"),
          axis.text.y=element_text(size=14,colour="black"),
          axis.title.x=element_text(size=18),
          axis.title.y=element_text(size=18),
          #legend.key=element_rect(colour="black",size=0.2),
          panel.border=element_rect(fill=NA),
          legend.key.size=unit(1,'cm'),
          legend.text=element_text(size=18,colour="black",family="Times",face="plain"),
          legend.title=element_text(size=20,colour="black",family="Times",face="plain"))+
	theme_bw()+
   theme(panel.grid =element_blank())


