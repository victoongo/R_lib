library('ggplot2')
#library('foreign')

setwd('d:/projects/epi450k')
nestsr <- data.frame(read.csv("nestsr_iversen_24OCT2014.csv",as.is=TRUE))
str(nestsr)
nestsr
plot(nestsr$BASC_AP,nestsr$BRF_GEC)
ggplot(nestsr$BASC_AP,nestsr$BRF_GEC)
