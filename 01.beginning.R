#To comment we can use #. (After the # I can write anything I want, since it is a comment for R and it will not run what is written after the #)
#for every operation there should be an explanation. That's why we should comment our R code

#we can use R as a calculator
2+3

#we can assign to an object a value with the operator <-. in this way the object will become a variable 
zima <- 2+3
zima

duccio <- 5+6
duccio

#we can perform some operations with the new variables
zima*duccio

#we can also rename the variables with which we perform the operations
final <- zima*duccio
final
final^2

#array: series of information coded all together
#in this case, we collected data about grams of microplastics in a lake, we concatenate them with the c function and then assign them to the variable sophi.
sophi <- c (10, 20, 30, 50, 50) #microplastics
#c is a function as it has parentheses and inside it there are the arguments of the functions

#we create an array with the amount of people in the different spots where we collected the microplastics. We assign this function to the variable paula. 
paula <- c(100, 500, 600, 1000, 2000) #people

#we can make a plot with sophi (y) and paula (x) with the plot function
plot(paula, sophi)
#we notice a direct correlation between amount of people and microplastics

#if i want to put a new label instead of paula and sophi, I can use again the plot function with the argument xlab=".." and ylab=".."
plot(paula, sophi, xlab="number of people", ylab="microplastics")

#another way to change names of the axis is to rename the old variables
people <- paula
microplastics <- sophi
plot(people, microplastics)

#how to change the plot characteristics
plot(people, microplastics, pch=19) #to change the symbols on the plot I can look on internet "the point symbols in R" and decide which one fits best
plot(people, microplastics, pch=19, cex=2) #we can use the argument cex=".." character exageration to give different sizes to our plot points
plot(people, microplastics, pch=19, cex=2, col="blue") #if i want to change the colours of the plot points i can use the function col="..". remember the quotes!

#how to install packages
#we use the function install.packages . remember to use quotes, as R is taking data from outside 
install.packages("sp") #we need quotes 

#to see if we succeded, we can use the function library. in this case we don't use the quotes anymore as the data are already inside R. 
library(sp) #to check
