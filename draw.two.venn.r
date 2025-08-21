args = commandArgs(T)
if (length(args) != 2){
	print("Rscript draw.triple.venn.r <InFile> <OutFile>")
	print("Example : Rscript draw.two.venn.r two.txt two.pdf")
	q()
}

pdf(args[2])
data<-read.table(args[1],stringsAsFactors = FALSE,check.names = FALSE,quote = "",sep="\t")
library(VennDiagram)
venn.plot <- draw.pairwise.venn(
		area1 = data[1,2],
		area2 = data[2,2],
		cross.area = data[3,2],
		category = data[1:2,1],
		fill = c("red","blue"),
		lty = "blank",
		euler.d = F,
		scaled = F,
		cat.pos = c(0,0),
		cex = 2,
		cat.cex = 2,
		cat.col ="black" 
		)
dev.off()
