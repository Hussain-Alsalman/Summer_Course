
###-----Helping Functions ---------####
library('here')
source(file = here('R_Code', 'help_Functions.R'))
#-------------------------------------- 

## Let's consider the following datasets 
## The main question, are those data sets similiar. How different are those data sets. 
set_1 <- c(1, 2, 3, 4, 5, 6, 6, 7, 8, 9, 10, 11)
set_2 <- c(4, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 8)

# lets see N in the sample for each data set 
length(set_1)
length(set_2)


# Calculating the average for both sets 
mean(set_1)
mean(set_2)

# Calculate the median for both sets

median(set_1)
median(set_2)

# Calculate the mode for both sets 

get_mode(set_1)
get_mode(set_2)

## Are the those data the same ?? 
## lets visualize them 

get_dotplot(set_2, ant_nudge = 0.5)

## In this case measure of centrality is not enough 
## let's use different tools to describe data 

## Question 1  calculat the range 

## We can use the range to see the spread of the data 
max(set_1) - min(set_1)
max(set_2) - min(set_2)

## Question 2  calculat the standard deviation
sqrt(sum((((set_1 - mean(set_1))^2)/(length(set_1)-1))))

sqrt(sum((((set_2 - mean(set_2))^2)/(length(set_2)-1))))

## Question 3 calculate the variance of the data set 

sum((((set_1 - mean(set_1))^2)/(length(set_1)-1)))
sum((((set_2 - mean(set_2))^2)/(length(set_2)-1)))

## We usually do use variance because its unit does not make sense.
var(set_1)
var(set_2)


## We can visualize the data using the histogram. __ we will use the base graphing 
x_lim <- range(-4,14)
y_lim <- range(0,5)
yaxis <- 0:5
xaxis <- -4:14

hist(set_1, xlim = x_lim, xaxt="n", yaxt = "n", ylim =y_lim )
axis(side = 2,at = yaxis,labels  = yaxis)
axis(side = 1,at = xaxis,labels  = xaxis)

hist(set_2,xlim =  x_lim,xaxt="n", yaxt = "n", ylim =y_lim)
axis(side = 1,at = xaxis,labels  = xaxis)
axis(side = 2,at = yaxis,labels  = yaxis)

## or We can use the ggplot2 geom_hist function 
## it is important to know that ggplot only accepts data frames 

sets_df <- data.frame(set_1, set_2)

## Making data sets Tidy format 
sets_df <- gather(sets_df, key = "set_number", value = "value")

## Ploting the two data on top of each other. 
ggplot(sets_df, mapping = aes(x = value, fill = set_number)) +
  geom_histogram(bins =20 ,alpha = 0.5, position = "identity") 
  

## Ploting the two data sets by using faceting 
library("tidyverse")
ggplot(sets_df) + geom_histogram(mapping = aes(x = value, fill = set_number), show.legend = FALSE) +
  facet_wrap(nrow = 2, ncol = 1, . ~set_number)  

