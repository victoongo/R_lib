library(ggplot2)
library(plyr)
library(dplyr)
library(doBy)
library(reshape2)
library(xtable)
library(foreign)

setwd("~/Dropbox/Projects/R_lib/eye_tracking/data")
et<-import.xls("Eye_Tracking_Test.xlsx", as.is=TRUE)

options(java.parameters = "-Xmx1024m")
require(xlsx)
read.xlsx("Eye_Tracking_Test.xlsx", sheetName = "Data")
read.xlsx2("Eye_Tracking_Test.xlsx", sheetName = "Data")

require(XLConnect)
wb = loadWorkbook("Eye_Tracking_Test.xlsx")
df = readWorksheet(wb, sheet = "Data", header = TRUE)

require(gdata)
df = read.xls("Eye_Tracking_Test.xlsx", sheet = 1, header = TRUE)


library("openxlsx")
mydf <- read.xlsx("Eye_Tracking_Test.xlsx")
, sheet = 'data', startRow = 2, colNames = TRUE)
