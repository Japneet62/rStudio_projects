############################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.11
# - Exploratory factor analysis in R
# @ Xinyang Liu - 2020.01.22
#  PCA and PAA 
############################################################################

###############################################
#               Preparation
###############################################

# set working path


# install and load package - "psych"


# import data "Well-being.dat" and name variables with "Y1", "Y2", "Y3", "Y4", "Y5", "Y6"


# display the correlation matrix with 2 decimal places



###################################################
#       Principal Component Analysis (PCA)
###################################################

#----------------------
#     Initial model
#----------------------
# 6 main components (without rotation)






#---------------------------------------------------
# Determine the number of relevant major components
#---------------------------------------------------

# Scree plot
# 1) Kaiser‐Criterion
#    eigen value plot - SS loadings (sums of squared loadings)




#    add the straight line y=1




# 2) Parallel analysis





# save the outcome of PCA





#--------------------------------------------------
# main components are extracted - 2 PCs
# Rotation for better interpretability
#--------------------------------------------------

# 2 main components (varimax)


# 2 main components (promax)


# the residual matrix for 2 main components



###################################################
#       Principal Axis Analysis (PAA)
###################################################

# library (psych)

#---------------------------------------------
# Determine the number of factors in PAA
#---------------------------------------------
# Scree plot for PAA



# Scree plot PCA and PAA together



# Obtain the eigen values of PAA



# The eigen values of PAA for the real data



# Eigenvalues of the simulated random data in PAA (red line)



#--------------------------------------------
#        Principal Axis Analysis
#--------------------------------------------
# Initial model



# varimax-rotation (orthogonal)



# promax-rotation (oblique)




####################################################
#  Self practice - PCA with the "Data_seminar.txt"
####################################################

