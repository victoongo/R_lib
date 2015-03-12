
x <- 1:20 + rnorm(20)
y <- 1:20 + rnorm(20)
his <- function(a, b) {
  anm <- deparse(substitute(a))
  bnm <- deparse(substitute(b))
  print(anm)
  print(bnm)
  plot(a, b, xlab=anm, ylab=bnm)
}
his(x, y)

opar <- par(no.readonly=TRUE)

f <- lm(y~x)
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page
plot(f)
par(opar)
plot(x, y)

abline(f)
nd <- data.frame(x=seq(min(x), max(x), length=length(x)))
pred <- predict(f, interval="confidence", newdata=nd)
#         pred <- predict(mod, interval="confidence")
matlines(nd[,1], pred[,c('lwr','upr')],lty=2)
