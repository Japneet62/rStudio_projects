#############################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.03
# - Partial correlation and GLM in R
#############################################################################

#####################################
# R packages for today
#####################################

#install.packages("car")
library(car)

#install.packages("Hmisc")
library(Hmisc)

#install.packages("ggm")
library(ggm)


#####################################
# Define working folder
#####################################

pfad <- "D:/Working in Oldenburg/Teaching/seminar_analysisR_WT_1920/Session3/Data_and_scripts"
setwd(pfad)

#####################################
# Data import
#####################################

Data <- read.table("Data_seminar.txt", header=TRUE, sep="\t", dec=".")
dat <- Data[, c("subject", "WMf", "gff", "Spd1")] #select out several variables for analysis
head(dat) #overview of data

#####################################
# Discriptive analysis
#####################################

#mean value of the variable
# with a dollar sign, a vector can be address from a dataset (with several vectors)
mean <- mean(dat$gff)
mean

# standard deviation of the variable
standard_deviation <- sd(Data$gff)
standard_deviation

# minimum and maximum values of the variable
Minimum <- min(dat$gff) 
Maximum <- max(dat$gff)

# first and last entries of the variable
head(dat$gff) 
tail(dat$gff)

# covariance and correlation
covariance <- cov(dat$WMf , dat$gff)
correlation <- cor(dat$WMf , dat$gff)

#####################################
# Graphical representation
#####################################

png("HistogrammGff.png") #creat .png file in the working folder
hist(dat$gff)
dev.off() # shut down the graphic device

#install.packages("car")
#library(car)

png("ScatterGff_WMf.png")
scatterplot(gff~WMf, data = dat, smooth=T)
dev.off()

#####################################
# Correlation and Correlation matrix
#####################################
cor(dat$WMf, dat$gff)

correlationmatrix <- cor(dat[,c("gff", "WMf", "Spd1")])
correlationmatrix

########################################################
# Correlation matrix and inference for the correlation
# 1-sample t test, H0: r = 0
#######################################################

cor.test(dat$WMf, dat$gff)

# If you are interested in the statistical inference, write the results in an object and display the object

correlation_with_inference <- cor.test(dat$WMf, dat$gff)

##############################################
# statistical inference for correlation matrix
##############################################

#install.packages("Hmisc")

library(Hmisc)
Hmisc::rcorr(as.matrix(dat[, c("WMf", "gff", "Spd1")]))
# Note:
# There are two packages in R which contain the function named "Hmisc"
# We use rcorr() from the Hmisc package. 
# Therefore, we wrote "Hmisc::rcorr" to emphasize our selected function belongs to Hmisc

########################################################
# Regression analysis in R
#######################################################
# Here, gff is regressed on Spd1
# gff is the dependent variable, and Spd1 is the independent variable

regression <- lm(dat$gff ~ dat$Spd1)
summary(regression)
# The interpretation of output from regression analysis will be taught in lecture courses.

# A second way to do the regression analysis
regression <- lm(gff ~ Spd1, data = dat)
summary(regression)

################################################################################################################################
# Calculation of partial correlation from residulization - as explained in the lecture

# Please note, the computation below is only for better understanding of partial correlation 
# In normal analysis, we would NOT proceed in this way
# There is another function in R for the calculation of partial correlation, which we will learn in the next step.
################################################################################################################################

# Residualization of the intelligence variable after controlling for the speed variable

regr1 <- lm(gff ~ Spd1, data=dat)
summary(regr1)

# With the resid() function, the residual values from the objects (e.g. regr1) can be extracted
# We save the residual values to a new variable

dat$gff_resid <- resid(regr1)
head(dat)

#predicted values
dat$gff_fitted <- fitted.values(regr1)

# Residualization of the working memory variable when controlling for speed

regr2 <- lm(WMf ~ Spd1, data=dat)
summary(regr2)
dat$WMf_resid <- resid(regr2)
head(dat)

# Calculate the correlation of residuals

cor(dat$WMf_resid, dat$gff_resid)

#################################################################################
# Calculate partial correlation using the function pcor() from the ggm pacakge
#################################################################################

#install.packages("ggm")
library(ggm)

hist(dat$WMf)
hist(dat$gff)
hist(dat$Spd1)

# first-order partial correlation

dat2 <- dat[,c("gff", "WMf", "Spd1")] # select numerical variables for calculation of partial correlation
pc <- pcor(c("gff", "WMf", "Spd1"), var(dat2))
pc

# Inference for partial correlation
pcor.test(pc,1,255)

# or
pcor.test(pcor(c("gff", "WMf", "Spd1"), var(dat2)),1,255)


# second-order partial correlation

dat3 <- Data[,c("gff", "WMf", "Spd1","SMf")]
pc2 <- pcor(c("gff", "WMf", "Spd1","SMf"), var(dat3))
pc2

pcor.test(pc2,2,255)



