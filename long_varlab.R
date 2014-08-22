
argv <- commandArgs(TRUE)
path <- argv[1]

print(path)

library("foreign")
mydata<-read.spss(paste(path,".sav",sep=""))

names(mydata)
var.labels <- attr(mydata,"variable.labels")
var.labels
data.key <- data.frame(var.name=names(mydata),var.labels)
data.key <- data.frame(var.labels)
data.key
write.table(data.key, paste(path,"_labels.txt",sep=""), sep="\t")


print(data.key)