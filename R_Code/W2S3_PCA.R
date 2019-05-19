
# Data Background  --------------------------------------------------------

# the file cadata.txt contains all the the variables. 
# Specifically, it contains median house value, median income, housing median age,
# total rooms, total bedrooms, population, households, latitude, and longitude in that order.

# MHV : median house value
# MI : median income
# HMA : housing median age
# TR : total rooms
# TB : total bedrooms
# P : populatio
# H : households
# LAT : latitude
# LON : longitude
# Spliting the Data  ---------------------------------------------------------------
library("here")
file_path <- here("datasets", "houses20640.csv")
houses20640 <- read.csv(file_path , header = T)

# Check the dimansion 
dim(houses20640)

# Check the first row 
houses20640 [1,]

# Creating index of two classes (1,2) to split the data into Training / Testing 
set.seed(12345)
index <- sample(2, nrow(houses20640), replace = T , prob = c(0.9, .1))

# Check if we have 90% training and 10% testing 
table(index)

0.9 * 20460 

# We seperate the predictors from the target variable and create the training set 
predictor_tr <- houses20640[index == 1,2:9]

# Check the dimansion 
dim(predictor_tr)

# Check the first row 
predictor_tr[1,]


# PCA Calculations --------------------------------------------------------

# calculating PCA -- Eigenvectors and Eigenvalues 

PCA <- prcomp(scale(predictor_tr))

# Extracting Eigenvectors
eigen_vectors <- PCA$rotation

# Extracting Eigenvalues 
eigen_values <- PCA$sdev^2

# Extracting unstanderdized EigenVecotrs (Loadings)
loadings_vectors <- sweep(eigen_vectors,2,PCA$sdev,`*`)



library("ggbiplot")

ggscreeplot(PCA)

ggbiplot(PCA, alpha = 0.1)
