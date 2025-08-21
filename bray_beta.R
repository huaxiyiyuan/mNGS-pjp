library(vegan)
library(picante)

args<-commandArgs(T)

data=read.table(args[1], header=T, row.names=1, sep="\t", stringsAsFactors = FALSE, check.names = FALSE)

spe<-t(data)

bray.dist<-vegdist(spe,method="bray")

#head(bray.dist)#查看结果的前几行

#[1] 0.1264733 0.1965461 0.1359208 0.3141063 0.5082709 0.1527615



write.table(as.matrix(bray.dist),file=args[2],sep="\t",col.names=NA, quote = F)

bray.dist.ln<-vegdist(log1p(spe))#此处是log1p（数字1）

#head(bray.dist.ln)

write.table(as.matrix(bray.dist.ln),file=args[3],sep="\t",col.names=NA, quote = F)

