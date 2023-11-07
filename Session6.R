#############################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.06
# - Polynomial regression in R
# @ Japneet Bhatia- 2019.11.20
############################################################################

#####################################
# R packages for today
#####################################

#install.packages("ISLR")
library(ISLR)

#####################################
# Define working folder
#####################################

pfad <- "D:/Working in Oldenburg/Teaching/seminar_analysisR_WT_1920/Session6/Data_and_scripts"
setwd(pfad)

##########################################################
#                Polynomial regression
##########################################################

#-------------------------------------------------------------------
#               Data: Credits(X) & Interest(Y)
#-------------------------------------------------------------------

# import data
dat <- read.table("C06E01DT.TXT")
names(dat) <- c("ID", "Credits", "Interest")
head(dat)

# scatterplot between Credits (X) and Interest (Y)
plot(dat$Interest ~ dat$Credits)

##################################
#         Degree = 1 
##################################

# Simple linear regression
regre1 <- lm(Interest ~ Credits, data = dat)
summary(regre1)

# add the regression line
# the function abline() adds one or more straight lines through the current plot
abline(regre1,lwd=2, col="red")

# detect the relationship between residual of Interest(Y) and Credits(X) 
dat$Interest_resid <- resid(regre1)
plot(dat$Interest_resid ~ dat$Credits)
# add a reference line y = 0 (intercept = 0,slope = 0 for parameter setting)
abline(0, 0) 

##################################
#         Degree = 2
##################################

# quadratic polynomial regression

# take care to protect the term "Credits^2" via the wrapper function "I()"
# if you only write Credits^2 without I(), it cannot be read into the lm()
regre2  <- lm(Interest ~ Credits + I(Credits^2), data=dat)
summary(regre2)

# compare Model1 with Model2
anova(regre1,regre2)

#........Graphical display (Degree = 2).......

# measure the range of the independent variable (Credits)
Creditslims = range(dat$Credits)

# create sequential integers within the range of the independent variable for later ploting
Credits.grid = seq(from = Creditslims[1], to = Creditslims[2])

# use the “regre2” model to predict newdata and save the outcome in "preds"
# "se.fit" tells if standard errors are returned

preds = predict(regre2, newdata = list(Credits = Credits.grid),se.fit = TRUE)

# compute predicted values +/- 2 standard error (SE), and save them to se.bands for later ploting
se.bands=cbind(preds$fit + 2*preds$se.fit,preds$fit-2*preds$se.fit)

# the scatter plot with Interest (Y) against Credits (X), paramters can be adjusted
plot(dat$Credits, dat$Interest ,xlim=Creditslims)

# plot the blue curve of polynomial regression
lines(Credits.grid, preds$fit ,lwd = 2, col =" blue")

# draw dash lines for prediction +/- 2SE
matlines (Credits.grid, se.bands ,lwd = 1, col =" blue",lty =3)

#######################################
#             Degree = 3
#######################################

regre3  <- lm(Interest ~ Credits + I(Credits^2) + I(Credits^3), data=dat)
summary(regre3)

# compare Model2 with Model3
anova(regre2,regre3)
anova(regre1, regre2, regre3)

# ........Graphical Display (Degree = 3)......

preds2 = predict(regre3, newdata = list(Credits = Credits.grid),se.fit = TRUE)

# compute predicted values +/- 2 standard error (SE), and save them to se.bands for later ploting
se.bands2=cbind(preds2$fit + 2*preds2$se.fit,preds2$fit-2*preds2$se.fit)

# the scatter plot with Interest (Y) against Credits (X), paramters can be adjusted
plot(dat$Credits, dat$Interest ,xlim=Creditslims)

# plot the blue curve of polynomial regression
lines(Credits.grid, preds2$fit ,lwd = 2, col =" green")

# draw dash lines for prediction +/- 2SE
matlines(Credits.grid, se.bands2 ,lwd = 1, col =" green",lty =3)


#.............Graphcial display of all lines......

# scatter plot
plot(dat$Interest ~ dat$Credits, main = "Polynomial regression")

# simple linear regression
abline(regre1,lwd=2, col="red")

# quadratic polynomial regression
lines(Credits.grid, preds$fit ,lwd = 2, col =" blue")
matlines (Credits.grid, se.bands ,lwd = 1, col =" blue",lty =3)

# cubic polynomial regression
lines(Credits.grid, preds2$fit ,lwd = 2, col =" green")
matlines (Credits.grid, se.bands2 ,lwd = 1, col =" green",lty =3)

# add legend
legend(1,27,legend = c("Model1: linear x","Model2: poly x^2","Model3: poly x^3"),col = c("red","blue","green"),
       lty=1,lwd = 2, cex=1, text.font=1.5)

################################################
#            the poly() function 
################################################

# poly() with default settings
fit2 <- lm(Interest ~ poly(Credits, 2), data=dat)
summary(fit2)

# observe orthogonal polynomials created by poly()
head(poly(dat$Credits, 2))

# compute the correlation between orthogonal predictors
C1=poly(dat$Credits,2)
cor.test(C1[,1],C1[,2])

# poly() with raw = T -> directly use the raw data as predictors, i.e. x,x^2....
fit2 <- lm(Interest ~ poly(Credits, 2, raw = T), data=dat)
summary(fit2)
head(poly(dat$Credits,2,raw = T))
C2=poly(dat$Credits,2,raw = T)
cor.test(C2[,1],C2[,2])

# compare with the detailed polynomial regression equation, same as poly() with raw=T
regre2  <- lm(Interest ~ Credits + I(Credits^2), data=dat)
summary(regre2)

# another way to express the formula
regre2b <- lm(Interest ~ cbind(Credits, Credits^2) ,data = dat)
summary(regre2b)

###################################################
#  Centering predictors in polynomial regression
###################################################

# center predictors

Mean <- mean(dat$Credits)
dat$Credits_cent <- dat$Credits - Mean
dat$Credits_cent2 <- (dat$Credits - Mean)^2
dat$Credits_cent3 <- (dat$Credits - Mean)^3

# Polynomial regression based on centered predictors

fit.nonCent = lm(Interest ~ Credits + I(Credits^2) + I(Credits^3), data=dat)
summary(fit.nonCent)

fit.Cent = lm(Interest ~ Credits_cent + Credits_cent2 + Credits_cent3, data=dat)
summary(fit.Cent)


# graphical display

#------ polynomical regression with centered predictors------

Creditslims3 = range(dat$Credits_cent)
Credits.grid3 = seq(from = Creditslims3[1], to = Creditslims3[2])
preds3 = predict(fit.Cent, newdata = list(Credits_cent=Credits.grid3, Credits_cent2 = Credits.grid3^2, Credits_cent3=Credits.grid3^3),se.fit = TRUE)
se.bands3=cbind(preds3$fit + 2*preds3$se.fit,preds3$fit-2*preds3$se.fit)
plot(dat$Credits_cent, dat$Interest ,xlim=Creditslims3 , main = "Polynomial regression (centered)")
lines(Credits.grid3, preds3$fit ,lwd = 2, col =" blue")
matlines (Credits.grid3, se.bands3 ,lwd = 1, col =" blue",lty =3)

#------ polynomical regression with non-centered predictors------

plot(dat$Interest ~ dat$Credits, main = "Polynomial regression (non-centered)")
lines(Credits.grid, preds2$fit ,lwd = 2, col =" blue")
matlines (Credits.grid, se.bands2 ,lwd = 1, col =" blue",lty =3)
