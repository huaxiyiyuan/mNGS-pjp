library(ggplot2)
library(ggpubr)
library(dplyr)
library(reshape2)
library(stringr)
library(utils)

args = commandArgs(T)

##4  Prevotella
data2<-read.table(args[1],header=T,stringsAsFactors=F,check.names=F,sep="\t")
#pdf("Prevotella.pdf",w=18,h=5)
#pdf(args[2],w=15,h=6)
pdf(args[2],w=12,h=6)
ggplot(data=data2, aes(x=P.jirovecii, y=CD4 ,color=Type))+
geom_point(pch=16, size=4)+
stat_smooth(method="lm",color="black", linetype=1)+
stat_cor(data=data2, method = "spearman",position = "identity",na.rm =T,label.x.npc= "left")+
labs(title="", x="P.jirovecii-Relative Abundance", y="CD4 Value")+
#facet_grid(Type ~ .,scales="free_y") +   #  纵向堆叠
facet_grid(. ~ Type,scales="free_x") +    #  横向堆叠
theme_bw()+
#theme(panel.grid =element_blank())+
theme(axis.text.x = element_text(size = 18),axis.text.y = element_text(size = 18),strip.text.y = element_text(size=18, face="bold"))+
theme(axis.title.x = element_text(size = 18),axis.title.y = element_text(size = 18),plot.title = element_text(size=18),legend.title=element_text(size=18),)


dev.off()
