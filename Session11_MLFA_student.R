############################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.11
# - Exploratory factor analysis in R
# @ Xinyang Liu - 2020.01.15
# the MLFA section
############################################################################

###############################################
#               Preparation
###############################################

# set working path


# install and load the package - "psych"


#*************************************************************
# More information about the "psych" package
# https://cran.r-project.org/web/packages/psych/index.html
#*************************************************************

# import data "Well-being.dat" and name variables with "Y1,Y2,Y3,Y4,Y5,Y6"



# display the correlation matrix with 2 decimal places




###############################################################
#           Maximum‐Likelihood Factor Analysis(MLFA)
###############################################################

# research question - 
# Are self‐ vs. other‐reports of wellbeing to be explained by two different factors?

# NOTE:
# the input can be either raw data frame or correlation matrix - dat or cor(dat)

#-------------------------------------
#      1. Factor identification
#-------------------------------------

# One factor (no rotation)



# Two factors (no rotation)



# Three factors (no rotation)



# residual matrix of the 2-factor model
# display with 3 decimal places 




# loading diagram




#-------------------------------------
#      2. Rotation
#-------------------------------------

# Now rotation is added
# 2-factor model

# variamx-rotation (orthogonal)




# graphic representation of the varimax-rotated solution



# promax-rotation (oblique)




# graphic representation of the promax-rotated solution




#-------------------------------------
#      3. Structure matrix
#-------------------------------------

# Structure matrix (correlations of variables with factors)




# Display the promax-rotated 2-factor solution as a path diagram





###############################################################
#           Self practice with the MLFA
###############################################################

# Now practise with the our familiar data "Data_seminar.txt"
# columns - "WMv","WMn","WMf","Spd1","Spd2","Spd3","Spd4","gfv","gfn","gff"

# 1. Factor identification 2. Add rotation 3.Display structure matrix


#-------------------------------
#    Factor identification
#-------------------------------
# One factor (no rotation)


# Two factors (no rotation)


# Three factors (no rotation)


#---------------------------------
#          Rotation
#---------------------------------

# promax-rotation (oblique)



# graphic representation of the promax-rotated solution


#----------------------------------
#        Structure matrix
#----------------------------------

# Structure matrix (correlations of variables with factors)



# Display the promax-rotated 2-factor solution as a path diagram


