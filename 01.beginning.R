#Here I can write anything I want, since it is a comment for R
##for every operation there should be an explanation. That's why we should comment our R code

#R as a calculator
2+3

#assign to an object
zima <- 2+3
zima
[1] 5
> duccio <- 5+6
> duccio
[1] 11
> zima*duccio
[1] 55
> final <- zima*duccio
> final
[1] 55
> final^2
[1] 3025

#array: series of information all together
sophi <- c (10, 20, 30, 50, 50) #microplastics
#c is a function, has parentheses and inside there are arguments
paula <- c(100, 500, 600, 1000, 2000) #people
#we can make a plot with sophi (y) and paula (x)
plot(paula, sophi)
#direcly correlation between amount of people and microplastics
> #if i want to put a new label instaed of paula and sophi
> plot(paula, sophi, xlab=number of people, ylab=microplastics)
Error: unexpected symbol in "plot(paula, sophi, xlab=number of"
> plot(paula, sophi, xlab="number of people", ylab="microplastics")
> #another way
> people <- paula
> microplastics <- sophi
> plot(people, microplastics, pch=19) #look on internet the point symbols in r
 plot(people, microplastics, pch=19, cex=2) #character exageration
plot(people, microplastics, pch=19, cex=2, col="blue") #change the colour, remember the quotes

> install.packages("sp") #we need quotes 
> library(sp) #to check
