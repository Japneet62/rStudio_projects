#############################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.06
# - Polynomial regression in R - Practice
# @ Xinyang Liu - 2019.11.27
############################################################################

#####################################
# R packages for today
#####################################

# install and load "ISLR" package





#####################################
# Define working folder
#####################################






##########################################################
#                Polynomial regression
##########################################################

#-----------------------------------------------------
#        Data: age (X) & wage (Y)
#-----------------------------------------------------

# 1. Import data and take an overview - We use the Wage dataset in ISLR() library




# 2. Make a scatter plot with wage (Y) against age (X)
#    Parameters: title - "scatter plot", color - gray, x label - "Age", Y label - "Wage"





##################################################
#         Degree = 1 (linear regression)
##################################################

# 3.1 Simple linear regression - regress wage on age
# 3.2 See the inferential result
# 3.3 Draw the regression line - in red color








##################################################
#         Degree = 2 (Quadratic)
##################################################

# 4.1 Quadratic regression - use age to predict wage





# 4.2 Compare Model2 with Model1




# 4.3 ------------Graphical display------------------------
# 4.3.1 Measure the range of the independent variable (age)



# 4.3.2 Create sequential integers within the range of the independent variable for later ploting




# 4.3.3 Use the above model to predict wage and save the outcome in "preds", keep standard errors




# 4.3.4 compute predicted values +/- 2 standard error (SE), and save them to se.bands for later ploting




# 4.3.5 the scatter plot with wage (Y) against age (X), col - gray, x label - Age, y label - Wage




# 4.3.6 plot the regression curve of polynomial regression, line width - 2, color - blue




# 4.3.7 draw dash lines for prediction +/- 2SE, line width - 1, color - blue, line type - 3





##################################################
#         Degree = 3 and 4 (Cubic and Quartic)
##################################################

# 5.1 Centering age
# 5.2 Cubic regression - use centered age to predict wage
# 5.3 Statistical inference







# 5.4 Use poly() function to do polynomial regression (degree=3 and 4, raw data)





# 5.5 compare regression 1-4 using anova()




