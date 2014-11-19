# the sample data here: http://de.iplantcollaborative.org/dl/d/DDEE604B-D690-41A9-86E1-25138CDC1D9E/gwas.zip

# 1. Set Working Directory and load ggplot2

setwd('/home/your_iplant_username/Desktop/gwas_examples')
# 2. Import p-values from previous analysis

pVals <- read.csv('ricePvals.csv', row.names=1)
# 3. Calculate -log10 of pvals, which is what will be plotted

pValsLog10 <- -log10(pVals)
# 4. Import rice map

riceMap <- read.csv('sativas413map.csv')
# 5. Bind the two together. This will making plotting using ggplot2 functions easier

rcMpPvals <- cbind(riceMap, pValsLog10)
 
colnames(rcMpPvals) <- c('mrk', 'chr', 'pos', 'logp')
# 6. Position is defined as position on chromosome. Need to add largest position from last marker on previous chr so that markers are ordered correctly along x-axis

chrNum=12
 
for (i in 1:chrNum){ ndx <- which(rcMpPvals[, 2]==i)
  lstMrk <- max(rcMpPvals[ndx, 3])
  if (i < chrNum) ndx2 <- which(rcMpPvals[, 2]==i+1)
  if (i < chrNum) rcMpPvals[ndx2, 3] <- rcMpPvals[ndx2, 3] + lstMrk
}
# 7. Use this little loop to find the midposition of every chromosome so nice chr labels can be added to the plot

bpMidVec <- vector(length=chrNum)
 
for (i in 1:chrNum){ndx <- which(rcMpPvals[, 2]==i)
posSub <- rcMpPvals[ndx, 3]
bpMidVec[i] <- ((max(posSub) - min(posSub))/2) + min(posSub)
}
# 8. Use qplot function in ggplot2 to create Manhattan plot. You don't need to continually create new plot objects and add components to them. This is just done here for tutorial purposes. All of these components can be added in one line.

p <- ggplot(rcMpPvals)
(p2 <- p + geom_point(aes(x=pos, y=logp, size=3.5, colour=as.factor(chr)), alpha=1/3))
(p3 <- p2 + scale_color_manual(values=rep(c('black', 'dark green'), 6)))
(p4 <- p3 + theme_bw(base_size=15))  
(p5 <- p4 + theme(legend.position='none'))  
(p6 <- p5 + scale_x_continuous(labels=as.character(1:chrNum), breaks=bpMidVec))  
(p7 <- p6 + geom_hline(y=4.08, linetype=1, col='red', lwd=1.5))
(p8 <- p7 + ggtitle('Rice Flowering Time') + xlab('') + ylab('-log10(P)'))