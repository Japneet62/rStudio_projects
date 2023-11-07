#############################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.07
# - Spline regression in R
# @ Xinyang Liu - 2019.11.27
############################################################################

#####################################
# R packages for today
#####################################

#install.packages("ISLR")
#install.packages("splines")
library(ISLR)
library(splines)

# the "Wage" data used for scripting comes from the "ISLR" package
# We can take an overview of the data :)
head(Wage)

# do a scatter plot with age (X) and wage (Y)
plot(Wage$age, Wage$wage, col = "gray")


#####################################
# Define working folder
#####################################

pfad <- "D:/Working in Oldenburg/Teaching/seminar_analysisR_WT_1920/Session7/Data_and_scripts"
setwd(pfad)

#####################################
# Step functions (piecewise constant)
#####################################


# the function cut() returns an ordered categorical variable
#--------------------------------------------
#   cutpoints are automatically selected
#--------------------------------------------

# table() function - build a table of counts at each combination of factor levels
# cut the age variable into 4 sections
table(cut(Wage$age, 4))

# linear regression with the cut and ordered categorical variable
fit=lm(wage ~ cut (age, 4), data=Wage)

# look at model coefficients
coef(summary (fit))

# We can produce predictions and plots just as we did in the case of the polynomial fit
# To know the meaning of each commmand, please refer to polynomial regression in Session6.R
agelims =range(Wage$age)
age.grid=seq(from=agelims[1], to=agelims[2])
preds=predict(fit, newdata =list(age=age.grid),se=TRUE)
se.bands=cbind(preds$fit +2*preds$se.fit ,preds$fit-2* preds$se.fit)

plot(Wage$age, Wage$wage, xlim=agelims, cex =.5, col ="darkgrey",main = "Step function")
lines(age.grid, preds$fit, lwd =2, col ="blue")
matlines (age.grid, se.bands, lwd =1, col ="blue",lty =3)

#------------------------------
# Make specific cutpoints
#------------------------------
# using "breaks" option to set specific cutpoints

table(cut(Wage$age, breaks = c(agelims[1],25,40,60,agelims[2])))
c1 <- cut(Wage$age, breaks = c(agelims[1],25,40,60,agelims[2]))

fit=lm(wage ~ c1, data=Wage)
coef(summary (fit))


#####################################
# Spline regression
#####################################

# In order to fit regression splines in R, we use the splines library
# library(splines)

# Fitting wage to age using a regression spline
# The bs() function generates the entire matrix of basis functions for splines with the specified set of knots
fit=lm(wage ~ bs(age, knots = c(25, 40, 60)), data = Wage)


pred = predict(fit, newdata = list(age = age.grid), se=T)
plot(Wage$age, Wage$wage, col ="gray ", main = "Cubic Spline")
lines(age.grid, pred$fit, lwd =2, col = "blue")
lines(age.grid, pred$fit + 2*pred$se, lty = "dashed", col = "blue")
lines(age.grid, pred$fit - 2*pred$se, lty = "dashed", col = "blue")

