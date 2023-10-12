#why population disperse over the landscape in a certain manner?

#GDAL->Geospatial Data Abstraction Library
#OSGeo->open source geospatial foundation: open source project for geography and ecology
#gdal library now is inside the terra package
#sdm->spatial distribution model

library(sdm)
library(terra)

#to find for a file in a folder we installed with the package we can use this function
file<-system.file("external/species.shp", package="sdm") 
file #we get the path. now we want to us this file. this is a vector file.
#function to deal with vectors
rana<-vect(file)
rana
#we get some information about rana
#to see the content
rana$Occurrence
#0 and 1 are coding absences and presence. this are called presence/absence there. 
#in abundance data we count how many individuals we have
plot(rana)
plot(rana, cex=.5)

#Selecting presences
pres<-rana[rana$Occurrence==1,] #sql, language to program. we use ==
pres$Occurrence #we obtain all points equal to 1
plot(pres,cex=.5) #we have in the plot only the presences

#selecting absences
abse<-rana[rana$Occurrence==0,]
abse$Occurrence
plot(abse, cex=.5)

#plot presences and absences one beside the other
par(mfrow=c(1,2)) #we use the par function and inside the multiframe row, with one row and two colums.
plot(pres,cex=.5)
plot(abse, cex=.5)
dev.off() #to close graphs

#let's plot pres and abse in two different colours but in the same plot
plot(pres,cex=.5, col="dark blue")
plot(abse, cex=.5, col="light blue")
#they are not togeter in this way
#we should use points instead of using plot
points(abse, cex=.5, col="light blue")
#now we have light blue for abse and dark for presence

#why points are distributed like this?
plot(pres,cex=.5, col="dark blue") #we have some gaps. why?
#we can use predictors (environmental variables) to understand the distribution


#elevation predictor
#first of all let's check the path
elev<-system.file("external/elevation.asc",package ="sdm" ) #asc is an extension meaning asci, a type of file
elev #it shows the path of the elevation file
elevmap<-rast(elev) #we use rast function since it is a raster, from terra package. we are dealing now with pictures. 
elevmap
plot(elevmap)
points(pres,cex=.5)
#rana avoids the valley (low altitude) and the super high altitude. 
#they prefere around 500-1000

#temperature predictor
temp<-system.file("external/temperature.asc",package ="sdm")
temp
tempmap<-rast(temp)
tempmap
plot(tempmap)
points(pres, cex=.5)
#they prefere medium to high temperatures. it is avoiding low temperatures

#vegetation cover predictor
vege<-system.file("external/vegetation.asc", package="sdm")
vege
vegemap<-rast(vege)
plot(vegemap)
points(pres, cex=.5)
#they prefere area with high vegetation cover. it helps to avoid predators

#we could see probably the same pattern with the water

#precipitation predictor
prec<-system.file("external/precipitation.asc", package="sdm")
vege
precmap<-rast(prec)
plot(precmap)
points(pres, cex=.5)
#it preferes higher precipitation, as every anphibian as they need it for the skin

#final multiframe plotting
par(mfrow=c(2,2))
plot(elevmap)
points(pres, cex=.5)
plot(vegemap)
points(pres, cex=.5)
plot(precmap)
points(pres, cex=.5)
plot(tempmap)
points(pres, cex=.5)
