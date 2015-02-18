# data manipulation
install.packages('doBy')
install.packages('Hmisc')
install.packages('dplyr')
install.packages('tidyr')
install.packages('sqldf')
install.packages('plyr','stringr','lubridate')
install.packages('reshape2')

# working with other language
install.packages('rpy2')

# HP:
  # mem
  install.packages('biglm')

  # CPU
  install.packages('doParallel')
  install.packages('multicore')

  # GPU
  #install.packages('WideLM') # older R only
  #install.packages('gputools')

# Presenting Info
install.packages('xtable')
install.packages('R2HTML')
install.packages('shiny')
install.packages('knitr')

# Viz
install.packages('ggplot2')
install.packages('qqman')
install.packages('mhtplot2') # older R only
install.packages('gclus')
install.packages('RColorBrewer')
install.packages('maps')
install.packages('ggvis')

# Data Mining
install.packages('rpart')
install.packages('party')
install.packages('DMwR')
install.packages('GGally')
install.packages('tm')
install.packages('wordcloud')

# Machine Learning
install.packages('randomForest')
install.packages('caret')
install.packages('e1071', dependencies=TRUE)
install.packages('AppliedPredictiveModeling')
install.packages('rpart.plot')
install.packages('rattle')
install.packages('pgmm')
install.packages('tree')

# DB
install.packages('sqldf')
install.packages('RSQLite')
install.packages('RSQLite','RODBC','RMySQL','RPostresSQL','RMongo')

# epi450k
source("http://bioconductor.org/biocLite.R")
biocLite("limma")
biocLite("bioDist")
biocLite("preprocessCore")
biocLite("dplR")
  install.packages('XML')
  install.packages('gmp')
biocLite("rhdf5")

install.packages('WriteXLS')
install.packages("IMA",repos=c("http://rforge.net"))

# data types
install.packages('data.table')
install.packages('xlsx')
install.packages('XLConnect')
install.packages('jsonlite')
install.packages('jpeg','readbitmap','png')
install.packages('rdgal','rgeos','raster')
install.packages('tuneR','seewave')
install.packages('')

# network
install.packages('RCurl')
install.packages('httr')

# 10 list
install.packages('sqldf') # pandasql for python
install.packages('forecast')
install.packages('plyr','stringr','lubridate') #install.packages('stringi')
install.packages('qcc','reshape2','randomForest')
install.packages('RSQLite','RODBC','RMySQL','RPostresSQL','RMongo')


install.packages('WriteXLS')
install.packages("IMA",repos=c("http://rforge.net")) # no IMA binary for R3.1 in Windows

# PCA (prcomp and varimax)

# MLM
install.packages('car')

# Bayesian
install.packages('MCMCpack')

# SITAR
install.packages('sitar')
install.packages('quantreg')
install.packages('gamlss')
install.packages('nlme')
install.packages('lme4')
install.packages('multcomp')

