library(car)
some(iris)

scatterplotMatrix(~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width | Species, 
                  data=iris, smooth=FALSE, reg.line=FALSE, ellipse=TRUE, by.groups=TRUE, diagonal="none")

par(mfrow=c(2, 2))
for  (response in c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"))
  Boxplot(iris[, response] ~ Species, data=iris, ylab=response)

mod.iris <- lm(cbind(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) ~ Species, data=iris)
class(mod.iris)
mod.iris
summary(mod.iris)
(manova.iris <- Anova(mod.iris))
class(manova.iris)
summary(manova.iris)
anova(mod.iris)
linearHypothesis(mod.iris, "0.5*Speciesversicolor + 0.5*Speciesvirginica", verbose=TRUE)
linearHypothesis(mod.iris, "Speciesversicolor = Speciesvirginica", verbose=TRUE)
C <- matrix(c(1, -0.5, -0.5, 0, 1, -1), 3, 2)
colnames(C) <- c("setosa vs. versicolor & virginica", "versicolor & virginica")
contrasts(iris$Species) <- C
contrasts(iris$Species)
(mod.iris.2 <- update(mod.iris))
linearHypothesis(mod.iris.2, c(0, 1, 0)) # setosa vs. versicolor & virginica
linearHypothesis(mod.iris.2, c(0, 0, 1)) # versicolor vs. virginica
anova(mod.iris, imatrix=list(Sepal.Length=matrix(c(1, 0, 0, 0))))
linearHypothesis(mod.iris, c("Speciesversicolor = 0", "Speciesvirginica = 0"), 
                 P=matrix(c(1, 0, 0, 0))) # equivalent
Anova(lm(Sepal.Length ~ Species, data=iris))

# Handling Repeated Measures
some(OBrienKaiser)
contrasts(OBrienKaiser$treatment)
contrasts(OBrienKaiser$gender)
xtabs(~ treatment + gender, data=OBrienKaiser)
phase <- factor(rep(c("pretest", "posttest", "followup"), c(5, 5, 5)), 
                levels=c("pretest", "posttest", "followup"))
hour <- ordered(rep(1:5, 3))
idata <- data.frame(phase, hour)
idata
OBrien.long <- reshape(OBrienKaiser, varying=c("pre.1", "pre.2", "pre.3", "pre.4", "pre.5",
                                               "post.1", "post.2", "post.3", "post.4", "post.5", 
                                               "fup.1", "fup.2", "fup.3", "fup.4", "fup.5"), 
                       v.names="score", 
                       timevar="phase.hour", direction="long")
OBrien.long$phase <- ordered(c("pre", "post", "fup")[1 + ((OBrien.long$phase.hour - 1) %% 5)], 
                             levels=c("pre", "post", "fup"))
OBrien.long$hour <- ordered(1 + ((OBrien.long$phase.hour - 1) %% 5))
dim(OBrien.long)
head(OBrien.long, 25)
Means <- as.data.frame(ftable(with(OBrien.long,
                                   tapply(score, list(treatment=treatment, gender=gender, 
                                                      phase=phase, hour=hour), mean))))
names(Means)[5] <- "score"
dim(Means)
head(Means, 25)
library(lattice)
xyplot(score ~ hour | phase + treatment, groups=gender, type="b",
       strip=function(...) strip.default(strip.names=c(TRUE, TRUE), ...), 
       lty=1:2, pch=c(15, 1), col=1:2, cex=1.25, 
       ylab="Mean Reading Score", data=Means, 
       key=list(title="Gender", cex.title=1, 
                text=list(c("Female", "Male")), lines=list(lty=1:2, col=1:2), 
                points=list(pch=c(15, 1), col=1:2, cex=1.25)))
mod.ok <- lm(cbind(pre.1, pre.2, pre.3, pre.4, pre.5, 
                   post.1, post.2, post.3, post.4, post.5, 
                   fup.1, fup.2, fup.3, fup.4, fup.5) ~ treatment*gender, 
             data=OBrienKaiser)
mod.ok
(av.ok <- Anova(mod.ok, idata=idata, idesign=~phase*hour, type=3))
summary(av.ok, multivariate=FALSE)
linearHypothesis(mod.ok, "(Intercept) = 0", idata=idata, 
                 idesign=~phase*hour, iterms="hour") # test hour main effect
(Hour <- model.matrix(~ hour, data=idata))
linearHypothesis(mod.ok, "(Intercept) = 0", 
                 P=Hour[, c(2:5)]) # test hour main effect (equivalent)
linearHypothesis(mod.ok, "(Intercept) = 0", P=Hour[, 2, drop=FALSE]) # linear 
linearHypothesis(mod.ok, "(Intercept) = 0", P=Hour[, 3, drop=FALSE]) # quadratic
linearHypothesis(mod.ok, "(Intercept) = 0", P=Hour[, 4, drop=FALSE]) # cubic
linearHypothesis(mod.ok, "(Intercept) = 0", P=Hour[, 5, drop=FALSE]) # quartic
linearHypothesis(mod.ok, "(Intercept) = 0", P=Hour[, c(2, 4:5)]) # all non-quadratic
