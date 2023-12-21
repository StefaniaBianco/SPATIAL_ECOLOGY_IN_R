#Packages we are using 
library(imageRy)
library(terra)
library(viridis)

im.list() #to see the data we have

sent <- im.import ("sentinel.png")


#how to choose the layer to which apply the sd calculation?
#here we chose NIR, but we need a method
#this method is the multivariate analysis

dev.off()

pairs(sent)
#red and green are very correlated to each other (0.98 as pearson coefficient)
#nir is less correlated to the other bands, so it is adding some information

#let's perform pca on sent
sentpc<-im.pca(sent)
sentpc
#sd is 77 in the first principal component
#the first component is pc1. we can separate it
pc1<-sentpc$PC1

#let's change the colours
viridisc<-colorRampPalette(viridis(7))(255)
plot(pc1,col=viridisc)

#calculating sd on top of pc1
pc1.sd3<-focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1.sd3, col=viridisc)

pc1.sd7<-focal(pc1, matrix(1/49, 7, 7), fun=sd)
plot(pc1.sd7, col=viridisc)

#plot all together
par(mfrow=c(2,3))
im.plotRGB(sent, 2,1,3)
#sd from the variability script
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)
plot(pc1, col=viridisc)
plot(pc1.sd3, col=viridisc)
plot(pc1.sd7, col=viridisc)

#we have chosen in a objective manner to choose the band on which to make the calculation

#another way to plot everything all together is to stack them

sdstack<-c(sd3, sd7, pc1.sd3,pc1.sd7)
plot(sdstack, col=viridisc)
names(sdstack)<-c("sd3","sd7","pc1.sd3", "pc1.sd7") #to give names to our maps
