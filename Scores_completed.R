#############################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.08
# - Logistic regression in R
# - Practice I in class
# @ Xinyang Liu - 2019.12.4
############################################################################


# set working directory
setwd("D:/Working in Oldenburg/Teaching/seminar_analysisR_WT_1920/Session8/feedbacks")

# import data
dat <- read.table("Scores.txt")
names(dat) <- c("Q1","Q2","Q3")
head(dat)

# make a boxplot
boxplot(dat, main = "questionnaire", xlab = "Questions 1-3")

# barplot
count1 <- table(dat$Q1)
count2 <- table(dat$Q2)
count3 <- table(dat$Q3)

# for one question
par(mfrow=c(1,1))
barplot(count1,main = names(dat[1]))

# draw barplots for each question using a "for" loop
par(mfrow=c(1,3))
for(i in c(1,2,3)) {
  counts <- table(dat[,i])
  name <- names(dat)[i]
  barplot(counts, main=name)
}

# compute correlation matrix
#install.packages("Hmisc")
library(Hmisc)
Hmisc::rcorr(as.matrix(dat, use = "complete.obs"))
# complete.obs - delete all cases with missing values before calculating the correlation