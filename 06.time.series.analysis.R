#Time series analysys

#let's recall our libraries
library(imageRy)
library(terra)

im.list() #to check the content

#let's import some data
EN01<-im.import("EN_01.png") #general situation in january 2020 in europe of NO2
EN13<-im.import("EN_13.png") #situation in march. the red part is definitely decreased, as it was during quarantine
par(mfrow=c(2,1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

#let's do the difference between march and january
#we can make the difference using the first band of the two images
dif=EN01[[01]]-EN13[[01]]
plot(dif)
dev.off()

#let's change the colours
cldif<-colorRampPalette(c("blue","white","red"))(100)
plot(dif, col=cldif)
#all the red parts are where the values where higher in January


#another example: temperatures in Greenland

im.list() #always to see the data we have
g2000<-im.import("greenland.2000.tif") #this is a single band representing temperature (in 16 bits)
clg<-colorRampPalette(c("black","blue","white","red"))(100)
plot(g2000, col=clg)
#the lowest temperatures now are blue, the warmest are red

#let's import all the data from the following years
g2005<-im.import("greenland.2005.tif")
g2010<-im.import("greenland.2010.tif")
g2015<-im.import("greenland.2015.tif")

plot(g2015, col=clg) 
#we notice that the black is restricting year after year
par(mfrow=c(2,1))
plot(g2000, col=clg)
plot(g2015, col=clg)

#we can concatenate all the 4 images together
stackg<-c(g2000, g2005, g2010, g2015)
plot(stackg, col=clg)

dev.off()

#let's make the difference between the first and final element of the stack
dif.g=stackg[[1]]-stackg[[4]]
plot(dif.g, col=clg)

#another way to make the difference
dif.g=g2000-g2015
plot(dif.g, col=clg)
#we notice that in the middle we are loosing low temperatures. 
dev.off()

#we can take the images from the stack and put them in the R, G, B channels
#the high values in 2000 will become red, 
#the high values in 2005 will become green,
#the high values in 2010 will become blue.
im.plotRGB(stackg, r=1, g=2, b=3)
#in the central part, as it blue, the temperature is higher in 2015

#we have the possibility to monitor changes on the hearth.
#we can use satellite date to make comparison and plot
