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

#HOW TO USE THIS FILE?
#this is a VECTOR file with coordinates. in terra package there's a function that deals with vectors (vec)
rana <- vect(file)

#to link two elements in R we use the $ symbol
rana$Occurrence

#these codes are called PRESENCES AND ABSENCES DATA (on the console is shown 0, 1, 0,...)
#0 is an uncertain data, because it could be a error 
#of your evaluation/monitoration
#HOW DO WE SEE THE DATA? again with plot function
plot(rana)
plot (rana, cex= 0.5)

#HOW TO SELECT PRESENCES?
#we use the "Occurence" to set coloumns
rana[rana$Occurrence == 1,]
#in this manner we selected all the points in the plot
#which are equal to 1, selecting the presences
pres <- rana[rana$Occurrence ==1,]
pres$Occurrence
plot(pres, cex=2)

#HOW TO SELECT ABSENCES?
abs <- rana[rana$Occurrence ==0,]
abs$Occurrence
plot(abs, cex=2)

#lets plot them together
> par(mfrow=c(1,2))
> plot(abs, cex=1)
> plot(pres, cex=1)
#lets change their colors
cl.pres <- colorRampPalette(c("yellow", "coral", "beige"))(3)
cl.pres
cl.abs <- colorRampPalette(c("blue", "aquamarine","navy", "lightgreen"))(4)

par(mfrow=c(1,2))
plot(pres, cex=1, col= cl.pres)
points(abs, cex=1, col=cl.abs)

#HOW DO WE PLOT THE ABS AND PRES TOGETHER?
#We use the function "points" on the second function to add them 
#on the previous function
par(mfrow=c(1,2))
plot(pres, cex=1, col="darkgreen")
points(abs, cex=1, col="lightgreen")

#HOW DO WE UNDERSTAND WHY IN SOME AREAS THERE ARE GAPS (the absences)?
#These gaps (empty areas) are where the frog is not present
#there are some variables to explain and understand why in these specific
#areas the frog is not present
#these variables are called PREDICTATORS (environmental variables)

#with system.file function we go outside of R and we select a file called 
#"elevation.asc" which is present inside the folder
#"asc" is a type of file like jpeg, png; inside the sdm package
#and we imported it in R

elev <- system.file("external/elevation.asc", package="sdm")
#we call the new object elev but we won't use "vect" as before
#but "rast" because we're not dealing with points anymore, but with images
#ans so with pixels
#so HOW DO WE DO WHEN WE HAVE TO IMPORT AN IMGE AS A FILE FROM OUTSIDE R?
#We use first the "system.file" function and then the "rast" function
elev <- rast(elev)
elev

plot(elev)
#now we want to put on top of elevation the points of presences
#we use the POINTS function again
points(pres, cex=0.5) 
#now we obtain a full map which where the frog is present and at which altitude
#now we can understand, making our assumptions,
#why the rana temporaria tends to distributes more in an area rather 
#than another

#lets do the same with the TEMPERATOR PREDICTOR

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
