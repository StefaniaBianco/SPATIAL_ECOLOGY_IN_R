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


library(imageRy)
library(terra)

im.list()
m1992<-im.import("matogrosso_l5_1992219_lrg.jpg")
#bands 1=NIR, 2=RED, 3=GREEN
im.plotRGB(m1992,r=2,g=1,b=3)
im.plotRGB(m1992,r=2,g=3,b=1) #now bare soil and the river is yellow

m2006<-im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006,r=2,g=3,b=1)

#let's build a multiframe with 1992 and 2006
par(mfrow=c(1,2))
im.plotRGB(m1992,r=2,g=3,b=1)
im.plotRGB(m2006,r=2,g=3,b=1)

#let's create vegetation index to see the health state
dev.off()
plot(m1992[[1]]) #let's plot the NIR band
#the range goes from 0 to 255. this is the reflectance
#reflectance=reflected flux of energy/incidence flux of energy
#we don't use this formula as it is a decimal number
#we use bit to reschedule. one bit of info is 0 or 1 (binary code)
#with one bit you can have 2 info, with 2 bits 4 info and so on
#normally there are info stored in 8 bit (2^8=256 information)
#we want to make the difference between the first band of 1992 and the second band of 1992, so we will get the DVI=NIR-RED
#let's make DVI of 1992
dvi1992 = m1992[[1]]-m1992[[2]]
#in this way we can plot 
plot(dvi1992)
#we have for each pixel the difference between the two bands
#we can see the amount of healthy vegetation. everything in green in healthy forest, that reflect the NIR and absorde the RED(explain better this concept!!!)
cl<-colorRampPalette(c("darkblue","yellow","red", "black"))(100)
plot(dvi1992, col=cl)

#let's do the same for 2006
plot(m2006)
dvi2006 = m2006[[1]]-m2006[[2]]
plot(dvi2006, col=cl)
#we see how healty vegetation is a very small amount, as deforestation is destroying the vegetation. 
