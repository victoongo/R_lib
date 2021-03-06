library(gmodels)
library(plyr)
library(dplyr)
library(lsmeans)
library(knitr)
library(rmarkdown)
library(xtable)
setwd('~/niches/SOURCE_DATA')

load('epinew.Rdata')
nms <- names(epinew)
mv_vars <- nms[grep('_mv$|_mv_mean$', nms)]
orig_vars <- sub("_mv", "", mv_vars)
nms[grep('meg|MEG', nms)]
nms[grep('smok', nms)]

m <- epinew[,c(mv_vars, orig_vars)]
epinew <- subset(epinew, select=c(race_final, education, active_smoke_preg, BMI_LMP_kgm2,
                                  GestAge_TotalDays, BABY_GENDER, BABY_WEIGHT, mom_age_delv))
epinew <- cbind(epinew, m)

epinew <- na.omit(epinew)

epinew$bmic5.f <- factor(cut(epinew$BMI_LMP_kgm2, c(0, 25, 30, 35, 100), right=F))
epinew$bwt.f <- factor(cut(epinew$BABY_WEIGHT, c(0, 2500, 8000), right=F))
epinew$mage.f <- factor(cut(epinew$mom_age_delv, c(0, 30, 40, 100), right=F))
epinew$act_smok.f <- factor(epinew$active_smoke_preg)

epinew$educ.f <- factor(epinew$education)
epinew$educ.f <- mapvalues(epinew$educ.f, from = c('1', '2', '3', '4', '5'), to = c('1', '2', '2', '3', '3'))

epinew$race.f <- factor(epinew$race_final)
levels(epinew$race.f)[levels(epinew$race.f) == "Hispanic"] <- "Other"

contrasts(epinew$race.f) <- contr.treatment(4, base=4)

# table 1
# nms_mv <- unique(sub('_CG[0-9]*_mv$', '', nms[grep('_mv$', nms)]))
# margin.table(table(epinew$MEG3IG_CG2_mv, epinew$smoker), 2)
# CrossTable(epinew$MEG3IG_CG2_mv, epinew$smoker)
crosstab <- function(x) {
  table1 <- paste0("t1 <- table(epinew$", x, ", epinew$active_smoke_preg)")
  print(table1)
  eval(parse(text=c(table1)))
  p1 <- round(prop.table(t1, 2), 2)
  print(t1)
  pv <- round(fisher.test(t1, workspace = 2e+07, hybrid = TRUE)$p.value, 4)
  print(pv)
  (v1 <- cbind(t1, p1*100, pv))
  v2 <- cbind(paste0(x, "_", rownames(v1)), v1)
}
# crosstab("active_smoke_preg")
# 'educ.f', 'race.f', 'bmic5.f'
cntr_vars <- c('mage.f', 'educ.f', 'race.f', 'BABY_GENDER', 'bwt.f')
tb1 <- data.frame()
for (var in cntr_vars) {
  tb1 <- rbind(tb1, crosstab(var))
  # rownames(t1)[nrow(t2_orig)] <- var
}
tb2 <- tb1
rownames(tb2) <- NULL
x <- paste0("x", as.character(1:8))
names(tb2) <- c("variable", x, "p.value")
tb2$x1 <- paste0(as.character(tb2$x1), "(", as.character(tb2$x5), ")")
tb2$x2 <- paste0(as.character(tb2$x2), "(", as.character(tb2$x6), ")")
tb2$x3 <- paste0(as.character(tb2$x3), "(", as.character(tb2$x7), ")")
tb2$x4 <- paste0(as.character(tb2$x4), "(", as.character(tb2$x8), ")")
tb2a <- subset(tb2, select=-c(x5, x6, x7, x8))

rmarkdown::render('~/Dropbox/Projects/R_lib/niches/table1.Rmd', "html_document")

t1 <- table(epinew$race.f, epinew$active_smoke_preg)
p1 <- round(prop.table(t1, 2), 2)
pv <- round(fisher.test(t1, alternative = "greater")$p.value, 4)
pv <- fisher.test(t1, workspace = 2e+07, hybrid = TRUE)
(v1 <- data.frame(cbind(t1, p1*100, pv)))
v2 <- cbind('h', v1)
names(v1) <- c()

ct1 <- CrossTable(epinew$mage.f, epinew$active_smoke_preg, digits = 2, prop.r = F, prop.t = F, prop.chisq = F, fisher =T)

