#remote sensing for ecosystem monitoring

install.packages("devtools") 
library(devtools)

#how to install the imageRy package from GitHub
devtools::install_github("ducciorocchini/imageRy")
library(imageRy)
library(terra)

#to see all the data in the package
im.list() #we get all the different data we can use
#all the functions from imageRy start with im.

#we will first use the sentinel data (satellite from ESA). 
#we are using images of the same spacial resolution (10metres). we will use 4 different bands
b2<-im.import("sentinel.dolomites.b2.tif") #to import the image
cl <- colorRampPalette(c("black", "grey", "light grey")) (100) #to change colors
plot(b2, col=cl)

#every sensor gatheres information with different wavelenghts
#every colour is a spectral band. as an example, band 8 is near infra red (NIR) with 10 metres of spatial resolution

#to import the green band from sentinel-2 (band number 3)
b3<-im.import("sentinel.dolomites.b3.tif")
cl<-colorRampPalette(c("black","grey","light grey")) (100)
plot(b3, col=cl)
#the highest the reflectance, the lightest the colour (on the right scale)

#to import the red band from sentinel-2 (band number 4)
b4<-im.import("sentinel.dolomites.b4.tif")
cl<-colorRampPalette(c("black","grey","light grey")) (100)
plot(b4, col=cl)

#to import the NIR band from sentinel-2 (band number 8)
b8<-im.import("sentinel.dolomites.b8.tif")
cl<-colorRampPalette(c("black","grey","light grey")) (100)
plot(b8, col=cl)

#we are going to build a multiframe
par(mfrow=c(2,2))
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

#we can also stack all the bands together and then plot them together. 
#we should see the bands as part of an array
stacksent<-c(b2, b3, b4, b8) #several layers in the same place
stacksent #we can see the info for all the files, nlyr=4
dev.off() #it closes devices
plot(stacksent, col=cl)

#if we want to plot only the NIR band
plot(stacksent[[4]], col=cl) #remember the double quadratic parenthesis

dev.off()

#exercise: plot in a multiframe the bands with different colour ramp palette
par(mfrow=c(2,2))
clb<-colorRampPalette(c("darkblue","blue","lightblue"))(100)
plot(b2, col=clb)

#do this for every colour and band
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(b3, col=clg)

clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(b4, col=clr)

cln <- colorRampPalette(c("brown", "orange", "yellow")) (100)
plot(b8, col=cln)


#RGB colours=red, green, blue. The RGB space is how computers create colours. 
#stacksent is composed of: 
#band2 blue element 1, stacksent[[1]]
#band3 green element 2, stacksent[[2]]
#band4 red element 3, stacksent[[3]]
#band8 nir element 4 stacksent[[4]]
#to plot the three layers one on the top of the others, we use the im.plotRGB function
im.plotRGB(stacksent, r=3, g=2, b=1)

#if we want to change colours, we can change the numbers in the code
im.plotRGB(stacksent, r=4, g=3, b=2)
#we see peaks, streets, rivers, two kinds of vegetation
im.plotRGB(stacksent, r=3, g=4, b=2) #let's change again the order of the colour
im.plotRGB(stacksent, r=3, g=2, b=4) #everything that reflects the NIR will become blue

#if we want to see the correlation of information from one band to another:
?pairs
pairs(stacksent)
#we have the dots plotted and the pearson correlation value
#second and third band are highly correlated, they are giving more or less the same information
#the NIR is not that correlated, it is adding some more information
#in the graphs we see the reflectance of the points

#reflectance=ratio between reflected radiant flux (energy) and the incident radiant flux (energy)
