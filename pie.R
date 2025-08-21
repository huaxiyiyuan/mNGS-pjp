args <- commandArgs(TRUE)
if (length(args) != 4){
		print("Rscript pie.R <InFile> <OutFile> <Title> <Percentage(T/F)>")
		print("Example : Rscript pie.R PieTest.txt PieTest.pdf Test T")
		q()
}

data<-read.table(args[1],header = FALSE,stringsAsFactors = FALSE, row.names = 1, check.names = FALSE,quote = "",sep="\t") #######read data

library(RColorBrewer)
n=c(brewer.pal(9,"Set1"),brewer.pal(3,"Accent"),brewer.pal(8,"Dark2"))
strright=max(strwidth(rownames(data),units="inches",cex=1.5,font=2))+0.3
graphics.off()
unlink("Rplots.pdf")
figwidth = 7 + strright
figheight = 7
pdf(args[2],height = figheight,width = figwidth) ###get height and width of figures
xy<-par(font=2,mai=c(0.5,0.5,0.5,strright),font.main=2,cex.main=2,"usr")

pie.sales<-data[,1]
if (as.character(args[4])) labels=paste(sprintf("%.1f",pie.sales*100),"%") else labels=NA

pie(pie.sales,
	labels=labels,
	col=n[1:nrow(data)],
	border=NA,
	main=args[3]
   ) 
legend(x=xy$usr[2L]-xinch(0.2)+0.3,y=xy$usr[4L],legend=rownames(data),bty='n',pch=15,col=n[1:nrow(data)],cex=1,xpd=T)
par(xy)
dev.off()

