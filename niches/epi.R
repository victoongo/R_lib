library(gmodels)
library(dplyr)
library(plyr)
setwd('~/niches/SOURCE_DATA')

load('epinew.Rdata')
nms <- names(epinew)
nms[grep('smok', nms)]

# table 1
nms_mv <- unique(sub('_CG[0-9]*_mv$', '', nms[grep('_mv$', nms)]))
margin.table(table(epinew$MEG3IG_CG2_mv, epinew$smoker), 2)
CrossTable(epinew$MEG3IG_CG2_mv, epinew$smoker)
table(epinew$smoker, mean())

# 3 ways to do this
# daply(epinew, .(smoker), summarize, mean(MEG3IG_CG2_mv, na.rm=T))
# with(epinew, by(MEG3IG_CG2_mv, list(smoker), FUN=mean, na.rm=T))
# tapply(epinew$MEG3IG_CG2_mv, epinew$smoker, mean, na.rm=T)

# mean(epinew[epinew$smoker==1, "MEG3IG_CG2_mv"], na.rm=T)

t.test(MEG3IG_CG2_mv~smoker, data=epinew)
t.test(MEG3IG_CG2_mv~smoker, data=epinew)
with(epinew, t.test(MEG3IG_CG2_mv[smoker==0], MEG3IG_CG2_mv[smoker==1]))

output <- apply(epinew[grep('_mv$|_mv_mean$', nms)], 2, function(x) {
  m <- with(epinew, by(x, list(smoker), FUN=mean, na.rm=T))
  # with(epinew, print(head(x[smoker==1])))
  # x1 <- with(epinew[smoker==0,], x)
  # with(epinew, t.test(x[smoker==0], x[smoker==1]))$p.value # doesn't work, don't kwow why
  #
  # with(epinew[epinew$smoker==0 or epinew$smoker==1,], t.test(x~smoker))$p.value
  # c(m, tp)
  # print(head(x))
  # by(x, list(epinew$smoker), FUN=mean, na.rm=T)
  # t.test(x[epinew$smoker==0], x[epinew$smoker==1])
  # print(head(x[epinew$smoker==1]))
  x0 <- x[epinew$smoker==0]
  x0 <- x0[!is.infinite(x0)]
  x1 <- x[epinew$smoker==1]
  x1 <- x1[!is.infinite(x1)]
  # print(head(x0))
  # print(head(x1))
  tp <- t.test(x1, x0)$p.value
  c(m, tp)
})
toutput <- t(output)
toutput


epinew$MMP9_CG2_mv[!is.infinite(epinew$MMP9_CG2_mv)]
# table 2




# table 3

weight, agemos, id, ref_date, wt_source, sex, BABY_WEIGHT,
BMI_LMP_kgm2, mat_gest_wt_gain_category2,
gest_weight_gain_kg, GestAge_TotalDays, smoker, maternal_smoking2, parity_3cat,
mom_age_delv, race_final, education4, GEST_DIABETES, PREGNANCY_HYPERTENSION

nwaz$bmic5.f <- factor(cut(nwaz$BMI_LMP_kgm2, c(0, 18.5, 25, 30, 35, 40, 100), right=F))
contrasts(nwaz$bmic5.f) <- contr.treatment(6, base=2)
nwaz$educ.f <- factor(nwaz$education4)
nwaz$race.f <- factor(nwaz$race_final)
contrasts(nwaz$race.f) <- contr.treatment(4, base=4)
nwaz$parity.f <- factor(nwaz$parity_3cat)
nwaz$smoker.f <- factor(nwaz$smoker)
nwaz$gest_dbt.f <- factor(nwaz$GEST_DIABETES)
contrasts(nwaz$gest_dbt.f) <- contr.treatment(2, base=2)
nwaz$preg_ht.f <- factor(nwaz$PREGNANCY_HYPERTENSION)
contrasts(nwaz$preg_ht.f) <- contr.treatment(2, base=2)
nwaz$mat_gest_wt_gain_c3.f <- factor(nwaz$mat_gest_wt_gain_category2)
contrasts(nwaz$mat_gest_wt_gain_c3.f) <- contr.treatment(3, base=2)
