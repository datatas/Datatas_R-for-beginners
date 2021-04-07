#Workshop: R fundamentals - Part 1: Data types
#Author: Denisse Fierro Arcos
#Date of creation: 2021-03-28
#Details: 
#In this script we will go through the different data types that we can use
#in R. 

# Characters --------------------------------------------------------------
"Denisse"
"This is a group of characters"

# Numerical data  ---------------------------------------------------------
#Checking data type for 5
class(5)
#What about a decimal number?
class(20.89)
#Can we force R to recognise a whole number?
10L
class(10L)
#Can I force R to recognise a decimal number as a whole number?
class(10.8L)
#Complex numbers
#Complex numbers are made up of a real number and an imaginary number
30+2i
class(30+2i)

# Logical data ------------------------------------------------------------
#True
TRUE
class(TRUE)
class(T)
#False
FALSE
class(FALSE)
class(F)


# Assigning data to a variable --------------------------------------------
#Easiest way is using <-
x <- "Bobby"
x
class(x)

names <- "Lisa, Nic and Denisse"
names
class(names)

x <- -2L
x
class(x)

y <- 6.8
y
class(y)

z <- 10i
z
class(z)

answer <- T
answer
class(answer)

#You can also use the function `assign`
assign("names", "Lisa, Homer, Marge, Bart")
names
class(names)

#How do we delete variables? Simple, just use `rm`
rm(x, y, z, names, answer)


#Simple calculations -----------------------------------------------------
#Similar to a computer
2+5
2*5
2/5
sqrt(5)
sqrt(5)+2


#Calculations using values held inside variables --------------------------
x <- 2L
y <- 5.5
x+y
class(x+y)

x*x
x^2
class(x*x)
class(x^2)

#More complex calculations
(x+y)*(-x)
x+y*(-x)

#Calculations using complex numbers
sqrt(-1)
sqrt(-1+0i)
class(sqrt(-1+0i))

z <- 30+2i
x+z
class(x+z)

#Calculations with logical/boolean data
a <- F
a*5

b <- T
b*10

(a*5)+(b*10)

#Assigning results of calculations to a variable --------------------------
#New variable
result <- y*x
result

#Updating value of an existing variable
x
x <- x^3
x

y
y <- y/-result
y

rm(a, b, result, x, y, z)


#Species numerical data types ---------------------------------------------
#Inf - Infinite
x <- 15/0
x
class(x)

#NaN - Not a number
y <- 0/0
y
class(y)


# How can we use booleans? ------------------------------------------------
x <- -5
y <- 20
#We can ask if a condition is met
x < y
y <= 15
#We can save whether the condition was met or not
z <- x == 10
z
