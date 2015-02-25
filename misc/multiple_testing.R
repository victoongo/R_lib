library(qvalue)
pval <- c('
0.0265
0.0508
0.1282
0.1951
0.2247
0.2414
0.6766
0.7487
0.9235
')

pvalt <- as.numeric(unlist(strsplit(pval,"\n")))
pvalt <- pvalt[!is.na(pvalt)]
qvalue(pvalt)

bh <- NULL
for (i in 1:length(pvalt)) {
  if (pvalt[i]<.05) {
    bh <- c(bh, pvalt[i] < .05*(i/length(pvalt)))
  }
}
bh

BH <- p.adjust(pvalt, method='BH')
BH
p.adjust(pvalt, method='bonferroni')
table(p.adjust(pvalt, method='BH')<.1, trueStatus)
