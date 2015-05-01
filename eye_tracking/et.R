library(ggplot2)
library(plyr)
library(dplyr)
library(doBy)
library(reshape2)
library(xtable)
library(readxl)

setwd("~/Dropbox/Projects/R_lib/eye_tracking/data")
et <- read_excel("Eye_Tracking_Test.xlsx")

names(et)
apply(et, 2, class)
