# data manipulation

# working with other language
install.packages('rpy2')

# CPU
install.packages('doParallel')


# HP: big
install.packages('biglm')

  # CPU
  install.packages('doParallel')
  
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

# Data Mining
install.packages('rpart')
install.packages('party')
install.packages('DMwR')
install.packages('GGally')

# Machine Learning
install.packages('randomForest')

# DB
install.packages('sqldf')
install.packages('RSQLite')

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

# 
install.packages('data.table')
install.packages('xlsx')
install.packages('Rcurl')
install.packages('httr')
install.packages('jsonlite')
install.packages('jpeg','readbitmap','png')
install.packages('rdgal','rgeos','raster')
install.packages('tuneR','seewave')
install.packages('')


# 10 list
install.packages('sqldf') # pandasql for python
install.packages('forecast')
install.packages('plyr','stringr','lubridate')
install.packages('qcc','reshape2','randomForest') #install.packages('stringi')
install.packages('RSQLite','RODBC','RMySQL','RPostresSQL','RMongo')


install.packages('WriteXLS')
install.packages("IMA",repos=c("http://rforge.net")) # no IMA binary for R3.1 in Windows

# PCA (prcomp and varimax)

# MLM
install.packages('car')

# SITAR
install.packages('sitar')
install.packages('quantreg')


