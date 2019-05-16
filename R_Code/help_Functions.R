###-----Helping Functions ---------####

# FUNC: Custom function to calculate mode ---------------------------------

get_mode <- function(v) { 
  
  uniq <- unique(v) # get the unique values of the vector 
  uniq[which.max(
    tabulate(
      match(v, uniq)
    )
  )
  ] # we assign indecies in match, then show their # of occurances, take max, use it as index in unique values 
}


# FUNC: dotplot with Mean,Median,Mode -------------------------------------

get_dotplot <- function(v,ant_nudge = .15) {
  require('ggplot2') 
  
  ## Creating the data frame 
  df_1 <- data.frame(v) 
  ## Creating the annotations 
  annot <- data.frame(statistic = c('mean', 'median', 'mode'), 
                      value = c( mean(v), 
                                 median(v), 
                                 get_mode(v)
                      )
  )
  
  ## Creating the Dotplot graph
  g <- ggplot(df_1, aes(x = v)) +
    geom_dotplot(binwidth = 1, dotsize = .6) +
    scale_x_discrete(limits = min(v): max(v)) +
    geom_text(annot, mapping = aes(y = 0,x=value, label = paste(statistic,'\n',value)), nudge_y = ant_nudge)+
    theme_classic() + scale_y_continuous(breaks = NULL) +
    ylab("") +
    geom_vline(annot,mapping = aes(xintercept = value, color = statistic), alpha = 0.5, show.legend = FALSE)
  return (g)
}


# FUNC: Comparing two histograms ------------------------------------------
compare_hist <- function(x1,x2) {
  require("tidyverse")
  require("ggplot2")
  
  df<- data.frame(x1,x2)
  df_tidy <- gather(df,key = 'set', value = 'value')
  

ggplot(df_tidy) + geom_histogram(mapping = aes(x = value, fill = set), show.legend = FALSE) +
  facet_wrap(nrow = 2, ncol = 1, . ~set)  


}


# FUNC: Creating one Histogram with Mean Median and Mode ------------------

get_hist <- function(v,ant_nudge = .15) {
  require('ggplot2') 
  
  ## Creating the data frame 
  df_1 <- data.frame(v) 
  ## Creating the annotations 
  annot <- data.frame(statistic = c('mean', 'median', 'mode'), 
                      value = c( round(mean(v,na.rm = TRUE),4), 
                                 round(median(v,na.rm = TRUE),4), 
                                 round(get_mode(v),4)
                      )
  )
  
  ## Creating the Dotplot graph
  g <- ggplot(df_1, aes(x = v)) +
    geom_histogram(fill = "navy", alpha = 0.7,bins = 100) +
    geom_text(annot, mapping = aes(y = 0,x=value, label = paste(statistic,'\n',value)), nudge_y = ant_nudge, check_overlap = TRUE)+
    theme_classic() + scale_y_continuous(breaks = NULL) +
    ylab("") +
    geom_vline(annot,mapping = aes(xintercept = value, color = statistic), alpha = 0.5, size = 2)
  return (g)
}


# FUNC : Adding missing values  -------------------------------------------

add_missing <- function(df, columns,p) {
  
  df_curpt <- apply(df[,columns,drop = F], c(1,2), function(x) {
    a <- rbinom(1,c(1,0), prob = c(p,1-p))
    ifelse(a==1,"",x)})
  df_curpt <- data.frame(df_curpt)
  df[,colnames(df_curpt)] <- df_curpt[,colnames(df_curpt)]
  return(df)
}