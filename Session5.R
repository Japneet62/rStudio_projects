#############################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.05
# - Multiplae regression and moderated regression in R
# @ Xinyang Liu - 2019.11.13
#############################################################################

#####################################
# R packages for today
#####################################

#install.packages("QuantPsyc")
#install.packages("car")
#install.packages("rgl")
library(QuantPsyc)
library(car)
library(rgl)

#####################################
# Define working folder
#####################################

pfad <- "D:/Working in Oldenburg/Teaching/seminar_analysisR_WT_1920/Session5/Data_and_scripts"
setwd(pfad)

#####################################
# Data import
#####################################

Data <- read.table("Data_seminar.txt", header=TRUE, sep="\t", dec=".")
dat <- Data[, c("subject", "age","WMf","SMf","Spd1","gff")] #select out several variables for analysis
head(dat) #overview of data

####################################
# Multiple regression
####################################

Mreg1 <- lm(gff ~ WMf + Spd1, data=dat)
summary(Mreg1)

# compute the standardized regression coefficients from lm()
# library(QuantPsyc)
lm.beta(Mreg1)


#library(car)
#library(rgl)

scatter3d(gff ~ WMf + Spd1 , data=dat)


####################################
# Variance decomposition - gff, WMf
####################################

# calculate the total variation
mean_gff <- mean(dat$gff)
mean_gff

QSgff <- sum((dat$gff - mean_gff)^2)
QSgff

# non-explained variation
reg1 <- lm(gff ~ WMf, data = dat)
dat$gff_resid <- resid(reg1)
head(dat)

QSgff_e <- sum(dat$gff_resid^2)
QSgff_e

# explained variation
dat$gff_fit <- fitted.values(reg1)
head(dat)
QSgff_fit <- sum((dat$gff_fit - mean_gff)^2)
QSgff_fit

# R square calculation
R_squr <- QSgff_fit/QSgff
R_squr

# to verify
summary(reg1)

######################################################
#  Hierarchical regression - usefulness of Predictors
######################################################

# Order as WMf, SMf, Spd1

# Model1 
regr1 <- lm(gff ~ WMf, data= dat)
summary(regr1)

# Model2
regr2 <- lm(gff ~ WMf + SMf, data= dat)
summary(regr2)

# Model3
regr3 <- lm(gff ~ WMf + SMf + Spd1, data= dat)
summary(regr3)

# R square in Model1
mod1.Rsq <- 0.2161

# R square in Model2
mod2.Rsq <- 0.2641

# R squire in Model3
mod3.Rsq <- 0.2785

# explanation power for the second predictor SMf
delta_Rsq <- mod2.Rsq - mod1.Rsq
delta_Rsq

# explanation power for the third predictor Spd1
delta_Rsq2 <- mod3.Rsq - mod2.Rsq
delta_Rsq2

# the unique variance explained in gff by the third variable 

# for SMf as the third predictor

r1 <- lm(gff ~ WMf + Spd1, data= dat)
summary(r1)

r2 <- lm(gff ~ WMf + Spd1 + SMf, data= dat)
summary(r2)

r1_Rsq <- 0.2325
r2_Rsq <- 0.2785

delta_Rsq2.1 <- r2_Rsq - r1_Rsq
delta_Rsq2.1 # --- unique variance in gff explained by SMf


# for WMf as the third predictor
r3 <- lm(gff ~ SMf + Spd1, data = dat)
summary(r3)

r4 <- lm(gff ~ SMf + Spd1 + WMf, data = dat)
summary(r4)

r3_Rsq <- 0.1739
r4_Rsq <- 0.2785

delta_Req4.3 <- r4_Rsq - r3_Rsq
delta_Req4.3 # --- unique variance in gff explained by WMf

#####################################
# Statistical inference
#####################################

anova(regr1,regr2)

anova(regr1,regr2,regr3)

anova(r1,r2)
anova(r3,r4)

#---------------------------------------------------------------
#####################################
# Moderated regression
#####################################

#---------------------------------------------------------
# create a scatter plot for the regression of gff on WMf
library(car)
scatterplot(gff ~ WMf, data = dat, smooth=FALSE)

# calculate the multiple regression without moderation effect for the prediction of gff through WMf and age
MultRegression <- lm(gff ~ WMf + age, data = dat)
summary(MultRegression)

# standardize the coefficients of regression
library(QuantPsyc)
lm.beta(MultRegression)

#--------------------------------------------------------
# To achieve a meaningful Intercept (b0), predictors in a multiple regression are usually centered on their mean

mean(dat$age)
sd(dat$age)

# Centering

dat$ageZ <- dat$age - mean(dat$age)
dat$WMfZ <- dat$WMf - mean(dat$WMf)

mean(dat$ageZ)
sd(dat$ageZ)

mean(dat$WMfZ)
sd(dat$WMfZ)

# For investigating a moderation effect, we calculate the product variable
# interaction term
dat$intZ <- dat$ageZ * dat$WMfZ

#--------------------------------------------------
# Moderated Regression with centered predictors

MultRegressionZ <- lm(gff ~ WMfZ + ageZ, data = dat)
summary(MultRegressionZ)


# Moderated regression

MultModRegressionZ <- lm(gff ~ WMfZ + ageZ + intZ, data = dat)
summary(MultModRegressionZ)

# alternative

MultModRegressionZ <- lm(gff ~ WMfZ + ageZ + WMfZ * ageZ, data = dat)
summary(MultModRegressionZ)

#--------------------------------------------------
# Graphical representatio of the interaction effect

#png("interakt_MultRegression_alter.png")

# create a plot frame
plot(c(0,1),c(0,1), xlim = c(-0.2,0.2),ylim = c(0.25,0.55), bty = "n", xaxt = "n", yaxt = "n", xlab = "", ylab = "", type = "n")

# dram the two lines of x axis and y axis
segments(-0.15, 0.3, 0.15, 0.3)
segments(-0.15,0.3, -0.15, 0.55)

# mark the scale on the x axis
segments(-0.10, 0.3, -0.10, 0.305)
segments(0, 0.3, 0, 0.305)
segments(0.10, 0.3, 0.10, 0.305)

# mark the scale on the y axis
segments(-0.15, 0.35, -0.14, 0.35)
segments(-0.15, 0.40, -0.14, 0.40)
segments(-0.15, 0.45, -0.14, 0.45)
segments(-0.15, 0.50, -0.14, 0.50)

# mark the coordinates

# x axis
text (-0.10, 0.29, "-0.10")
text (0, 0.29, "0")
text (0, 0.27, "WMf")
text (0.10, 0.29, "0.10")

# y axis
text (-0.17, 0.30, "0.30")
text (-0.17, 0.35, "0.35")
text (-0.17, 0.40, "0.40")
text (-0.17, 0.45, "0.45")
text (-0.17, 0.5, "0.50")
text (-0.195, 0.425, "gff")

# depict the regression lines
segments(-0.10,0.44-0.005*4.89+(0.75+0.02*4.89)*(-0.10), 0.10,0.44-0.005*4.89+(0.75+0.02*4.89)*0.10)
segments(-0.10,0.44-0.005*0+(0.75+0.02*0)*(-0.10), 0.10,0.44-0.005*0+(0.75+0.02*0)*0.10)
segments(-0.10,0.44-0.005*(-4.89)+(0.75+0.02*(-4.89))*(-0.10), 0.10,0.44-0.005*(-4.89)+(0.75+0.02*(-4.89))*0.10)

# dev.off()
