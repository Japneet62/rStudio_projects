##########################################################################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.01 - Introduction to the statistical R software
@Japneet Bhatia
##########################################################################################################################

###############
# Practice 1-1
###############

#write commands in R editor
108/44
(8+7-5)*9
(sqrt(4))^2

################
# Practice 1-2
################

# 1.set a working directory
setwd('D:/Working in Oldenburg/Teaching/seminar_analysisR_WT_1920/Session1/Data_and_scripts')

# 2.input data into different variables
sex<-c(1,1,2,2,1,2)
age<-c(18,21,20,26,21,24)
IQ<-c(109,92,103,102,105,105)

# 3.save different variables as a data frame
dat<-data.frame(sex,age,IQ)

# 4.view the data
head(dat)

# 5.save the data frame into a txt file in the working directory
# write.table(dataframe, "Filename.txt", sep="\t", row.names = FALSE)
write.table(dat,"Info.txt",sep = "\t", row.names = FALSE)

#################
# Practice 1-3
#################
setwd("D:/Working in Oldenburg/Teaching/seminar_analysisR_WT_1920/Session1/Data_and_scripts")
dat3 <- read.table("Data_seminar.txt", header = TRUE)

#compute univariate variables
mean(dat3$age)
sd(dat3$age)
min(dat3$age)
max(dat3$age)
head(dat3$age)
tail(dat3$age)


