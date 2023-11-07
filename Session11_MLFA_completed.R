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
setwd("D:/Working in Oldenburg/Teaching/seminar_analysisR_WT_1920/Session11/Data_and_scripts")

# load package
library(psych)

#*************************************************************
# More information about the "psych" package
# https://cran.r-project.org/web/packages/psych/index.html
#*************************************************************

# import data and name variables
dat <- read.table("Well-being.dat", header = FALSE) 
names(dat) <- c("Y1", "Y2", "Y3", "Y4", "Y5", "Y6")
head(dat)

#display the correlation matrix with 2 decimal places
round(cor(dat), 2)

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

# In this first step, we set the rotation method to “none”, which means that 
# we won’t carry out factor rotation because we don’t need to at this stage.

# One factor (no rotation)
fa.ml1 <- fa(dat, nfactors = 1, fm="ml", rotate = "none")
fa.ml1

# result
# ML1 & ML2 – latent factors
# h2 – communality

# Two factors (no rotation)
fa.ml2 <- fa(dat, nfactors = 2, fm="ml", rotate = "none")
fa.ml2

# Three factors (no rotation, the model is saturated, df = 0)
fa.ml3 <- fa(dat, 3, fm="ml", rotate = "none")
fa.ml3

# residual matrix of the 2-factor model
# display with 3 decimal places 
round(fa.ml2$residual, 3)

#*****************************************************************************************
# NOTE about the residual matrix above:
# 1. The non-diagonal items are differences between observed and reproduced correlations 
# (small deviations, the 2-factor model fits well)
# 2. The unexplained variance (uniqueness) is shown in the diagonal.
#*****************************************************************************************

# loading diagram
factor.plot(fa.ml2, xlim = c(-1, 1), ylim = c(-1, 1), xlab = "Factor 1", ylab = "Factor 2", title = "loading diagram" )

#-------------------------------------
#      2. Rotation
#-------------------------------------

# Now rotation is added
# 2-factor model

# variamx-rotation (orthogonal)
fa.ml2.varimax <- fa(dat, 2, fm="ml", rotate = "varimax")
fa.ml2.varimax

#graphic representation of the varimax-rotated solution
factor.plot(fa.ml2.varimax, xlim = c(-1, 1), ylim = c(-1, 1), xlab = "Factor 1", ylab = "Factor 2", title = "varimax-rotation" )

# promax-rotation (oblique)
fa.ml2.promax <- fa(dat, 2, fm="ml", rotate = "promax")
fa.ml2.promax

#graphic representation of the promax-rotated solution
factor.plot(fa.ml2.promax, xlim = c(-1, 1), ylim = c(-1, 1), xlab = "Factor 1", ylab = "Factor 2", title = "promax-rotation" )


#-------------------------------------
#      3. Structure matrix
#-------------------------------------

# Structure matrix (correlations of variables with factors)

fa.ml2.promax$Structure

# Display the promax-rotated 2-factor solution as a path diagram

fa.diagram(fa.ml2.promax, errors = FALSE, simple = TRUE, cut = 0.3, digits = 2, main = "2 factor (promax)")
# errors - include error estimates
# simple - Only the biggest loading per item is shown
# digits - Number of digits to show as an edgelable


# Structure matrix 

fa.ml2.varimax$Structure

# Display the promax-rotated 2-factor solution as a path diagram

fa.diagram(fa.ml2.varimax, errors = FALSE, simple = TRUE, cut = 0.3, digits = 2, main = "2 factor (varimax)")
# errors - include error estimates
# simple - Only the biggest loading per item is shown
# digits - Number of digits to show as an edgelable


###############################################################
#           Self practice with the MLFA
###############################################################

# Now practise with the our familiar data "Data_seminar.txt"
# columns - "WMv","WMn","WMf","Spd1","Spd2","Spd3","Spd4","gfv","gfn","gff"

# 1. Factor identification 2. Add rotation 3.Display structure matrix

raw_dat <- read.table("Data_seminar.txt", header = T)
head(raw_dat)

dat2 <- raw_dat[,c("WMv","WMn","WMf","Spd1","Spd2","Spd3","Spd4","gfv","gfn","gff")]
head(dat2)


#-------------------------------
#    Factor identification
#-------------------------------
# One factor (no rotation)
fa2.ml1 <- fa(dat2, nfactors = 1, fm="ml", rotate = "none")
fa2.ml1

# Two factors (no rotation)
fa2.ml2 <- fa(dat2, nfactors = 2, fm="ml", rotate = "none")
fa2.ml2

# Three factors (no rotation)
fa2.ml3 <- fa(dat2, 3, fm="ml", rotate = "none")
fa2.ml3

factor.plot(fa2.ml3, title = "loading diagram" )

#---------------------------------
#          Rotation
#---------------------------------

# promax-rotation (oblique)
fa2.ml3.promax <- fa(dat2, 3, fm="ml", rotate = "promax")
fa2.ml3.promax

#Warning reason: factor loading above 1 (see Heywood cases in the EFA reading chapter)

#graphic representation of the promax-rotated solution
factor.plot(fa2.ml3.promax, title = "promax-rotation" )

#----------------------------------
#        Structure matrix
#----------------------------------

# Structure matrix (correlations of variables with factors)

fa2.ml3.promax$Structure

# Display the promax-rotated 2-factor solution as a path diagram

fa.diagram(fa2.ml3.promax, errors = FALSE, simple = TRUE, cut = 0.3, digits = 2, main = "3 factor (promax)")

