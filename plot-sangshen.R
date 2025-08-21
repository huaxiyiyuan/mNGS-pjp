library(ggplot2)
library(ggsci)
library(ggalluvial)

args<-commandArgs(T)

data=read.table(args[1],header=T,sep="\t")
pdf(args[2],w=8)

ggplot(data,aes(x=group,y=100*value,alluvium=type,stratum=type,fill=type))+
geom_alluvium(aes(fill = type,colour=type)) +
#geom_alluvium(aes(fill = type,colour=type), decreasing = F) +  ##  中间颜色的变化面积从大到小排序
geom_stratum(alpha = 10, colour=NA) + ## 每种有柱状图
geom_flow(alpha=0)+  ## 调节中间颜色的深浅
scale_fill_igv()+   ## 用ggsci包的色块
#facet_wrap(~group,scales='free_x',ncol=2)+  ##  根据组分成两个图，把两个图水平放在一起
#geom_label(stat = "stratum", infer.label = F) + ## 设置柱状图中是否显示每个物种

labs(x="Group",y="Relative Abundance",title="") +
theme(legend.position = "none") +
#coord_flip()+  ##  水平放
theme_bw() +
theme(panel.grid =element_blank()) +

theme(axis.text.x = element_text(size = 16),axis.text.y = element_text(size = 16)) +
theme(axis.title.x = element_text(size = 16),axis.title.y = element_text(size = 16),plot.title = element_text(size=16),legend.title=element_text(size=16))+
scale_x_discrete(limits=c("Blood","Balf"))

#theme_minimal() 
