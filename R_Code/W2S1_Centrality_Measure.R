#### -----------Centrality Measure ---------####

#The magazine Forbes publishes annually a list of the world’s wealthiest individuals. 
#For 2007, the net worth of the 20 richest individuals, in billions of dollars, 
#in no particular order

billionairs <- c(33, 26, 24, 21, 19, 20, 18, 18, 52, 56, 27, 22, 18, 49, 22, 20, 23, 32, 20, 18)

##Question 1 
## find the mean for the list of billionairs

(33+ 26+ 24+ 21+ 19+ 20+ 18+ 18+ 52+ 56+ 27+ 22+ 18+ 49+ 22+ 20+ 23+ 32+ 20+ 18) / 20

mean(billionairs)

## Question 2
## find the median for the list of billionars 
sort(billionairs, decreasing = FALSE)

median(billionairs)

## Question 3 
# find the mode for the list in billionars 

get_mode <- function(v) { 
  
  uniq <- unique(v) # get the unique values of the vector 
  uniq[which.max(
    tabulate(
      match(v, uniq)
      )
    )
    ] # we assign indecies in match, then show their # of occurances, take max, use it as index in unique values 
}

get_mode(billionairs)




## Visualizing the data might give us a better insight as well. 
## We can vizualize the data to determine the mode and median
library('ggplot2') 

bill_df <- data.frame(billionairs)
annot <- data.frame(statistic = c('mean', 'median', 'mode'), 
                   value = c( mean(billionairs), 
                              median(billionairs), 
                              get_mode(billionairs)
                             ), y_axis = rep(-0.02,3))

ggplot(bill_df, aes(x = billionairs)) +
  geom_dotplot(binwidth = 1, dotsize = .6) +
  scale_x_discrete(limits = min(billionairs): max(billionairs)) +
  geom_text(annot, mapping = aes(y = 0,x=value, label = paste(statistic,'\n',value)), nudge_y = .15)+
  theme_classic() + scale_y_continuous(breaks = NULL) +
  ylab("") +
  labs(title = "Dotplot for top 20 richest people in 2007") + 
  geom_vline(annot,mapping = aes(xintercept = value, color = statistic), alpha = 0.5, show.legend = FALSE)

  

