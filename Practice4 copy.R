####################################################################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.04  - Categorical regression in R - Practice
####################################################################################################################

#set a working directory
setwd("D:/Working in Oldenburg/Teaching/seminar_analysisR_WT_1920/Session4/Data_and_scripts")

# Read in the data 
Data<-read.table("Data_seminar.txt", header = TRUE)
dat<- Data[,c("subject","sex","WMf","APOE","e4","genotype")]

####################################
# Dummy coding (e2/e2 as reference)
####################################

#-----------------------------
# dummy conding using function
#-----------------------------

# e2/e2 is the first row in the data frame, therefore, we select "base=1" here
contrasts(dat$genotype) <- contr.treatment(6, base=1)

head(dat$genotype)
attr(dat$genotype,"contrasts")

#-----------------------------
# dummy coding manually
#-----------------------------

e2e3_vs_e2e2 <- c(0,1,0,0,0,0)
e2e4_vs_e2e2 <- c(0,0,1,0,0,0)
e3e3_vs_e2e2 <- c(0,0,0,1,0,0)
e3e4_vs_e2e2 <- c(0,0,0,0,1,0)
e4e4_vs_e2e2 <- c(0,0,0,0,0,1)

contrasts(dat$genotype) <- cbind(e2e3_vs_e2e2,e2e4_vs_e2e2,e3e3_vs_e2e2,e3e4_vs_e2e2,e4e4_vs_e2e2)
head(dat$genotype)
attr(dat$genotype,"contrasts")

#------------------------
# Regression analysis
#------------------------

# run regression analysis with dummy variables
regression <- lm(WMf ~ genotype, data=dat)
summary(regression)
