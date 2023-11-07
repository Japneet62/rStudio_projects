############################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.11
# - Exploratory factor analysis in R
# @ Xinyang Liu - 2020.01.29
#  PCA and PAA 
############################################################################

###############################################
#               Preparation
###############################################

# set working path
setwd("D:/Working in Oldenburg/Teaching/seminar_analysisR_WT_1920/Session11/Data_and_scripts")

# load package
library(psych)
library(GPArotation)

# import data and name variables
dat <- read.table("Well-being.dat", header = FALSE) 
names(dat) <- c("Y1", "Y2", "Y3", "Y4", "Y5", "Y6")
head(dat)

#display the correlation matrix with 2 decimal places
round(cor(dat), 2)

###################################################
#       Principal Component Analysis (PCA)
###################################################

#----------------------
#     Initial model
#----------------------
# 6 main components (without rotation)
pc1 <- principal (dat, 6, rotate = "none")
pc1

# NOTE
# 1) The result represent the loading from each factor or component to each variable
# 2) h2 is the communalities. These communalities are all equal to 1 because we’ve explained
#    all of the variance in every variable
# 3) u2 is the uniqueness column

#---------------------------------------------------
# Determine the number of relevant major components
#---------------------------------------------------

# Scree plot
# 1) Kaiser‐Criterion
#    eigen value plot - SS loadings (sums of squared loadings)
plot(pc1$values, type = "b", xlab = "Component Number", ylab = "eigen values of PCA analysis", main = "PCA Scree Plot")

#    add the straight line y=1
abline(a=1, b=0, col = "red")

# 2) Parallel analysis
fa.parallel (cor(dat), n.obs = 203, fa = "pc")
# fa="pc" - eigen values for principal components 

# save the outcome of PCA
parallel.pc <- fa.parallel (cor(dat), n.obs = 203, fa = "pc")

# The eigen values of principal components of the real data (blue line)
round (parallel.pc$pc.values, 2)

# Eigenvalues of the simulated random data in PCA (red line)
round (parallel.pc$pc.sim, 2)

#--------------------------------------------------
# main components are extracted - 2 PCs
# Rotation for better interpretability
#--------------------------------------------------

# 2 main components (varimax)
pca_2.varmax <- principal (dat, 2, rotate = "varimax")
pca_2.varmax

# 2 main components (promax)
pca_2.promax <- principal (dat, 2, rotate = "promax")
pca_2.promax

# the residual matrix for 2 main components
round (pca_2.promax$residual, 3)


###################################################
#       Principal Axis Analysis (PAA)
###################################################

# library (psych)

#---------------------------------------------
# Determine the number of factors in PAA
#---------------------------------------------
# Parallel analysis
fa.parallel(cor(dat), n.obs = 203, fa = "fa", nfactors = 2) 
# fa = "fa" - a principal axis factor analysis (fa="fa")

# Obtain the eigen values of PAA
parallel.faa <- fa.parallel(cor(dat), n.obs = 203, fa = "fa", nfactors = 2) 

# The eigen values of PAA for the real data
round (parallel.faa$fa.values, 2)

# Eigenvalues of the simulated random data in PAA (red line)
parallel.faa $ fa.sim

#--------------------------------------------
#        Principal Axis Analysis
#--------------------------------------------
# Initial model
fa.paa <- fa(dat, 2, fm = "pa", rotate = "none")
fa.paa

# varimax-rotation (orthogonal)
fa.paa.varimax <- fa(dat, 2, fm = "pa", rotate = "varimax")
fa.paa.varimax

# promax-rotation (oblique)
fa.paa.promax <- fa(dat, 2, fm = "pa", rotate = "promax")
fa.paa.promax

##################################################
#  Self practice - with the "Data_seminar.txt"
##################################################

