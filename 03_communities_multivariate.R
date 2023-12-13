#we will use vegan package for our multivariate analisys for community ecology. Vegan means vegetation-analysis
#Overlap package is perfect to see how species are interacting over time
install.packages("vegan")
library(vegan)
install.packages("overlap")
library(overlap)

#to recall the data from our dataset, we use the function data()
data(dune)
dune #we have a matrix of several data all together
head(dune) #to see the first six rows of the samples

#we can use the "detrended correspondence analysis" to see how species are correlated between each other in a plot. 
#this also helps us to reshape the data in a simpler manner
#to do this, we use the function decorana ()
ord<-decorana(dune)
ord

#on the console there are displayed the values of "axis lenght" 
ldc1=3.7004 
ldc2=3.1166
ldc3=1.30055 
ldc4=1.47888

#and the total is given by
total<-ldc1+ldc2+ldc3+ldc4
total

#let's calculate the percentage of each axes lenght compared to the total
pldc1=ldc1*100/total
pldc2=ldc2*100/total
pldc3=ldc3*100/total
pldc4=ldc4*100/total
pldc1
pldc2
pldc3
pldc4

pldc1 + pldc2 #we see 1 and 2 that together make more than 70% of the total 

#final plot
plot(ord) #here we see how different species are related (or not) to each other

