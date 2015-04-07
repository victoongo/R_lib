setwd('~/niches/SOURCE_DATA')

files <- list.files()
txt.files <- files[grep('.txt$', files)]
txt.files <- txt.files[-grep('NEST1.txt', txt.files)]
txt.names <- sub('.txt$', '', txt.files)

# read invidiual file as a df
for (i in 1:length(txt.files)) {
  assign(txt.names[i], read.table(txt.files[i], header=T, as.is=T, fill=T))
}
# put all df in a list
list.df <- mget(txt.names, envir=globalenv())

# this makes each file a data frame in a list
# list.df <- list()
# for (i in 1:length(txt.files)) {
#   t <- read.table(txt.files[i], header=T, as.is=T, fill=T)
#   # d[txt.names[[i]]] <- append(d, t) # this makes each var as a list item
#   list.df[[txt.names[[i]]]] <- t
# }

all <- Reduce(function(...) merge(..., all=T), list.df)

# example code, can't exclude files
# multmerge = function(mypath){
#   filenames=list.files(path=mypath, full.names=TRUE)
#   datalist = lapply(filenames, function(x){read.csv(file=x,header=T)})
#   Reduce(function(x,y) {merge(x,y)}, datalist)
# }
# mymergeddata = multmerge(".")

# this works well too
# multmerge = function(filenames){
#   # filenames=list.files(path=mypath, full.names=TRUE)
#   datalist = lapply(filenames, function(x){read.table(file=x, header=T, as.is=T, fill=T)})
#   Reduce(function(x,y) {merge(x,y, all=T)}, datalist)
# }
# all <- multmerge(txt.files)