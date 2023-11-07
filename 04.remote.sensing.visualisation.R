#remote sensing for ecosystem monitoring

install.packages("devtools") 
library(devtools)

devtools::install_github("ducciorocchini/imageRy")
library(imageRy)

library(terra)

im.list() #we have all the different images we can use
#we will use the sentinel data. we are using images of the same 
#resolution (10metres). we will use 4 different bands

im.import("sentinel.dolomites.b2.tif")


####RECOVER LECTURE 26-10


#LECTURE 02 11

#this is a script to visualize data

library (terra) #new package from Nowosad Jakub
library(imageRy)
#we have recalled this two packages

#list the data 
#all the functions from imageRy start with im.
im.list()
#we have the list of all the files
#we will use sentinel, satellite from ESA. There is a youtube video on
#the channel of the professor, check virtuale

#every sensor gatheres information with different wavelenghts
#every colour is a spectral band. 
#band 8 is near infra red (NIR), 10 metres of spatial resolution

#let's import data
b2<-im.import("sentinel.dolomites.b2.tif")
#wgs=world geographyc system, 3D elipsoid and they translated in UTM, universal 
#transverse mercator, we divided the hearth in 60 zones
#italy is zone 32, 33 and 34
#x and y are distances from meridiano and equatore

cl<-colorRampPalette(c("black","grey","light grey")) (100)
plot(b2, col=cl)

#import the green band from sentinel-2
b3<-im.import("sentinel.dolomites.b3.tif")
cl<-colorRampPalette(c("black","grey","light grey")) (100)
plot(b3, col=cl)
#higher the reflectance (on the right scale, lighter the colour)

#import the red band from sentinel-2, band number 4
b4<-im.import("sentinel.dolomites.b4.tif")
cl<-colorRampPalette(c("black","grey","light grey")) (100)
plot(b4, col=cl)

#import the NIR band from sentinel-2, band number 8
b8<-im.import("sentinel.dolomites.b8.tif")
cl<-colorRampPalette(c("black","grey","light grey")) (100)
plot(b8, col=cl)

#we are going to build a multiframe
par(mfrow=c(2,2))
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

#we can stack all the bands together and then plot them together. 
#we should see the bands are part of an array
stacksent<-c(b2, b3, b4, b8) #several layers in the same place
stacksent #we can see the info for all the files, nlyr=4
dev.off() #it closes devices
plot(stacksent, col=cl)

#if we want to plot only the NIR band
plot(stacksent[[4]], col=cl) #remember the double quadratic parenthesis


#see presentation about reflectance
#we prefere to store data about reflectance with integers instead of float numbers

#exercise: plot in a multiframe the bands with different colour ramps

#exercise: plot in a multiframe the bands with different colour ramps

dev.off()

par(mfrow=c(2,2))
clb<-colorRampPalette(c("darkblue","blue","lightblue"))(100)
plot(b2, col=clb)

#do this for every colour and band



#RGB colours=red, green, blue. how computers create colours. 

#RGB space
#stacksent: 
#band2 blue element 1, stacksent[[1]]
#band3 green element 2, stacksent[[2]]
#band4 red element 3, stacksent[[3]]
#band8 nir element 4 stacksent[[4]]
im.plotRGB(stacksent, r=3, g=2, b=1)
#additional info from NIR to be used to plot this images with a meaningful manner


LECTURE 07-11
library(imageRy)
library(terra)
im.list()
b2<-im.import("sentinel.dolomites.b2.tif")
b3<-im.import("sentinel.dolomites.b3.tif")
b4<-im.import("sentinel.dolomites.b4.tif")
b8<-im.import("sentinel.dolomites.b8.tif")
stacksent<-c(b2,b3,b4,b8)
plot(stacksent)

#rgbspace. there are normally three components to which we associate bands (red, green, blue)
im.plotRGB(stacksent, r=3, g=2, b=1)
#we are putting bands one on the top of the others
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
