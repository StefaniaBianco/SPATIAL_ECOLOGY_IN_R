#FINAL SCRIPT INCLUDING ALL THE DIFFERENT SCRIPTS DURING THE LECTURE

#Summary:
#01 Beginning
#02.1 Population density
#02.2 Population distribution
#03.1 Communities multivariate

#-----------

#01 Beginning


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

#-----------

#02.1 Population density

#Let's work with some code related to population ecology.

# a package is needed for point pattern analysis: spatstat
# we can add packages from CRAN (The Comprehensive R Archive Network) 
install.packages("spatstat")
library(spatstat) #to check
#if we want to see the data description, we can go on CRAN website. https://CRAN.R-project.org/package=spatstat

#let's use the bei dataset, that is inside spatstat
bei 
#we now want to plot the data
plot(bei)
#we see points representing trees monitored in Amazzonia
#if we want to change plot charactestics, we can use cex (0.5 or .5) for the size and pch for the points symbol.
plot(bei, cex=0.2, pch=19)

#additional dataset to see an image file (raster):
bei.extra
plot(bei.extra)

#let's use only part of the bei dataset: elev
#first method: we use the $ to extract what we need
bei.extra$elev
elevation <- bei.extra$elev
plot(elevation)

#second method: data filtering
elevation2 <- bei.extra[[1]]
plot (elevation2)

# This is a density map, but we want R to calculate the points as a continuous surface.
# We can consider each group of dots as a single unit, where each unit is going to be more or less dense according to the number of dots present in that area.
# We use the "density" function to create the density map and we rename it
density.map <- density(bei)
density.map
plot(density.map)
# We are working with pixels
# To read the map: blue is low density instead yellow is high density.

# By using the "points" function we can put points on the top of the density map, just adding it to the past "bei" plot.
points(bei, cex=0.2)

# Using the "colorRampPalette" function we can change the density map colors by concatenating the colors.
# and using 100 as a gradient.
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100)
plot(density.map, col=cl)

# another example:
cl2 <-colorRampPalette(c("yellow", "red", "orange", "black"))(100)
plot(density.map, col=cl2)

# Exercise: built a new color palette
cl.ex <-colorRampPalette(c("cornsilk","darkred", "coral", "aquamarine"))(100)
plot(density.map, col=cl.ex)
cl.ex2 <-colorRampPalette(c("aquamarine", "coral", "darkred", "cornsilk"))(100)
plot(density.map, col=cl.ex2)

# To get an additional variable, we use the "bei.extra" dataset.
#in our case we will add the "elevation" to the gradient.
plot(bei.extra)

# We set the elevation into an element which we call "elev" and we plot it.
# We will obtain only the elevation plot.
elev <- bei.extra[[1]] #or bei.extra$elev
plot(elev)

# HOW TO PLOT SEVERAL THINGS ALL TOGETHER?
# By using the "par" function we can plot several things all together. We use the "multiframe" argument
# Inside the array we need to state how many rows and coloumns we want to plot, by concatenating them.
par(mfrow=c(1,2))
plot(density.map)
plot(elev) #run all the elements together

par(mfrow=c(2,1))
plot(density.map)
plot(elev)

#HOW TO CHANGE THE MAP COLORS?
par(mfrow=c(1,2))
plot(density.map, col=cl.ex)
plot(density.map, col=cl.ex2)

par(mfrow=c(1,2))
plot(density.map, col=cl)
plot(density.map, col=cl2)

#EXERCISE
#Run three elements together
par(mfrow=c(1,3))
plot(bei)
plot(density.map)
plot(elev)

#-----------

#02.2 Population distribution

#Why populations disperse over the landscape in a certain manner?
#we will use the package sdm (species distribution model) to work with population distribution
install.packages("sdm")
library(sdm) #to check if it correclty installed
#another package we will use is terra
install.packages("terra")
library(terra) 

#"system.file" function is made to check the name of a file inside R folder
system.file("external/species.shp", package="sdm") #Finds the full file names of files in packages
file <- system.file("external/species.shp", package="sdm") #we assign the name file to the file we want to work on
file

#this is a VECTOR file with coordinates. in terra package there's a function that deals with vectors (vec)
rana <- vect(file)

#to link two elements in R we use the $ symbol
rana$Occurrence

#these codes are called PRESENCES AND ABSENCES DATA (on the console is shown 0, 1, 0,...)
#0 is an uncertain data, because it could be a error  of your evaluation/monitoration
#with plot function we visualize the data
plot(rana)
plot (rana, cex= 0.5) #to change points size

#Selecting presences
#we use "Occurence" and we set it equal to 1, , selecting the presences
rana[rana$Occurrence == 1,]
pres <- rana[rana$Occurrence ==1,]
pres$Occurrence
plot(pres, cex=2)

#Selecting absences: same procedure
abs <- rana[rana$Occurrence ==0,]
abs$Occurrence
plot(abs, cex=2)

#to plot them together
par(mfrow=c(1,2))
plot(abs, cex=1)
plot(pres, cex=1)
#to change their colors
cl.pres <- colorRampPalette(c("yellow", "coral", "beige"))(3)
cl.pres
cl.abs <- colorRampPalette(c("blue", "aquamarine","navy", "lightgreen"))(4)

#If we want to plot presences and absences on the same map, we use the function "points" to see the absences on the presences map
plot(pres, cex=1, col="darkgreen")
points(abs, cex=1, col="lightgreen")

#The gaps (empty areas) are where the frog is not present
#there are some variables to explain and understand why in these specific areas the frog is not present
#these variables are called PREDICTATORS (environmental variables)

#with system.file function we go outside of R and we select a file called "elevation.asc" which is present inside the folder
#"asc" is a type of file like jpeg, png; inside the sdm package and we imported it in R
elev <- system.file("external/elevation.asc", package="sdm")
#we call the new object elev. now we won't use "vect" as before but "rast" because we're not dealing with points anymore, but with images and pixels
elev <- rast(elev) #coming from terra package
elev
plot(elev)

#now we want to put on top of elevation the points of presences. we use the POINTS function again
points(pres, cex=0.5) 
#we obtain a full map which where the frog is present and at which altitude
#now we can understand, making our assumptions, #why the rana temporaria tends to distributes more in an area rather than another

#lets do the same with the temperature predictor
temp <- system.file("external/temperature.asc", package="sdm")
tempmap <-rast(temp)
plot(tempmap)
points(pres, cex=0.5)

#lets do the same with cover of vegetation
veg <-system.file("external/vegetation.asc", package= "sdm")
vegmap <-rast(veg)
plot(vegmap)
points(pres, cex=0.5)

#to change colors of the map
plot(vegmap, col=cl.veg)
cl.veg <-colorRampPalette(c("lightgreen", "beige", "coral", "darkgreen", "yellow"))(100)

#lets do the same with precipitation
prec <- system.file("external/precipitation.asc", package="sdm")
precmap <- rast(prec)
plot(precmap)
points(pres, cex=0.5)

#PLOT EVERYTHING ALL TOGETHER
par(mfrow=c(2,2))
plot(elev)
points(pres, cex=0.5)
plot(vegmap)
points(pres, cex=0.5)
plot(precmap)
points(pres, cex=0.5)
plot(tempmap)
points(pres, cex=.5)

#-----------

#03.1 Communities multivariate

#we will use vegan package for our multivariate analisys for community ecology. Vegan means vegetation-analysis, but it can be used for animals as well
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

#-----------






