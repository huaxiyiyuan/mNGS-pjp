library(ggplot2)
library(ggpubr)

args<-commandArgs(T)

data=read.table(args[1],header=T,sep="\t")
pdf(args[2],w=10)


my_comparisons <- list(c("Death","Alive"))  ## 分组根据实际情况进行更改
ggviolin(data,x="group",y="value",fill="group",color = NA)+
geom_boxplot(width=0.1)+
stat_compare_means(comparisons=my_comparisons, method = "wilcox.test")+
labs(x="Group",y="Relative Abundance",title="") +   ## y坐标的标签，根据实际情况进行更改
#labs(x="Group",y="RPM",title="") +   ## y坐标的标签，根据实际情况进行更改
theme(legend.position = "none") +
theme_bw() +
theme(panel.grid =element_blank()) +
theme(axis.text.x = element_text(size = 16),axis.text.y = element_text(size = 16)) +
theme(axis.title.x = element_text(size = 16),axis.title.y = element_text(size = 16),plot.title = element_text(size=16),legend.title=element_text(size=16))+
scale_x_discrete(limits=c("Death","Alive"))   ## 分组根据实际情况进行更改

dev.off()
