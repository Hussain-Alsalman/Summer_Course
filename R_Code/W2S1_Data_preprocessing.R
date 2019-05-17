###-----Helping Functions ---------####
library('here')
source(file = here('R_Code', 'help_Functions.R'))

# Data Cleaning -------------------------------------

#####--We will explain the Data cleaning by going through this dummy example 

# Can you find any issues with this data set?
df <- tribble(
  ~customer_ID , ~postal_code ,   ~gender, ~income,      ~age, ~marital_status, ~transaction_amount,
  1001,          10048,              "M",  "75,000",     "C",      "M",         5000,
  1002,          "J2S7K7",           "F",  "−40,000",    40,       "W",         4000,
  1003,          90210,              "",   "10,000,000", 45,       "S",         7000,
  1004,          6269,               "M",  "50,000",     0,        "S",         1000,
  1005,          55101,              "F",  "99,999",     30,       "D",         3000
)

# Let's go though them column by column 

##customer_ID ? 
#---- looks fine 

##postal_code 
# We have strange value for customer ID 1002 
# some values might need to consult with the doamian expert, In this example the zipcode might relate ~
# to a country where they use mixed letters and numerics such as Canada. 

# We have value of only four digist for customer ID 1004
# we need to investigate if this is a mistake or the system has deleted the leading values.

##Gender? 
# In gender we see a missing value for the customer id 1003
# we have a missing value , we will go over detail analysis of missing values soon. 

## Income? 
# We have strange values with Customer ID 1003
# This person makes 10 million dollars a year. This could be a mistake or true (we can investigate other columns)

# We have strange values with Customer ID 1004
# Making negative money does not make sense. However, we don't how this value came about. We don't know what the true value is 

## Age ? 
# Customer ID 1001 has an age of "C" which is odd given all the other records has numeric values. 
#Maybe it was migrated form old system that uses different categorization 

# Customer ID 1003 has an age of zero. This could be a newborn, but when we look at the income it does not make sense. 
# Most likely this value is missing as well and we need to handle this. 


## Maritual status ? 
# At quick glance this seems ok. but we need to make sure we know exactly what those letters mean. 
# while "M" could mean married and "D" mean Divorce and "W" Widowed, "S" could mean Single or Seperated. 
 #----------------# Ref : http://www23.statcan.gc.ca/imdb/p3VD.pl?Function=getVD&TVD=61748&CVD=61748&CLV=0&MLV=1&D=1
# That's why having domain expert is important 


# Handling missing data -------------------------------------------------

#Data Background 
#The data set consists of information about 261 automobiles manufactured in the 1970s and 1980s,
#including gas mileage, number of cylinders, cubic inches, horsepower,

# Reading Data 

library("here")

file_path <- here("datasets", "example_cars.txt")

df <- read.table(file = file_path, sep = ',', stringsAsFactors = FALSE,header = TRUE)

#let's assume two values are missing 

df[2,"cubicinches"] <- ""
df[4,"brand"] <- ""
# lets examine the first 10 rows 

head(df, 5)

# We can either remove the records  with missing values 
remove_df <- df[c(-2,-4),]
head(remove_df,5)

# or we replace it .. 
# Common Criteria For Replacement -----------------------------------------
# 1. Replace the missing value with some constant, specified by the analyst.
# 2. Replace the missing value with the field mean (for numeric variables) or the
# mode (for categorical variables).
# 3. Replace the missing values with a value generated at random from the observed distribution of the variable.
# 4. Replace the missing values with imputed values based on the other characteristics of the record.

#lets examine the first three 
# 1. Replace the missing value with some constant, specified by the analyst.

constant_df <- df
head(constant_df,5)

constant_df[2,3] <- 0
constant_df[4,8] <- "Missing"

# programatically 

constant_df$cubicinches[which(constant_df$cubicinches == "")] <- 0
constant_df$brand[which(constant_df$brand == "")] <- "Missing"

head(constant_df,5) # Important if the analyst want to further analyze the data 


# 2. Replace the missing value with the field mean (for numeric variables) or the
# mode (for categorical variables).

mean_df <- df
head(mean_df,5)

# Before we calculate the mean, we need to make sure we have the write format for each column
str(mean_df)
mean_cubicinches <-  round( mean(as.numeric(mean_df$cubicinches), na.rm = TRUE) , 0)

# We now Impute mssing values with the mean 
mean_df$cubicinches[which(mean_df$cubicinches == "")]  <-  mean_cubicinches

# if we examine the distribution .. the median might be better 
get_hist(as.numeric(df$cubicinches), ant_nudge = 20)
median_cubicinches <- median(as.numeric(mean_df$cubicinches), na.rm = TRUE)

# For categorical values we can use the mode 
mean_df$brand[which(mean_df$brand == "")] <- get_mode(mean_df$brand)


# 3. Replace the missing values with a value generated at random from the observed distribution of the variable.
rand_df <- df 
# we set the seeds to make sure we have the same results - only for the purposes of this lecture.
set.seed(1)
rand_cubicinches <- rnorm(1, mean = mean_cubicinches, sd = sd(as.numeric(df$cubicinches), na.rm = TRUE))


head(rand_df)
rand_df$cubicinches[which(rand_df$cubicinches == "")] <- round(rand_cubicinches,0)
head(rand_df)

# for categorical we select it from random sampling with probability in mind 

prb <- prop.table(table(rand_df$brand, exclude = ""))
rand_brand <- sample(size = 1,x = names(prb),prob = as.vector(prb))



# Identifying Missclasifications ------------------------------------------

mc_df <- df 
# let's add missclassification in the data 
set.seed(1)
mc_idx_us <- sample(2, x = which(mc_df$brand =="US"))
mc_idx_er <- sample(1, x = which(mc_df$brand =="Europe"))
mc_df$brand[mc_idx_us] <- "USA"
mc_df$brand[mc_idx_er] <- "France"

#lets first look into the structure of our data using str() 
str(mc_df)

#Let's see how many categories we have in Brands 
table(mc_df$brand)

#Let's fix them 

mc_df$brand[which(mc_df$brand =="USA")] <- "US"
mc_df$brand[which(mc_df$brand =="France")] <- "Europe"

table(mc_df$brand)





