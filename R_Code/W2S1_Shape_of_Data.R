
###-----Helping Functions ---------####
library('here')
source(file = here('R_Code', 'help_Functions.R'))
#-------------------------------------- 

## We have already explored visualizng histograms to look at the shape of our data. 
## There are few measures to describe the shape of the distribution of the data 

## Kurtosis 
#-----#: The larger the kurtosis, the more tail-heaviness of the distribution will be.
#-----#: value of 3 indicate that the distribution tails are close to normal distribution.


library('e1071')
# 'faithful' Dataset 
# A data frame with 272 observations on 2 variables.
# [,1]	eruptions	numeric	Eruption time in mins
# [,2]	waiting	numeric	Waiting time to next eruption (in mins)

data("faithful")
# We can see that the tails of the X1 or eruptions are less tailed , 
kurtosis(faithful$eruptions)
kurtosis(faithful$waiting)
compare_hist(x1 = faithful$eruptions,x2 =  faithful$waiting) 


## Skewness 
#-----#: Distribution stretches to the right more than it does to the left, we say that the distribution is right skewed.
#-----#: left-skewed distribution is one that stretches asymmetrically to the left.
#-----#: Zero skewness implies a symmetric distribution
#-----#: A positive skewness implies a right-skewed distribution
#-----#: A negative skewness implies a left-skewed distribution

skewness(faithful$eruptions)
skewness(faithful$waiting)


## Simulated data
right_skew <-rbeta(1000, 2,5)
left_skew <- rbeta(1000, 5,1)

#Right skewness 
skewness(right_skew)

#Left skewness
skewness(left_skew)


## Let's see boxplots again and see more summary statistics  
library("ggplot2")
head(mpg)

ggplot(mpg, mapping = aes(y = hwy, x = manufacturer)) +
  geom_boxplot(outlier.colour = "red") +
  coord_flip() + scale_y_continuous(breaks = 1:50) + geom_jitter(aes(color = model, group = manufacturer))



