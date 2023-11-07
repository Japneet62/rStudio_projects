############################################################################
# Seminar: Analysis Methods with R  - Winter Term 2019-2020 - Session 1.08
# - Multilevel regression in R
# @ Xinyang Liu - 2019.12.11
############################################################################

#################################
# Preparation
#################################

# packages - for multilevel models
#install.packages("lme4")
#library(lme4)
#install.packages("car")
library(car)
#install.packages("lmerTest")
library(lmerTest)

# set working directory

setwd("D:/Working in Oldenburg/Teaching/seminar_analysisR_WT_1920/Session9/Data_and_scripts")

#################################
# Dataset 1 
#################################

# This is the COGITO study in morning lecture
# Each participant (Level2) - 70 sessions (Level1)

dat1 <- read.table("ITNA_data.txt", header=TRUE)
head(dat1)

# gr – group; IT – Intrusive thoughts; NA – Negative affect; PCM – Person mean centered
# look at the relationship between negative affect and intrusive thoughts across different indivuduals
scatterplot(na ~ it_Pmc|indiv_id, data=dat1,grid=FALSE,smooth=FALSE)

###############################
# Dataset 2
###############################

# import data
dat <- read.table("Hogwarts.txt", header=TRUE)
head(dat)

# simple linear plot
scatterplot(aggre ~ peer, data = dat, grid = F, smooth = F, boxplots = F)

# picture the data with aggre~peer relationship across different Houses
scatterplot(aggre ~ peer|id_house,data=dat,grid=FALSE,smooth=FALSE)

##################################################
# Multilevel regression - Random intercept model
##################################################

# Research question - What does the (self-reported) aggression inclination of students depend on?
# Predicted variable: (self-reported) aggression inclination 
# Predictors: (1)sex; (2)peer status in class; (3) judgement of teacher

#-----------------------------------------
# 1. Intercept-only model (no predictor)
#-----------------------------------------

# To assess variability of aggression tendency over the Houses
# Default method to estimate the model - restricted maximum-likelihood (REML)

# using the lmer() function from the "lme4" package
#library(lme4)

mod0 <- lmer( aggre ~ 1 + ( 1 | id_house), data = dat)
summary(mod0)

# Intra-class correlation (ICC)
# ICC is ranging between 0 and 1, indicating the similarity of observations clustered under the level-2-units
# Here, the ICC indicates the strength of the "House" effect on agression inclination
ICC <- 0.29/(0.29 + 2.19)
ICC

#---------------------------------------------------
# 2. Random intercept model + sex
#--------------------------------------------------

mod1 <- lmer( aggre ~ 1 + ( 1 | id_house) + sex, data = dat)
summary(mod1)

#---------------------------------------------------
# 3. Random intercept model + sex + peer ratings
#---------------------------------------------------

mod2 <- lmer( aggre ~ 1 + ( 1 | id_house) + sex + peer, data = dat)
summary(mod2)

#--------------------------------------------------------------------
# 4. Random intercept model + sex + peer ratings + teacher judgement
#---------------------------------------------------------------------

mod3 <- lmer( aggre ~ 1 + ( 1 | id_house) + sex + peer + teacher, data = dat)
summary(mod3)


##################################################
# Multilevel regression - Random slope model
##################################################

# Research question - Is the aggression inclination influenced by peer status? Does this relationship vary across Houses?
# Predicted variable: aggression
# Predictors: peer status

# Random intercept model - Null model
RS_mod0 <- lmer(aggre ~ 1 + peer + (1 | id_house), data = dat)
summary(RS_mod0)

# Random slope model
RS_mod1 <- lmer( aggre ~ 1 + peer + ( 1 + peer | id_house), data = dat)
summary(RS_mod1)






