#Workshop: R fundamentals - Part 3: Subsetting Data
#Author: Denisse Fierro Arcos
#Date of creation: 2021-03-28
#Details: 
#In this script we show how to subset data stored in a variable

# Access a specific element inside a vector -------------------------------
names <- c("Laura", "Luke", "Rob", "Karen")
names[4]
names[1:2]
names[c(1,3)]
names[c(1,3:4)]
names[-2]

#Access an element and change its content
names[4] <- "George"
names
#Add elements to a vector
names[5] <- "Mary"
names
names[6:7] <- c("Isabel", "Stella")
names
names[9] <- "Pablo"
names
#NA means that no data is available in that particular location
rm(names)

#The same principles apply to numeric vectors
x <- seq(from = 5, to = 15, by = 5)
x
x[1] <- 30
x


# Accessing elements in a matrix ------------------------------------------
xRow <- matrix(seq(1:50), nrow = 10)
#By row
xRow
xRow[1,]
xRow[1:3,]
xRow[c(1, 5),]
rownames(xRow) <- c("one", "two", "three", "four", "five", "six",  "seven",
                    "eight", "nine", "ten")
xRow["one",]

#By column
xRow[,1]
xRow[,3:5]
xRow[,c(2, 4)]
colnames(xRow) <- c("One", "Two", "Three", "Four", "Five")
xRow[,"One"]

#By element
xRow[1,5]
xRow[10,3]
xRow["four", "Three"]
xRow[10, "Three"]

#You can call an element/column/row and assign new values
xRow
xRow[1,] <- 3
xRow
xRow[,1] <- rep(1:5, 2)
xRow
xRow[3,5] <- 100
xRow
xRow["four", "Three"] <- 350
xRow

#We can also use indexes to change column or row names
colnames(xRow)[5]
colnames(xRow)[5] <- "FIVE"
colnames(xRow)
rm(xRow, x)


# Accessing elements in a data frame --------------------------------------
df <- data.frame(ID = c(1:5), 
                 Names = c("Elena", "Isabel", "Joe", "Mike", "Laura"),
                 Age = c(rep(30, 3), 15, 18),
                 City = factor(c(rep("Hobart", 3), "Perth", "Adelaide")))
#Access an element and assign a new value
df$Age[3] <- NA
df

#Access columns and rows in the same way as matrices
#Row 1
df[1,]
#Column 3 (age)
df[,3]
#You can also use the name of the column to access data
df$Age
df["Age"]

#Is there a difference?
class(df$Age)
class(df["Age"])

#Calling row 1, column 2 (name)
df[1, 2]
df$Names[1]
df[1, "Names"]

#Aggregate data in a table using the City column
table(df$City)
table(df['City'])
table(df[,4])


#Accessing elements of a list ---------------------------------------------
Survey <- list(ID = c(1:5),
               Names = c("Elena", "Isabel", "Joe", "Mike", "Laura"),
               Participant_Number = 5,
               Student = c(T, F, F, T, NA),
               City = factor(c(rep("Hobart", 3), "Perth", "Adelaide")),
               Survey_Leaders = c("Lisa", "Nic"))

#Now access an item in the list
Survey$Names
Survey[['Names']]
Survey[2]

#Access one element of a specific list item
Survey$City[3]
Survey[['City']][3]

#Find out the length of each list item
length(Survey$Names)
length(Survey$Participant_Number)

#Assign a new value to an element
Survey$ID <- seq(1, 16, by = 3)
Survey

#Add a new list item
Survey$ID2 <- c(1:5)

#Assign a new value to one element of a list item
Survey$Survey_Leaders[2] <- "Pete"
Survey

#Access name of list items and assign a new value
names(Survey)
names(Survey)[1] <- "Identification"
names(Survey)


# Relational Operators ----------------------------------------------------
#Let's call a couple of libraries for this part of the workshop
library(tidyverse)
library(palmerpenguins)

# Load the Palmer penguin dataset -----------------------------------------
df <- penguins

#You can check its structure
str(df)
#You can also use the tidyverse option
glimpse(df)
#Check column names
names(df)

#Let's get the penguins with flipper length over 190 mm
df$flipper_length_mm >= 190
#If I want to get the index (position) where the above condition is met, then I use which()
which(df$flipper_length_mm >= 190)

#I can use these indexes to actually call those rows, so I can check the individuals that meet this condition 
head(df[which(df$flipper_length_mm >= 190),])
#Or I can not use which()
head(df[df$flipper_length_mm >= 190,])

#Tidyverse equivalent
df %>% 
  filter(flipper_length_mm >= 190) %>% 
  head()


#I can also call all rows with female penguin information
df$sex == "female"
#I can use a condition and state which columns I am interested in seeing
df[df$sex == "female", c("species", "body_mass_g")]
#Add which to ignore rows that do not meet the condition
df[which(df$sex == "female"), c(1, 6)]

#Tidyverse equivalent
df %>% 
  filter(sex == "female") %>% 
  select(species, body_mass_g)

# Using logical operators to access data ----------------------------------
#Access data for Adelie or Gentoo penguins from 2008

#Let's do it step by step 
#Access data from 2008 onwards
df$year > 2008
df$year >= 2008
head(df[df$year >= 2008,])

#How can we identify the rows for Adelie penguins
df$species == "Adelie"
df[df$species == "Adelie",]
df[which(df$species == "Gentoo"),]

#Putting it together
df$species == "Adelie" | df$species == "Gentoo"
df[df$species == "Adelie" | df$species == "Gentoo",]

#Now add the year limits
df$species == "Adelie" | df$species == "Gentoo" & df$year >= 2008
df[df$year >= 2008 & (df$species == "Adelie" | df$species == "Gentoo"),]

#Tidyverse solution
df %>% 
  filter((species == "Adelie" | species == "Gentoo") & year >= 2008)


# You can also subset data using the subset command -----------------------
#Access data for male Chinstrap penguins from 2007, but only bring up the species, island and body mass columns
ChinstrapData <- subset(df, subset = year == 2007 & species == "Chinstrap" & sex == "male", 
                        select = c(species, island, body_mass_g))

ChinstrapData

#Tidyers solution
df %>% filter(year == 2007 & species == "Chinstrap" & sex == "male") %>% 
  select(species, island, body_mass_g)

#Bonus:
#You can use R to access datasets available online
#We will access data about deforestation in Brazil, which available through TidyTuesday
#https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-04-06/readme.md 
forest <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-06/forest.csv')
glimpse(forest)
