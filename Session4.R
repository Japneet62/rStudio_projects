############################################################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.04  - Categorical regression in R
###########################################################################################################

#set a working directory
setwd("D:/Working in Oldenburg/Teaching/seminar_analysisR_WT_1920/Session4/Data_and_scripts")

# Read in the data and select the subset for this project
Data<-read.table("Data_seminar.txt", header = TRUE)
dat<- Data[,c("subject","sex","WMf","APOE","e4","genotype")]

#plot genotype means
library(car)
boxplot(WMf ~ genotype, data = dat, main = "WMf by genotype")

# Write group means in a table
# "tapply()" with "mean" is to return WMf means for each genotype. 
# round() is to set decimal places - “3” means three decimal places
round(tapply(dat$WMf, dat$genotype, mean), 3)

# Check the sample size for each genotype
N <- table(dat$genotype)
N


####################
# Dummy coding
####################

#----------------------------------------------------------------------
# Dummy-coding by using the functions contrast() and contr.treatment() 
#----------------------------------------------------------------------

contrasts(dat$genotype) <- contr.treatment(6, base=6)

head(dat$genotype)
attr(dat$genotype,"contrasts")

#------------------------
# Dummy-coding manually
#------------------------

# define dummy variables by hand
# we can give each dummy code a name so that we know what it compares
e2e2_vs_e4e4 <- c(1,0,0,0,0,0)
e2e3_vs_e4e4 <- c(0,1,0,0,0,0)
e2e4_vs_e4e4 <- c(0,0,1,0,0,0)
e3e3_vs_e4e4 <- c(0,0,0,1,0,0)
e3e4_vs_e4e4 <- c(0,0,0,0,1,0) 

#combind dummy variables and set contrast
contrasts(dat$genotype) <- cbind(e2e2_vs_e4e4,e2e3_vs_e4e4,e2e4_vs_e4e4,e3e3_vs_e4e4,e3e4_vs_e4e4)

head(dat$genotype)
attr(dat$genotype,"contrasts")

#------------------------
# Regression analysis
#------------------------

# run regression analysis with dummy variables
regression <- lm(WMf ~ genotype, data=dat)
summary(regression)


############################
# Unweighted effect coding
############################

#----------------------------------
# define contrasts manually
#---------------------------------

# uwe = unweighted effect

e2e2_e4e4_uwe <- c(1,0,0,0,0,-1)
e2e3_e4e4_uwe <- c(0,1,0,0,0,-1)
e2e4_e4e4_uwe <- c(0,0,1,0,0,-1)
e3e3_e4e4_uwe <- c(0,0,0,1,0,-1)
e3e4_e4e4_uwe <- c(0,0,0,0,1,-1)

contrasts(dat$genotype) <- cbind(e2e2_e4e4_uwe,e2e3_e4e4_uwe,e2e4_e4e4_uwe, e3e3_e4e4_uwe, e3e4_e4e4_uwe)
head(dat$genotype)

# run regression analysis
regression <- lm(WMf ~ genotype, data=dat)
summary(regression)

#compute mean WMf values for each genotype group
uwe_mean <- round(tapply(dat$WMf, dat$genotype, mean), 5)
mean(uwe_mean)

# now compare b0 in the regression equation with unweighted mean

#-------------------------------------------
# unweighted effect coding with R function
#-------------------------------------------

# R function to do unweighted effect coding
contrasts(dat$genotype) <- contr.sum(6)
head(dat$genotype)

# run regression analysis
regression <- lm(WMf ~ genotype, data=dat)
summary(regression)

###################################
# Weighted effect coding
###################################

# Check sample size within the genotypes
N <- table(dat$genotype)
N

# define variables for sample sizes
Nt1 <- 2   #e2/e2
Nt2 <- 36  #e2/e3
Nt3 <- 9   #e2/e4
Nt4 <- 143 #e3/e4
Nt5 <- 45  #e3/e4
Nt6 <- 10  #e4/e4

# calculate and assign weights
e2e2_e4e4_we <- c(1,0,0,0,0,-Nt1/Nt6)
e2e3_e4e4_we <- c(0,1,0,0,0,-Nt2/Nt6)
e2e4_e4e4_we <- c(0,0,1,0,0,-Nt3/Nt6)
e3e3_e4e4_we <- c(0,0,0,1,0,-Nt4/Nt6)
e3e4_e4e4_we <- c(0,0,0,0,1,-Nt5/Nt6)

contrasts(dat$genotype) <- cbind(e2e2_e4e4_we,e2e3_e4e4_we,e2e4_e4e4_we,e3e3_e4e4_we,e3e4_e4e4_we)
head(dat$genotype)

#compute the weighted mean to compare with the intercept in regression
mean(dat$WMf)

# run regression analysis

regre_we <- lm(WMf ~ genotype, data=dat)
summary(regre_we)

#----------------------------------------
# weighted effect coding with R function
#----------------------------------------

#install.packages("wec")
library(wec) 
contrasts(dat$genotype) <- contr.wec(dat$genotype, "e4/e4")
head(dat$genotype)

# run regression analysis
regre_we <- lm(WMf ~ genotype, data=dat)
summary(regre_we)
