#M&M Example

# We Have a bag of of M&M with dirfferent colors 
#Determining the sample size 
n_size <- 1000

#Doing the sample with replacement with known probability 
mm <- sample(c("R","Y", "B", "G"), n_size, replace = TRUE, prob = c(.10, .20, .40, .30))


mm_tbl <- table(mm)

#Barplot 
barplot(mm_tbl, col = c("blue", "Green", "Red", "Yellow"), ylim = range(0,400))

#Random wieghts for each M&M 
mm_w <- rlnorm(n_size, meanlog = 0, sdlog = .3)

#Combining both variables in one Bag
mm_bag <- data.frame(mm, mm_w)

#Renaming the colomn names 
colnames(mm_bag) <- c("color", "weight")


# looking the the data 
head(mm_bag)

#distribuation of the M.M weights 
barplot(mm_w)
# breaks = 100
# breaks = 500
hist(mm_w, breaks=50, probability = TRUE)


lines(density(mm_w), col= "red")




