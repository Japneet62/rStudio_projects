#############################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.06
# - Polynomial regression in R - Practice
# @ Xinyang Liu - 2019.11.27
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

#-----------------------------------------------------
#        Data: age (X) & wage (Y)
#-----------------------------------------------------

# 1. Import data and take an overview - We use the Wage dataset in ISLR() library
# library(ISLR)
head(Wage)

# 2. Make a scatter plot with wage (Y) against age (X)
#    Parameters: title - "scatter plot", color - gray, x label - "Age", Y label - "Wage"
plot(Wage$age, Wage$wage, main = "scatter plot", col= "gray", xlab = "Age", ylab = "Wage")

# cex - size of symbol; pch - symbol types; lwd - line width
plot(Wage$age, Wage$wage, main = "scatter plot", col= "gray", xlab = "Age", ylab = "Wage", cex = .8, pch = 1)

##################################################
#         Degree = 1 (linear regression)
##################################################

# 3.1 Simple linear regression - regress wage on age
# 3.2 See the inferential result
# 3.3 Draw the regression line in red color
regre1 <- lm(wage ~ age, data = Wage)
summary(regre1)
abline(regre1,lwd=2,col="red")


##################################################
#         Degree = 2 (Quadratic)
##################################################

# 4.1 Quadratic regression - use age to predict wage
regre2  <- lm(wage ~ age + I(age^2), data = Wage)
summary(regre2)

# 4.2 Compare Model2 with Model1
anova(regre1,regre2)

# 4.3 ------------Graphical display------------------------
# 4.3.1 Measure the range of the independent variable (age)
Agelims = range(Wage$age)

# 4.3.2 Create sequential integers within the range of the independent variable for later ploting
Age.grid = seq(from = Agelims[1], to = Agelims[2])

# 4.3.3 Use the “regre2” model to predict newdata and save the outcome in "preds", keep standard errors
preds = predict(regre2, newdata = list(age = Age.grid),se.fit = TRUE)

# 4.3.4 compute predicted values +/- 2 standard error (SE), and save them to se.bands for later ploting
se.bands = cbind(preds$fit + 2*preds$se.fit,preds$fit-2*preds$se.fit)

# 4.3.5 the scatter plot with wage (Y) against age (X), col - gray, x label - Age, y label - Wage
plot(Wage$age, Wage$wage,xlim = Agelims, col = "gray", main = "Polynomial regression (degree=2)")

# 4.3.6 plot the regression curve of polynomial regression, line width - 2, color - blue
lines(Age.grid, preds$fit,lwd = 2, col =" blue")

# 4.3.7 draw dash lines for prediction +/- 2SE, line width - 1, color - blue, line type - 3
matlines (Age.grid, se.bands ,lwd = 1, col =" blue",lty =3)

##################################################
#         Degree = 3 and 4 (Cubic and Quartic)
##################################################

# 5.1 Centering age
# 5.2 Cubic regression - use centered age to predict wage
# 5.3 Statistical inference

Mean_age <- mean(Wage$age)
Wage$age_cent <- Wage$age - Mean_age
Wage$age_cent2 <- (Wage$age - Mean_age)^2
Wage$age_cent3 <- (Wage$age - Mean_age)^3

# it has the same effect if we directly use "Wage$age_cent" we just defined
Wage$age_cent2 <- Wage$age_cent^2
Wage$age_cent3 <- Wage$age_cent^3

fit3  <- lm(wage ~ age_cent + age_cent2 + age_cent3, data = Wage)
summary(fit3)

# 5.4 Use poly() function to do polynomial regression (degree=3 and 4, raw data)
regre3 <- lm(wage ~ poly(age, 3, raw = T), data = Wage)
summary(regre3)

regre4 <- lm(wage ~ poly(age, 4, raw = T), data = Wage)
summary(regre4)

# compare regression 1-4 using anova()
anova(regre1,regre2,regre3,regre4)
