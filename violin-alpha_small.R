library(ggplot2)
library(ggpubr)

args<-commandArgs(T)

data=read.table(args[1],header=T,sep="\t")
pdf(args[2],w=10)


my_comparisons <- list(c("PJP","PJC"),c("PJP","OTH"),c("PJC","OTH"))
ggviolin(data,x="group",y="value",fill="group",color = NA)+
#ggviolin(data,x="group",y="value",fill="group",levels=c("Mild","Common","Severe","Critical"))+
geom_boxplot(width=0.1)+    ### 根据情况修改
stat_compare_means(comparisons=my_comparisons, method = "wilcox.test")+
labs(x="Group",y="Value",title="") +
theme(legend.position = "none") +
theme_bw() +
theme(panel.grid =element_blank()) +
theme(axis.text.x = element_text(size = 16),axis.text.y = element_text(size = 16)) +
theme(axis.title.x = element_text(size = 16),axis.title.y = element_text(size = 16),plot.title = element_text(size=16),legend.title=element_text(size=16))+
scale_x_discrete(limits=c("PJP","PJC","OTH"))
#scale_y_continuous(limits = c(0, 1))

dev.off()
