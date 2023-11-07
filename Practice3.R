#############################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.03
# - Partial correlation and GLM in R - self practice
#############################################################################

#############################
# set working directory
#############################

pfad <- "D:/Working in Oldenburg/Teaching/seminar_analysisR_WT_1920/Session3/Data_and_scripts"
setwd(pfad)

########################################################
# Self practice - WMn, gfn, Spd
########################################################


Data <- read.table("Data_seminar.txt", header=TRUE, sep="\t", dec=".")
head(Data)

hist(Data$WMn)
hist(Data$gfn)

library(car)
scatterplot(gfn~WMn, data=Data)

cov(Data$WMn, Data$gfn)
cor(Data$WMn, Data$gfn)
cor.test(Data$WMn, Data$gfn)

regression2 <- lm(gfn ~ Spd1, data=Data)
summary(regression2)
Data$gfn_resid <- resid(regression2)
Data$gfn_fitted <- fitted.values(regression2)

#install.packages("ggm")
library(ggm)

dat2 <- Data[,c("gfn","WMn","Spd1")]
pc2 <- pcor(c("gfn","WMn","Spd1"),var(dat2))
pc2

pcor.test(pc2,1,255)
