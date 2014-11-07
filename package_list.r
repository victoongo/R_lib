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

# Data Mining
install.packages('rpart')
install.packages('party')
install.packages('DMwR')
install.packages('GGally')

# Machine Learning
install.packages('randomForest')

# epi450k
source("http://bioconductor.org/biocLite.R")
biocLite("limma")
biocLite("bioDist")
biocLite("preprocessCore")
biocLite("dplR")

install.packages('WriteXLS')
install.packages('XML')
install.packages('gmp')
install.packages("IMA",repos=c("http://rforge.net"))
