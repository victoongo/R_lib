library(dplyr)
library(knitr)
library(xtable)
setwd('~/Projects/R_lib/niches/data')

dict <- read.csv('NICHESParentSurvey_DataDictionary_2015-03-02.csv')
names(dict)[1] <- "Var.Nam"
dicts <- dict[, c(1,2,5)]
dicts$Field.Label <- gsub("&nbsp", "", dicts$Field.Label)
dictdaswasi <- dicts[dicts$Form.Name!='niches_parent_survey',]
rownames(dictdaswasi) <- 1: nrow(dictdaswasi)

knit2html('../varlist.Rmd')

source('NICHESParentSurvey_R_2015-03-02_1521.r')

names(data)[grep("das", names(data))]
names(data)[grep("wasi", names(data))]
