############################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.10
# - Path modeling in R
# @ Xinyang Liu - 2020.01.08
############################################################################

###############################################
#               Preparation
###############################################

# define working directory


# install and load the R package - lavaan


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

# read in data - "1XY.txt"

# name columans "y1","y2","y3","x1","x2","x3"


# specify the first model - first only involve the regression relationships


# estimate the model

# view the results



# specify the second model - also involve the covariacnes between x1,x2 and x3



# estimate the model



# view the results

#----------------------------------------------
#         Draw the path diagram in R
#----------------------------------------------

# package name - semPlot
# install and load the package

# Draw the path diagram


# NOTES:
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

# import data - 2Health.txt


# The variable(column) names here come from the measured data which are already known
# "SubjHealth", "SubjHealthChange", "PhysicHealth", "NrDoctorApp", "FunctHealth", "FunctHealth1", "FunctHealth2"
# Name all the columns


# unrestricted model (df=0)



# restricted model (df=1)



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



# First order


# Second order


# Third order


