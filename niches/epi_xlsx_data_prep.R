library(foreign)
library(sas7bdat)
library(dplyr)
library(openxlsx)
setwd('~/niches/SOURCE_DATA/Data Files Checked for outliers/')

files <- list.files()
# xlsx.files <- files[grep('.xlsx$', files)]
txt.names <- sub('.xlsx$', '', files)


# read invidiual file as a df
# for (i in 1:length(txt.files)) {
#   assign(txt.names[i], read.table(txt.files[i], header=T, as.is=T, fill=T))
# }

for (i in 1:length(files)) {
  x <- read.xlsx(files[i])
  x <- unique(x)
  xnames <- names(x)[-c(1, grep('MEAN$', names(x)))]
  xnames_mv <- paste0(xnames, "_mv")
  name <- sub('_CG[0-9]*$', '', xnames[1])
  for (n in xnames) {
    beta <- paste0("x$", n)
    f <- paste0(beta, "_mv", " <- log(", beta, "*0.01 + 0.01 /(1 - ", beta, "*0.01 + 0.01)", ", 2)")
    print(f)
    eval(parse(text=f))
    # x <- mutate(x, nm=log(n, 2))
  }
  if (length(xnames) > 1) {
    nmean <- paste0("x$", name, "_mean", " <- rowMeans(x[, c(xnames)])")
    nmvmean <- paste0("x$", name, "_mv_mean", " <- rowMeans(x[, c(xnames_mv)])")
    nmedian <- paste0("x$", name, "_median", " <- apply(x[, c(xnames)], 1, median, na.rm=F)")
    nmvmedian <- paste0("x$", name, "_mv_median", " <- apply(x[, c(xnames_mv)], 1, median, na.rm=F)")
    # print(nmedian)
    eval(parse(text=c(nmean, nmvmean, nmedian, nmvmedian)))
  }
  # x[,-c(1, grep('MEAN$', names(x)))]
  assign(txt.names[i], x)
  rm(x)
}

# put all df in a list
list.df <- mget(txt.names, envir=globalenv())
for (df in list.df) {
  print("")
  print(table(df$nestid)[table(df$nestid)>1])
}

# this makes each file a data frame in a list
# list.df <- list()
# for (i in 1:length(txt.files)) {
#   t <- read.table(txt.files[i], header=T, as.is=T, fill=T)
#   # d[txt.names[[i]]] <- append(d, t) # this makes each var as a list item
#   list.df[[txt.names[[i]]]] <- t
# }

all <- Reduce(function(...) merge(..., all=T), list.df)

# example code, can't exclude files
# multmerge <- function(mypath){
#   filenames <- list.files(path=mypath, full.names=TRUE)
#   datalist <= lapply(filenames, function(x){read.csv(file=x,header=T)})
#   Reduce(function(x,y) {merge(x,y)}, datalist)
# }
# all <- multmerge(".")

# this works well too
# multmerge <- function(filenames){
#   # filenames <- list.files(path=mypath, full.names=TRUE)
#   datalist <- lapply(filenames, function(x){read.table(file=x, header=T, as.is=T, fill=T)})
#   Reduce(function(x,y) {merge(x,y, all=T)}, datalist)
# }
# all <- multmerge(txt.files)


setwd('~/niches/SOURCE_DATA/')
alles <- read.sas7bdat('../nest_merge_tb_rc.sas7bdat')
allnew <- merge(all, alles, 'nestid', all=T)

allnew$meg3_cbs_mean_new <- allnew$meg3_cbs_mean
allnew$meg3_cbs_mean_new[is.na(allnew$meg3_cbs_mean)] <- allnew$MEG3CBS1_mean[is.na(allnew$meg3_cbs_mean)]
allnew$meg3_ig_mean_new <- allnew$meg3_ig_mean
allnew$meg3_ig_mean_new[is.na(allnew$meg3_ig_mean)] <- allnew$MEG3IG_mean[is.na(allnew$meg3_ig_mean)]


names(allnew) <- tolower(names(allnew))

write.dta(allnew, "../final_all.dta")

epinew <- merge(all, alles, 'nestid', all.x=T)
write.dta(epinew, "epinew.dta")
save(epinew, file='epinew.Rdata')

