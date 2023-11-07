#############################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.08
# - Logistic regression in R
# - Practice I in class
# @ Your name - 2019.12.4
############################################################################

###############################
# 1.Set working directory
###############################
# use "setwd(...)"



################################
# 2. Get familiar with data
###############################

# 2.1 Import data
# use "read.table(...)"



# 2.2 Name the columns "Q1","Q2","Q3"
# use "names(...)<-c(...)" 



# 2.3 Overview the data
# use "head(...)"



########################################################
# Visualize data features of Q1-Q3 
#########################################################
# Make a boxplot to see the median, min, max and quartiles of scores
# use "boxplot(...)"





# To see the proporten of votes in each question, draw barplots
# use the "table(...)" function to count numbers of each score for three questions seperately, save them to 3 variables
# barplot(...)



# Try using a loop to draw 1*3 barplots for all questions




################################################
# Explore the correlations among Q1 to Q3
################################################
# Compute correlations between Q1,Q2,Q3, as well as significance
# library(Hmisc)
# Hmisc::rcorr(as.matrix(...., use = "complete.obs"))


