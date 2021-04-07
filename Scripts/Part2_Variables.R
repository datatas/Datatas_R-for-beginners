#Workshop: R fundamentals - Part 2: Variable Types
#Author: Denisse Fierro Arcos
#Date of creation: 2021-03-28
#Details: 
#In this script we will go through the different variable types that we can use
#in R. 

# Vectors -----------------------------------------------------------------
#Create an empty vector
x <- vector()
x
length(x)

x <- 20
length(x)

y <- 5+(5*3)
length(y)

#Vectors with more than one element
x <- c(5, -10, 15)
x
length(x)
class(x)

#Use sequences to create a vector
x <- (1:10)
x
class(x)
y <- c(-10:-1)
y
z <- c(5.5:26) 
z
class(z)

#Using sequencies incrementing by more than one
x <- c(5, 10, 15)
x
x1 <- seq(from = 5, to = 15, by = 5)
x1
x2 <- seq(from = 5, length.out = 3, by = 5)
x2

#Comparing results - Using booleans
x == x1
x == x2
z <- x == c(5:7)
z
class(z)

rm(x, y, z, x1, x2)

#Use the repeat command to create a vector
x <- rep(10, times = 4)
x
y <- rep(1:3, times = 4)
y
#Repeat each element in the sequence x number of times
z <- rep(seq(1, 3, by = 1), each = 4)
z
#Are these vectors the same?
y == z

#You can use vectors to create bigger vectors
x; y; z
newVector <- c(x, y, z)
newVector
length(newVector)

newVector2 <- c(x, rep(y, 3))
newVector2

newVector3 <- c(y, rep(10:14, each = 3))
newVector3

#Using booleans
newVector3 > 10
newVector3 <= 10
newVector3 != 10

rm(newVector, newVector2, newVector3)

#Performing mathematical operations with vectors
x <- seq(from = 5, to = 15, by = 5)
x
x*5
(10*x)^2
x*pi
sqrt(x)
x * c(1:3)
x * c(1:2)
rm(x, y, z)


#Vectors can also contain strings
names <- c("Laura", "Amy", "Cecilia", "Joe")
length(names)


# Matrices ----------------------------------------------------------------
#You can create a matrix using a sequence
#Include a sequence and the number of rows you want in your matrix
x <- matrix(1:30, nrow = 5)
x
length(x)
dim(x)
class(x)

#Ensure that you have enough elements to create a matrix with the number of rows you want
matrix(1:26, nrow = 5)

#You can also state the number of columns you want your matrix to have
y <- matrix(seq(2,100, by = 5), ncol = 10)
y
dim(y)

#But, why not use both?
z <- matrix(rep(10, 20), ncol = 5, nrow = 4)
z

#You can choose whether the elements of the sequence will appear in the matrix order by row or columns
matrix(1:30, nrow = 5, byrow = FALSE) #by column
matrix(1:30, nrow = 5, byrow = T) #by row

#You can also use an existing vector to create a matrix
x <- seq(1:50)
x
xMat <- matrix(x, nrow = 10) #elements ordered by column
xMat
xMatRow <- matrix(x, nrow = 10, byrow = T) #elements ordered by row
xMatRow

#You can combine matrices to create bigger matrices
#One on top of the other with rbind()
xRow <- rbind(xMat, xMatRow)
xRow
#One next to each other with cbind()
xCol <- cbind(xMat, xMatRow)
xCol


# Changing column and row names in a matrix -------------------------------
xCol
colnames(xCol)
colnames(xCol) <- c("One", "Two", "Three", "Four", "Five", "Six",  "Seven",
                    "Eight", "Nine", "Ten")
colnames(xCol)
xCol

rownames(xCol)
rownames(xCol) <- c("one", "two", "three", "four", "five", "six",  "seven",
                    "eight", "nine", "ten")
rownames(xCol)
xCol


# Data frames -------------------------------------------------------------
#Create an empty data frame
df <- data.frame()

#Create a data frame with multiple columns
df <- data.frame(ID = c(1:5), 
                 Names = c("Elena", "Isabel", "Joe", "Mike", "Laura"),
                 Age = c(rep(30, 3), 15, 18))
df
dim(df)
class(df)
str(df)

#You can create a data frame using existing vectors
ID <- c(1:5)
Names <- c("Elena", "Isabel", "Joe", "Mike", "Laura")
Age <- c(rep(30, 3), 15, 18)
ID; Names; Age
#Putting everything together
df1 <- data.frame(ID, Names, Age)
df1

#Comprobando si los dos data frames son iguales
df == df1

#You can even include the name of each column when creating the data frame
colnames(df1)
df1 <- data.frame(Identification = ID, Name = Names, Age = Age)
df1

#And if you made a mistake in naming the columns, you can change them easily
colnames(df)
colnames(df) <- c("id", "name", "age")
colnames(df)


# Factors -----------------------------------------------------------------
#They are handy when creating groups
City <- c(rep("Hobart", 3), "Perth", "Adelaide")
City
class(City)
City <- factor(City)
City
class(City)
levels(City)

#You can now use these factors to add a new column to our data frame
df <- cbind(df, City)
df
class(df)
str(df)

#Another way of adding a new column to a data frame
df$City2 <- City
df

#If you need to order your factors a certain way, you can
factor(c(rep("Hobart", 3), "Perth", "Adelaide"), levels = c("Hobart", "Perth", "Adelaide"), 
       #You can even include shorter labels
       labels = c("HOB", "PER", "ADE"), ordered = T)


# Lists ------------------------------------------------------------------
Survey <- list(ID = ID,
               Names = Names,
               Participant_Number = 5,
               Student = c(T, F, F, T, NA),
               City = City,
               Survey_Leaders = c("Lisa", "Nic"))
Survey
class(Survey)
#Find the number of elements in the list
length(Survey)

