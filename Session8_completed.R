############################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.08
# - Logistic regression in R
# @ Xinyang Liu - 2019.12.4
############################################################################

#####################################
# R packages for today
#####################################

library(car)

#####################################
# Define working folder
#####################################

setwd("D:/Working in Oldenburg/Teaching/seminar_analysisR_WT_1920/Session8/Data_and_scripts")

#####################################
# Shake hands with the data
#####################################

# import data
dat <- read.table("FieldDisplayRules.dat", header = T)
head(dat)

# visualize relationship between age and display
plot(display ~ age, data = dat)
abline(lin.regr, col = "blue", lwd = 1.5)

# another way to draw scatterplot
#library(car)
scatterplot(display ~ age, data = dat, smooth=FALSE, grid = FALSE, boxplots = FALSE)

# linear regression with display rules against age
lin.regr <- lm(display ~ age, data = dat)
summary(lin.regr)

####################################
# Logistic regression in R
####################################

#---------------------------------------------
# the glm() function - general linear model
#---------------------------------------------

# default seting - gaussian/normal regression, same as lm()
lin.regr2 <- glm(display ~ age, data= dat)
summary(lin.regr2)

# equivalent as 
lin.regr2 <- glm(display ~ age, data=dat, family=gaussian)
summary(lin.regr2)

#---------------------------------------------
# the glm() function - binomial distribution
#---------------------------------------------

# what we obtain here is the conditional probability P(Y=1|X)

log.regr1 <- glm(display ~ age, data = dat, family=binomial())
summary(log.regr1)

# scatterplot
plot(display ~ age, data = dat, main = "Logistic regression")

# logistric regression line
lines(dat$age, log.regr1$fitted, col = "red")

# predicted values
points(log.regr1$fitted.values ~ age, data = dat, col = "red")

# get coefficients b0 and b1 for the logistic regression
b0=log.regr1$coefficients[1]
b1=log.regr1$coefficients[2]

b0
b1

# plot 
x = dat$age
y = exp(b0+b1*x)/(1+exp(b0+b1*x))
points(y ~ age, data = dat, col="blue")
lines(y ~ age, data = dat, col = "blue")
dat$P = y

# predicted values are the conditional probability function
dat$fit = fitted.values(log.regr1)
plot(P ~ age, data = dat, main = "Logistic regression")
plot(fit ~ age, data = dat, main = "Logistic regression")

# odd
dat$odd = exp(b0+b1*dat$age)
plot(odd ~ age, data = dat, main = "Logistic regression")

# Logit
dat$logit = b0+b1*dat$age
plot(logit ~ age, data = dat, main = "Logistic regression")

############################################
# Practice - multiple logistic regression
############################################

log.regr2 <- glm(display ~ TOM, data = dat, family=binomial())
summary(log.regr2)

plot(display~TOM, data = dat)

log.regr3 <- glm(display ~ age + TOM, data = dat, family=binomial())
summary(log.regr3)



