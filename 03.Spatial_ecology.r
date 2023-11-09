library(spatstat)

bei #dataset of tropical trees we are using
plot(bei) #i get the plot
plot(bei, cex=0.5) #to decrease the size of the symbol
plot(bei, cex=0.2)

#we want to get a density map. we can use some functions
#let's pass from the point of bei to density
#passing from points to a continuos surface. this is called interpolation.
#the name of the function is density, in the spatstat package
densitymap<-density(bei)
densitymap
#we switch from points to square
plot(densitymap) #we get the density maps
#we can change the colours
#adding to the previous plot another plot->point function
points(bei, cex=.2)

#we should avoid blue, green and red for daltonics people in our maps
#we can use the function colorRampPalette. we add the colours into an array and the gradient we want
cl<-colorRampPalette(c("black", "red", "orange","yellow"))(100)
plot(densitymap, col=cl)
#yellow is the first color we see in a map
#to see color names in R: https://r-charts.com/colors/ 

cl1<-colorRampPalette(c("beige", "darkgray","blueviolet", "darkorchid"))(100)
plot(densitymap, col=cl1)

#additional info
plot(bei.extra) #elevation and gradient
plot(bei.extra[[1]]) #only elevation, we use double quadratic parenthesis bc we are using an imagine, so two dimensions
elev<-bei.extra[[1]]
bei.extra$elev
plot(elev)

#how to plot multiple things together->multiframe
#multiframe function
par(mfrow=c(1,2))
plot(densitymap)
plot(elev)
#we can state how many columns and row we want). 
#we see the density and the elevation.

par(mfrow=c(1,3))
plot(bei)
plot(densitymap)
plot(elev)
#we understand the highest elevation corrisponds to less tree and lowest density
par(mfrow=c(2,1))