# table 2 - marginal mean using lsmeans packages
lsm_test <- function(x) {
  fmla <- paste0(x, " ~ act_smok.f + educ.f + race.f + BMI_LMP_kgm2 + GestAge_TotalDays +
                 BABY_GENDER + BABY_WEIGHT + mom_age_delv")
  lm1 <- lm(as.formula(fmla), data = epinew, na.action=na.omit)
  lsm <- lsmeans(lm1, 'act_smok.f')
  l1 <- summary(lsm)[1:4, 2]
  l2 <- summary(lm1)$coefficients[grep('act_smok', rownames(summary(lm1)$coefficients)), 4]
  l <- c(l1, l2)
}

t2_orig <- data.frame()
for (var in orig_vars) {
  t2_orig <- rbind(t2_orig, lsm_test(var))
  rownames(t2_orig)[nrow(t2_orig)] <- var
}

t2_mv <- data.frame()
for (var in mv_vars) {
  t2_mv <- rbind(t2_mv, lsm_test(var))
  rownames(t2_mv)[nrow(t2_mv)] <- var
}
names <- c(paste("Mean", c('1', '2', '3', '4')), paste('P-value', c('2-1', '3-1', '4-1')))
names(t2_orig) <- names
names(t2_mv) <- names

rmarkdown::render('~/Dropbox/Projects/R_lib/niches/table2.Rmd', "html_document")


# test code
lm1 <- lm(MMP9_CG2_mv ~ educ.f + act_smok.f, data = epinew, na.action = na.omit)
fmla <- paste0("MMP9_CG2_mv ~ act_smok.f + educ.f + race.f + BMI_LMP_kgm2 + GestAge_TotalDays +
                 BABY_GENDER + BABY_WEIGHT + mom_age_delv")
lm1 <- lm(as.formula(fmla), data = epinew, na.action=na.omit)
lsm <- lsmeans(lm1, 'act_smok.f')

(l1 <- summary(lsm)[1:4, 2])
(l2 <- summary(lm1)$coefficients[grep('act_smok', rownames(summary(lm1)$coefficients)), 4])
(l <- c(l1, l2))

anova(lm1)
(rg1 <- ref.grid(lm1))
lsm <- lsmeans(lm1, 'act_smok.f')
summary(lsm, infer = c(TRUE, TRUE))
con <- contrast(lsm, method = 'trt.vs.ctrl')


lsm[[2]]
names(lsm[[2]])

@p.value

[, 6]
$p.value
[, c(1, 2, 8)]


# 3 ways to do this
# daply(epinew, .(smoker), summarize, mean(MEG3IG_CG2_mv, na.rm=T))
# with(epinew, by(MEG3IG_CG2_mv, list(smoker), FUN=mean, na.rm=T))
# tapply(epinew$MEG3IG_CG2_mv, epinew$smoker, mean, na.rm=T)

# mean(epinew[epinew$smoker==1, "MEG3IG_CG2_mv"], na.rm=T)
#
# t.test(MEG3IG_CG2_mv~smoker, data=epinew)
# t.test(MEG3IG_CG2_mv~smoker, data=epinew)
# with(epinew, t.test(MEG3IG_CG2_mv[smoker==0], MEG3IG_CG2_mv[smoker==1]))
#
# output <- apply(epinew[grep('_mv$|_mv_mean$', nms)], 2, function(x) {
#   m <- with(epinew, by(x, list(smoker), FUN=mean, na.rm=T))
#   # with(epinew, print(head(x[smoker==1])))
#   # x1 <- with(epinew[smoker==0,], x)
#   # with(epinew, t.test(x[smoker==0], x[smoker==1]))$p.value # doesn't work, don't kwow why
#   #
#   # with(epinew[epinew$smoker==0 or epinew$smoker==1,], t.test(x~smoker))$p.value
#   # c(m, tp)
#   # print(head(x))
#   # by(x, list(epinew$smoker), FUN=mean, na.rm=T)
#   # t.test(x[epinew$smoker==0], x[epinew$smoker==1])
#   # print(head(x[epinew$smoker==1]))
#   x0 <- x[epinew$smoker==0]
#   x0 <- x0[!is.infinite(x0)]
#   x1 <- x[epinew$smoker==1]
#   x1 <- x1[!is.infinite(x1)]
#   # print(head(x0))
#   # print(head(x1))
#   tp <- t.test(x1, x0)$p.value
#   c(m, tp)
# })
# toutput <- t(output)
# toutput
#
#
# epinew$MMP9_CG2_mv[!is.infinite(epinew$MMP9_CG2_mv)]



# table 3


