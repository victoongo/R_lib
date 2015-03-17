library(dplyr)
library(knitr)
library(xtable)
setwd('~/Dropbox/Projects/R_lib/niches/data')

dict <- read.csv('NICHESParentSurvey_DataDictionary_2015-03-17.csv')

names(dict)[1] <- "Var.Nam"
dicts <- dict[, c(1,2,5)]
dicts$Field.Label <- gsub("&nbsp", "", dicts$Field.Label)
dictdaswasi <- dicts[dicts$Form.Name!='niches_parent_survey',]
rownames(dictdaswasi) <- 1: nrow(dictdaswasi)

knit2html('../varlist.Rmd')

source('NICHESParentSurvey_R_2015-03-17_1526.r')

names(data)[grep("das", names(data))]
names(data)[grep("wasi", names(data))]
