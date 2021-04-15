#Workshop: R fundamentals - Part 4: Control structures
#Author: Denisse Fierro Arcos
#Date of creation: 2021-03-28
#Details: 
#In this script we show control structures in R and how to apply them to data

# Loading libraries -------------------------------------------------------
#We will call libraries that are relevant to this script
library(tidyverse)

# Loading data from the web -----------------------------------------------
#You can use R to access datasets available online
#We will access data about deforestation around the world, which available through TidyTuesday
#https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-04-06/readme.md 
forest <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-06/forest.csv')
forest %>% 
  glimpse()



# Subsetting data ---------------------------------------------------------
#There are various ways to use control structures to manipulate your data.
#We will go through each one below

# If, else ----------------------------------------------------------------
#Let's say we want to create a new column which will have a 'deforestation grade'
#This column will have three categories, it will be positive when net forest conversion
#is positive, negative when net forest conversion is negative, and neutral when net
#forest conversion is zero

#Base R solution
#Let's check the first few rows in forest
head(forest)

#Now, let's test our solution on these values
if(forest$net_forest_conversion[1] < 0){
  print("Negative")
}else if(forest$net_forest_conversion[1] == 0){
  print("Neutral")
}else if(forest$net_forest_conversion[1] > 0){
  print("Positive")
}

#But what happens if I put an entire column, instead of one value?
if(forest$net_forest_conversion > 0){
  print("Good")
}else if(forest$net_forest_conversion < 0){
  print("Bad")
}
#We do not get the result we expected

#So how do we apply and if, else statement to an entire column? Use ifelse()
ifelse(test = forest$net_forest_conversion > 0, yes = "Good", no = "Bad")


#Tidyverse solution
forest %>% 
  mutate(deforest_grade = case_when(net_forest_conversion < 0 ~ "Negative",
                                    net_forest_conversion == 0 ~ "Neutral",
                                    net_forest_conversion > 0 ~ "Positive"))


# For loops ---------------------------------------------------------------
#Simple example
Vec <- c(10:20)
Vec
length(Vec)

#To create a loop, we need a counter, we will call it i
for(i in Vec){
  print(i)
}

for(i in 1:10){
  print(i)
}

for(i in 1:length(Vec)){
  print(i)
}

#We can make our loops more complex by adding more operations to it
for(i in Vec){
  j <- i*2
  print(j)
}

#We can save results in a variable
#We can create a new vector
NewVec <- vector()

#We will use the same loop above and make a slight change to save results in the new vector
for(i in 1:10){
  #El i provee el indice del elemento dentro del vector
  NewVec[i] <- i*2
}
NewVec

#We can also use a data frame to save results
#Let's create an ID colum to identify each row in the forest dataset
for(i in 1:nrow(forest)){
  forest$ID[i] <- i
}
tail(forest, n = 10)

#Tidyverse solution - activate magittr package
library(magrittr)

forest <- forest %>% 
  rowid_to_column("ID2") %T>% #This pipe helps you see an intermediate step
  print(head()) %>% 
  tail()

#Note that if you do not assign the manipulated forest dataset to a variable,
#any changes made will not be saved
forest


# While loops -------------------------------------------------------------
#Let's say we want to print lines between 10 and 15

#First, we create our counter, starting from 10
i <- 10
#For the loop - the condition is that the counter must be 15 or less for it to run
while(i <= 15){
  #We print the line as per our counter
  print(forest[i,])
  #We increase the counter by one
  i <- i+1
}


# Using break and next in a loop ------------------------------------------
#We can solve the problem above using break and next
# Our counter will go from 1 to the number of rows contained in forest
for(i in 1:nrow(forest)){
  #We use an if statement. If the counter is less than 10, it will just skip to the
  #next line in the loop
  if(i < 10){
    next
    #Another if statement. If the counter is less or equal to 15, then we will print
    #these rows
    }else if(i <= 15){
      print(forest[i,])
      #Under any other conditions, the loop will finish
      }else(break)}

#Another way of solving it
#Set the counter to the same as the total number of rows
i <- nrow(forest)
#Set a while loop with similar conditions to the ones above
while(i > 10){
  i <- i-1
  if(i <= 15){
    print(forest[i,])
    }else if(i == 10){
      break
      }
}

#What if we only want something to occur when the counter is an even number
#We could use modulo %% to check this, as this will give us the left over amount
#in a division

#For example, 10 (an even number) divided by 2 has a left over of 0
10%%2
#What happens when we divide 11 by 2?
11%%2
#Even numbers always have 0 left over when divided by 2

#Let's use this in a loop
for(i in 1:20){
  #If the counter is an odd number, nothing will happen
  if(i%%2 != 0){
    next
  }
  #If the counter is an even number, then we will print that row
  print(forest[i,])
}


#We can make things more complex, so for example, we can say the loop must break
#when the counter is 5. But this time, we will print odd  numbers
for(i in forest$ID){
  #If i is even then skip to the next step
  if(i%%2 == 0){
    next
  }
  #If i is over 5 then break the loop
  if(i > 5){
    break
  }
  #In any other case
  print(forest[i,])
}


# Loops with repeat -------------------------------------------------------
#Print the first few rows
i <- 1
repeat{
  print(forest[i,])
  i <- i+1
  if(i > 5){
    break
  }
}
