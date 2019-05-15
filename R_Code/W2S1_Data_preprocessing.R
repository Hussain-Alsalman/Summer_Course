# Data Cleaning 

# We will explain the Data cleaning by going through this dummy example 

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


