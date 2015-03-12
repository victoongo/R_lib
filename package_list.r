install.packages("devtools")


# data manipulation
install.packages('doBy')
install.packages('Hmisc')
install.packages('dplyr')
install.packages('tidyr')
install.packages('sqldf')
install.packages('plyr','stringr','lubridate')
install.packages('reshape2')
install.packages('pryr')

# working with other language
install.packages('rpy2')

# HP:
  # cluster computing
  library(devtools)
  install_github("amplab-extras/SparkR-pkg", subdir="pkg")
  SPARK_VERSION=1.3.0 ./install-dev.sh
  SPARK_HADOOP_VERSION=2.0.0-mr1-cdh4.2.0 ./install-dev.sh
  USE_MAVEN=1 ./install-dev.sh

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
install.packages('knitr')
install.packages('googleVis')
library(devtools)
install_github('rstudio/shiny')
install_github('rstudio/shinyapps')
install_github('ramnathv/rCharts')
install_github('rstudio/DT')
install_github('rstudio/leaflet')

library(devtools)
install_github('slidify', 'ramnathv')
install_github('slidifyLibraries', 'ramnathv')


# Viz
install.packages('ggplot2')
install.packages('qqman')
install.packages('mhtplot2') # older R only
install.packages('gap')
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
install.packages('ElemStatLearn')

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
biocLite("qvalue")

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

# Stats
  # PCA (prcomp and varimax)
  # MISC
  install.packages('bootstrap')
  install.packages('leaps')
  # diagnostic
  install.packages('DAAG')
  install.packages('relaimpo')
  install.packages('gvlma')

  # MLM
  install.packages('car')

  # Bayesian
  install.packages('MCMCpack')
  install.packages('BAS') # removed from CRAN, couldn't fine hlasso
  install.packages('BMA')
  install_github('merliseclyde/oda')
  install.packages('gglasso')
  install.packages('genlasso')

  # penalized likelihood

  # SITAR
  install.packages('sitar')
  install.packages('quantreg')
  install.packages('gamlss')
  install.packages('nlme')
  install.packages('lme4')
  install.packages('multcomp')

install.packages('UsingR')
