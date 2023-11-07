############################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.08
# - Multilevel regression in R
# @ Xinyang Liu - 2019.12.11 - Practice_completed
############################################################################

#################################
# Preparation
#################################

# packages - for multilevel models
#install.packages("lme4")
#library(lme4)
#install.packages("car")
library(car)
#install.packages("lmerTest")
library(lmerTest)

# set working directory

setwd("D:/Working in Oldenburg/Teaching/seminar_analysisR_WT_1920/Session9/Data_and_scripts")


###############################
# Dataset 2
###############################

# import data
dat2 <- read.table("Hogwarts2.txt", header=TRUE)
head(dat2)

# Research question - In this new data sample, is the relationship between schoolmates assessment and aggresion inclination 
# different across Houses?

# picture the data
scatterplot(aggression ~ schoolmates|house,data=dat2,grid=FALSE,smooth=FALSE)

# multilevel model - random intercept
RS_mod2 <- lmer( aggression ~ 1 + schoolmates + ( 1 | house), data = dat2)
summary(RS_mod2)

# compute ICC
ICC2 <- 0.1182/ (0.1182 + 1.0673)
ICC2

