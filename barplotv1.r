

#########################################function
barplotv1<-function(Input = NULL,
		Output = NULL, 
		Title = "BarplotV1",
		Ylab = "BARPLOT",
		Ymax = NULL,
		abline = NULL,
		beside = T)
{		
	if (file.exists(Input)){
		data = read.table(Input,header = TRUE,stringsAsFactors = FALSE, row.names = 1, check.names = FALSE,quote = "",sep="\t")
	} else {
		stop ("Please input files!")
	}
	library(RColorBrewer);
	n=c(brewer.pal(10,"Paired"),brewer.pal(3,"Dark2"),brewer.pal(8,"Set2"),brewer.pal(6,"Accent"),brewer.pal(8,"Dark2"),brewer.pal(11,"Spectral"),brewer.pal(8,"Set3"),brewer.pal(4,"Pastel2"));
	srtbottom=max(strwidth(colnames(data),units="inches",cex=1.5,font=2))+0.2
	if(nrow(data)>1) strright=max(strwidth(rownames(data),units="inches",cex=1.5,font=2))+0.3 else strright =1   ## (0.5 => 0.3)
	graphics.off()
	unlink("Rplots.pdf")
	if(beside) figheight = srtbottom + 7 else figheight = srtbottom + 8
	if(beside) figwidth=2+0.3*(ncol(data)*(nrow(data)+1)) + strright else figwidth = 5 + 0.24*(ncol(data)+1) + strright   ##(0.3*  =>  0.24*) 每个柱子的宽度
	pdf(Output,height = figheight+2,width = figwidth)
	lll=strright/3 +2
	par(font=2,font.axis=2,font.lab=2,cex.axis=1.5,cex.lab=1.5,cex.main=2,mai=c(srtbottom+4,1.2,1,lll))
	if (beside){
			colnames=colnames(data);
			colnames(data)=NULL;
			if(is.null(Ymax)) Ylim=c(0,max(data)) else Ylim=c(0,as.numeric(Ymax))
			barplot(
					as.matrix(data),
					beside = T,
					col = n[1:nrow(data)],
					ylab="",
					border=NA,
					ylim = Ylim,
					main=Title,
					axes=F
				)
			xy<-par("usr")
			if(nrow(data)>1) legend(x=xy[2L]+8.5,y=xy[4L],rownames(data),bty="n",xpd=T,pch=22,col="white",cex=0.8,pt.cex=2,pt.bg=n[1:nrow(data)],ncol=1,xjust=0.5,yjust=0.5)
			axis(2,line=0.5)
			mtext(side=2,line=3.5,Ylab,cex=1.5)
			at = colMeans(barplot(as.matrix(data),beside = T,plot = F,ylim = Ylim))
			text(at,-yinch(0.1),colnames,xpd=T,srt=45,adj=1,cex=1.5)
			if(!is.null(abline)) abline(h=as.numeric(abline),col="red",lwd=2,lty="dashed");
	} else {
			colnames=colnames(data);
			colnames(data)=NULL;
			if(is.null(Ymax)) Ylim=c(0,max(colSums(data))) else Ylim=c(0,as.numeric(Ymax))
			barplot(
					as.matrix(data),
					beside = F,
					col = n[1:nrow(data)],
					ylab="",
					ylim=Ylim,
					border='NA',
					main=Title,
					axes=F
					)
			xy<-par("usr")

			at=barplot(as.matrix(data),beside = F,plot = F,ylim = Ylim);
			if(nrow(data)>1) legend(x=at[length(at)]-(at[2]-at[1])+11,y=0.4,rev(rownames(data)),bty="n",xpd=T,pch=22,pt.bg=rev(n[1:    nrow(data)]),cex=0.85,pt.cex=2.5,col="white",ncol=1,xjust=0.9,yjust=0.5,y.intersp=1.3,x.intersp=1);
			axis(2,line=0.5);  ### 图标的横坐标从4.5 改到 11 （20250604）
			mtext(side=2,line=3.5,Ylab,cex=2)
			text(at,-yinch(0.1),colnames,xpd=T,srt=45,adj=1,cex=1.5);
			if(!is.null(abline)) abline(h=as.numeric(abline),col="red",lwd=2,lty="dashed");
	}
}
