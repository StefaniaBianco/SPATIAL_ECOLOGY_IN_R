#measuring of RS based variability 
#important in abiotic and biotic component

#libraries we need
library(imageRy)
library(terra)
library(viridis)

im.list() #to see all the files there are 

sent <- im.import("sentinel.png") #we imported our data
#in this case, band1=NIR, band2=red, band3=green
im.plotRGB(sent,r=1,g=2,b=3) #vegetation is red
im.plotRGB(sent,r=2,g=1,b=3) #vegetation is green

#we want to understand the variability using the standard deviation

nir<-sent[[1]]
plot(nir) #green part are vegetation, bare soil is orange. we have 256 values so we are working with bits

#to calculate variability, we use the moving window methods
#we calculate the standard deviation for a the central pixel of a few pixel with one moving window
#and then we move to calculate the others sd. at the end the moving window will pass from one pixel to the others
sd3<-focal(nir, matrix(1/9,3,3), fun=sd) #function that makes the calculation of the sd with moving window
#matrix describes the dimension of the moving windows. it is composed of 9 pixels, from 1 to 9, 3 by 3 pixels
#function tells what function we want to use, that in this case is sd.
plot(sd3)
#let's change the legend by using the package called virisid 
#we are using the 7 colours of the viridis legend
viridisc<-colorRampPalette(viridis(7))(255)
plot(sd3, col=viridisc)
#by watching where the sd is higher, we can see where the variability is higher
#in this case is north-west as there are some glaciers and geomorphological uncertaintanties


#let's calculate the variability in 7x7 moving windows
sd7<-focal(nir, matrix(1/49,7,7), fun=sd)
plot(sd7, col=viridisc)

#let's plot via par(mfrow()) the 3x3 and the 7x7 sd
par(mfrow=c(1,2))
plot(sd3, col=viridisc)
plot(sd7, col=viridisc) #the effect of higher variability is due to the additional pixels we are including

#original image+sd plot all together
par(mfrow=c(1,2))
im.plotRGB(sent,r=2,g=1,b=3)
plot(sd7, col=viridisc)
#we can compare directly the two images. 
#high sd can mean or geological variability or species variability

#how to choose the layer to which apply the sd calculation?
#here we chose NIR, but we need a method
#this method is the multivariate analysis
