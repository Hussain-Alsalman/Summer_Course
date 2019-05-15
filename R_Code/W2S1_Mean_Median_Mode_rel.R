###-----Helping Functions ---------####
library('here')
source(file = here('R_Code', 'help_Functions.R'))
#-------------------------------------- 


## Simulated data
set.seed(106)
right_skew <-round(rbeta(10000, 2,5), 4)
left_skew <- round(rbeta(10000, 5,1), 4)
bell_curve <- round(rnorm(100000), 2)

get_hist(bell_curve, ant_nudge = -10)

# What is the relationship between Median & Mean & Mode with the shape of the distribution. 
