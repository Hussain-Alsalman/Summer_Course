# Continuation from Last Session W2S1
###-----Helping Functions ---------####
library('here')
source(file = here('R_Code', 'help_Functions.R'))


# Reading Data 

library("here")
library("ggplot2")

file_path <- here("datasets", "outlier_cars.txt")

df <- read.table(file = file_path, sep = ',', stringsAsFactors = FALSE,header = TRUE)



# Graphical Methods to identify outliers ----------------------------------

# We can identify the outliers using histograms 
g <- ggplot(df)
g + 
  geom_histogram(aes(x = weightlbs))

# We can identify the outliers using scatter plot 
g + 
  geom_point(aes(x= weightlbs, y = mpg), color = "darkgreen")



# We can always use the boxplot graph to help us 

g + geom_boxplot(aes(y = weightlbs), outlier.colour = "red")

g + geom_boxplot(aes(y = mpg),outlier.colour  = "red")





# Normalizing data -----------------------------------------------------

file_path <- here("datasets", "example_cars.txt")

df <- read.table(file = file_path, sep = ',', stringsAsFactors = FALSE,header = TRUE)


# one of the best practices is to normalize the data. This is basically making all continous variables within the same unit
# It helps make models better 

# There are few ways to normalize the data 

# Min–max normalization

# this will make all values range from 0 to 1 regardless of how large the number is
# You can see that this is very sensetive to outliers 
# Ref : https://www.arabiananalyst.com/2017/11/17/normalizing-data-an-analytical-trick-you-must-know-ar/


x <- (x - min(x))/(max(x) - min(x))

# It is best to create custom function for this 

min_max <- function(v) { 
  mn <- min(v) 
  mx <- max(v)
  
  scl_v <- (v - mn) /(mx - mn)
  return(scl_v)
  }

df["weightlb_scl"] <-  min_max(df$weightlbs)


# Z-SCORE STANDARDIZATION

# the fomula for the z-score is fairly simple 
# z is calculating the z score -- which is a statistical value if that comes down to the following 

#  x - mean / standard deviation

df["weight_z"] <- ((df$weightlbs - mean(df$weightlbs))/ sd(df$weightlbs)) [1]

scale(df$weightlbs)[1]



# Transformation to achive Normality ------------------------------------

# Some data mining algorithms and statistical methods require that the variables be
# normally distributed.

# there are 3 objectives of transforming variables 
  # - To achieve normality  
  # - To stablize the variance 
  # - To achieve linearity 

#Common Transformations are the following 
  # - natural log transformation
  # - square root transformation
  # - inverse root transformation


get_hist(df$weightlb_scl)

# - natural log transformation
get_hist(log(df$weightlbs))

# - square root transformation
get_hist(sqrt(df$weightlbs))

# - inverse root transformation
get_hist(1/sqrt(df$weightlbs))

names(df)

# let's see the effect of the transformation of the data 
ggplot(df,mapping = aes(x = weightlbs, y = mpg)) + geom_point()  + geom_smooth()
ggplot(df,mapping = aes(x = weightlbs, y = 1/sqrt(mpg))) + geom_point() + geom_smooth() 


# Another way to see the effect is drawing histograms 
library("tidyverse")  
df %>% 
  mutate(trans_mpg  = 1/sqrt(mpg)) %>%
  select(mpg, trans_mpg) %>%
  gather(key = "var_type", value = value) %>% 
  ggplot() +
  geom_histogram(aes(x = value , fill = var_type), show.legend = FALSE) +
  facet_wrap(var_type~., scales = "free_x", nrow = 2) + 
  xlab("") + ylab("") 



