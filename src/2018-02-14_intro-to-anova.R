

#******************************************************
# ANOVA: WHAT'S IT ALL ABOUT? 
#******************************************************

# ignore this ---------------
library("magrittr")
library("dplyr")
library("here")
source(here("src", "coin.toss_function.R"))

# look at some data: ------------------
coin.toss(reps=20, 
          numcoins = 7, 
          layout=1)



# what happens if we increase sample size? 







# Create a dataframe of response values as a random variable: --------
data <- data.frame(predictor1=rep(1, 100),  # this is the y-variable
                   
                   response=c(rnorm(50, mean=100, sd=10),  # x-variable
                               rnorm(50, mean=115, sd=10))) 

# take a quick look at the data: 
View(data)

# plot it: 
plot(data);
abline(h=mean(data$response), col="blue")  # add line for mean

# note that this is a valid statistical model; just probably not at 
#     great one. 

hist(data$response)


# QUESTION: How can we explain the variation in the response? 

# Is it all randomness? 
# Is it related to any other variables? 
# How would we know? 






#******************************************************************
# lets add another predictor: 
data %<>% mutate(predictor2 = rep(c(1,2), each=50))
View(data)


# compare 2 plots: 
setpar <- par(mfrow=c(1,2))  # display 2 graphs side-by-side
plot(data$response~data$predictor1)
plot(data$response~data$predictor2)
par(setpar)  # par(mfrow=c(1,1))


# by separating the variance according to values of predictor2, 
#     we can explain what's causing the difference in response, 
#     and we can test if it's a meaningful effect. 








#*******************************************************
# REGRESSION FOR ED DATA
#*******************************************************
head(visits)

# ANOVA FOR FY 16/17 ---------------------------
visits2 <- filter(visits, fyear=="16/17")

anova1.day.of.week <- lm(num.visits ~ day.of.week, data = visits2)

summary(anova1.day.of.week)
# intercept is friday in fy16/17

# interpretation of anova: 
# 1) reject H0: no effect from day of week
# 2) compared to Friday, 
#     > Monday is higher
#     > Saturday is lower
#     > for other days of week, probably better to just average across




# ANOVA FOR FY 12/13------------------------------
visits3 <- filter(visits, fyear=="12/13")

anova2.day.of.week <- lm(num.visits ~ day.of.week, data = visits3)

summary(anova2.day.of.week)
# intercept is friday in fy16/17

# interpretation of anova: 
# 1) reject H0: no effect from day of week

