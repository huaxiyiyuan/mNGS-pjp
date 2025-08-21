args = commandArgs(T)
	if (length(args) != 7){
		print("Rscript barplot.r <InFile> <OutFile> <Title> <Ylab> <beside(T/F)> <Ymax(default:NULL)> <abline(default:NULL)>")
		print("Example : Rscript barplot.r BarplotTest.txt BarplotTest.pdf Test 'Percentage(%)' T  NULL 80")
		q()
	}


source("C:/Users/Administrator/Desktop/lusf/barplotv1.r")
data = read.table(args[1],header = TRUE,stringsAsFactors = FALSE, row.names = 1, check.names = FALSE,quote = "",sep="\t")
if (args[6]=="NULL") {
	if(args[5]=="T") Ymax=max(data) else Ymax=max(colSums(data))
}else {
	Ymax = as.numeric(args[6])
}

if (args[7]=="NULL") abline=NULL else abline=as.numeric(args[7])

barplotv1(Input=args[1],
		Output=args[2],
		beside=as.character(args[5]),
		Ylab = args[4],
		Title = args[3],
		abline=abline,
		Ymax=Ymax
		)
dev.off()
