############################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.10
# - Path modeling in R
# @ Xinyang Liu - 2020.01.08
############################################################################

###############################################
#               Preparation
###############################################

# define working directory
setwd("D:/Working in Oldenburg/Teaching/seminar_analysisR_WT_1920/Session10/Data_and_scripts")

# install packages
# install.packages("lavaan", dependencies = T)
library(lavaan)

#***************************************************************************
# For more infromation about the lavaan package, see website
# http://lavaan.ugent.be/tutorial/syntax1.html
#***************************************************************************

#******************************************************
#          IMPORTANT: Operators in lavaan
#    ~     means regression
#    ~~    means (residual) (co)variance
#******************************************************


###############################################
#         Dataset 1 (Figure 1.jpg)
###############################################

# read in data
dat1 <- read.table("1XY.txt") # check whether the data have column names
names(dat1) <- c("y1","y2","y3","x1","x2","x3") # give the raw data column names
head(dat1)

# first only involve the regression relationships

Model1 <-'
         y1 ~ x1 + x2 + x3
         y2 ~ x1 + x2 + x3
         y3 ~ x2 + y1 + y2
        
         '
fit1 <- sem(Model1, data=dat1)
summary(fit1, standardized=TRUE, fit.measures=TRUE)

# Then also involve the covariacnes between x1,x2 and x3

Model2 <-'
          y1 ~ x1 + x2 + x3
          y2 ~ x1 + x2 + x3
          y3 ~ x2 + y1 + y2
          
          # ~~ means a covariance / correlation in lavaan
          
          x1 ~~ x2
          x1 ~~ x3
          x2 ~~ x3
    
         '
fit2 <- sem(Model2, data=dat1)
summary(fit2, standardized=TRUE, fit.measures=TRUE)

#----------------------------------------------
#         Draw the path diagram in R
#----------------------------------------------
#install.packages("semPlot")
library(semPlot)

semPaths(fit2,'std',layout='tree2')
#  fit2 - objects
# 'std' - display the standardized parameter estimates
# 'tree2' - one option of how the nodes should be placed
# for details, see https://cran.r-project.org/web/packages/semPlot/semPlot.pdf

###############################################
#               Dataset 2
###############################################

# Variables: physical health (PhysicHealth), functional health (FunctHealth) ,subjective evaluation of health (SubjHealth)
# Hypotheses: 1)Physical health can predict functional health, which itself predicts subjective health
#             2)Physical health also has a direct effect on subjective health

# import data
dat2 <- read.table("2Health.txt")

# The variable(column) names here come from the measured data which are already known
names(dat2) <- c("SubjHealth", "SubjHealthChange", "PhysicHealth", "NrDoctorApp", "FunctHealth", "FunctHealth1", "FunctHealth2")

head(dat2)

# unrestricted model
Model3 <- 'SubjHealth ~ PhysicHealth + FunctHealth
		       FunctHealth ~ PhysicHealth	
          '

fit3 <- sem(Model3, data=dat2)
summary(fit3, standardized=TRUE, fit.measures=TRUE)

# restricted model
Model4 <- 'SubjHealth ~ PhysicHealth
		       FunctHealth ~ PhysicHealth
		       SubjHealth ~~ 0*FunctHealth # otherwise lavaan will calculate this automatically
          '

fit4 <- sem(Model4, data=dat2)
summary(fit4, standardized=TRUE, fit.measures=TRUE)


###############################################
#               Self practice
###############################################

#**********************************************
#               About the data

# Data file - "3WorkingMemory.txt"
# Research topic - stability of working memory across time

# Variable names -

# ID = Subject ID
# mu1 = Memory Updating task time point 1
# mu2 = Memory Updating task time point 2
# mu3 = Memory Updating task time point 3
# mu4 = Memory Updating task time point 4
# nb1 = NBack task time point 1
# nb2 = NBack task time point 2
# nb3 = NBack task time point 3
# nb4 = NBack task time point 4
#*********************************************

# Exercise:
# 1. Import the data
# 2. Please specify the series of autoregressive models illustrated in "Working Memory.jpg"

dat3 <- read.table("3WorkingMemory.txt", header=TRUE)
head(dat3)

# First order
Mod_WM1 <- '
           mu4 ~ mu3
           mu3 ~ mu2
           mu2 ~ mu1
          
           '
fit_WM1 <- sem(Mod_WM1, data = dat3)
summary(fit_WM1, standardized=TRUE)

# Second order
Mod_WM2 <- '
           mu4 ~ mu3
           mu3 ~ mu2
           mu2 ~ mu1
           
           mu3 ~ mu1
           mu4 ~ mu2
           
           '
fit_WM2 <- sem(Mod_WM2, data = dat3)
summary(fit_WM2, standardized=TRUE, fit.measures=TRUE)

# Third order
Mod_WM3 <- '
           mu4 ~ mu3
           mu3 ~ mu2
           mu2 ~ mu1
           
           mu3 ~ mu1
           mu4 ~ mu2
           
           mu4 ~ mu1
           '
fit_WM3 <- sem(Mod_WM3, data = dat3)
summary(fit_WM3, standardized=TRUE, fit.measures=TRUE)

