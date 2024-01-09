#FINAL SCRIPT INCLUDING ALL THE DIFFERENT SCRIPTS DURING THE LECTURE

#Summary:
#01 Beginning
#02.1 Population density
#02.2 Population distribution
#03.1 Communities multivariate analysis
#03.2 Communities overlap
#04 Remote sensing data visualisation
#05 Spectal indices
#06 Time series analysis
#07 External data import
#08 Copernicus data
#09 Classification
#10 Variability
#11 PCA

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

#03.1 Communities multivariate analysis

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

#03.2 Communities overlap

#We are going to deal with relation along species in time. 
#we should use kernell density, that represents the density of the animal in time
library(overlap)

data(kerinci) ##data set of Kerinci National park in Sumatra, Indonesia
head(kerinci) #to see the first 6 rows of the dataset
summary(kerinci) #to see a summary about the variables time, species and zone

#to select information only about the tiger, we can extract them using the [] and $ and create a new dataset
tiger <- kerinci[kerinci$Sps=="tiger",]

#to change the way the time is expressed (we want it in radiant), we can do in this way:
timeRad <- kerinci$Time * 2 * pi
#we can add an additional coloumn in the data set in which we make the above calculation
kerinci$Timerad <- kerinci$Time * 2 * pi

#to extract only the temporal values of the tiger
timetig <- tiger$timeRad
#we can plot this values with densityPlot function
densityPlot(timetig, rug=TRUE)
#to see the peaks of the tiger during the day

# exercise: select only the data on macaque individuals
macaque <- kerinci[kerinci$Sps=="macaque",]
head(macaque)
timemac <- macaque$timeRad #to extract data about time of macaque
densityPlot(timemac, rug=TRUE) #to see the time distribution of the macaque during the day

#to compare the two plots
par(mfrow=c(1,2))
densityPlot(tigertime, rug=TRUE)
densityPlot(macaquetime, rug=TRUE)

#by plotting them overlapped we can see when they will be at the same time in the same place
#we will use the function "overlapPlot"
overlapPlot(timetig, timemac)

#-----------

#04 Remote sensing data visualisation

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

#-----------

#05 Spectal indices

#vegetation indexes

#when there is a vegetation area in a good state, the NIR reflectance value will be high, the RED reflectance will be low
#if the tree is suffering, the reflectance of the NIR will be lower and the RED will be higher

#the DVI is given by NIR-RED, so the DVI will be lower if the vegetation is in bad health condition (low value of NIR, high value of RED)

#as the DVI is only a difference, if we want to have a normalized value (between 0 and 1) we can use the NDVI (normalized difference vegetation index). 
#NDVI=NIR-RED/NIR+RED

#Let's recall our libraries
library(imageRy)
library(terra)

im.list() #to see the data inside our packages

#on github there is the description of the data about Mato grosso
#https://github.com/ducciorocchini/imageRy/blob/main/data_description.md
#https://earthobservatory.nasa.gov/images/35891/deforestation-in-mato-grosso-brazil

#let's import a picture from the forest in 1992
m1992<-im.import("matogrosso_l5_1992219_lrg.jpg")
#spatial resolution=30 meters. 
#the bands we have are 1=NIR, 2=RED, 3=GREEN
im.plotRGB(m1992, r=1, g=2, b=3)
#a shortcut for the same function
im.plotRGB(m1992, 1, 2, 3)

im.plotRGB(m1992, r=2, g=1, b=3) #in this case we have in green the vegetation, in violet we have bare soil
im.plotRGB(m1992, r=2, g=3, b=1) #another combination, we see the vegetation in blue

#let's import a more recent image
m2006<-im.import('matogrosso_ast_2006209_lrg.jpg')
im.plotRGB(m2006, r=2, g=3, b=1)
#as the yellow colour is catching our sight more than other colours, it makes sense to use it if we want to underline the bare soil

#let's build a multiframe with 1992 and 2006
par(mfrow=c(1,2))
im.plotRGB(m1992,r=2,g=3,b=1)
im.plotRGB(m2006,r=2,g=3,b=1)
dev.off()

#let's use the vegetation index to see the health state (DVI)
plot(m1992[[1]]) #in this way we plot the NIR band
#in this case, the range of the reflectance goes from 0 to 255

#reflectance=reflected flux of energy/incidence flux of energy
#we don't use this formula as it gives as a decimal number as a result
#we use bit to reschedule. one bit of info is 0 or 1 (binary code)
#with one bit you can have 2 info, with 2 bits 4 info and so on
#normally the information are stored in 8 bit (2^8=256 information)

#we want to make the difference between the first band of 1992 and the second band of 1992, so we will get the DVI=NIR-RED
#let's make DVI of 1992
dvi1992 = m1992[[1]]-m1992[[2]]
#in this way we can plot 
plot(dvi1992)
#we have for each pixel the difference between the two bands
#we can see the amount of healthy vegetation. everything in green is healthy forest
cl<-colorRampPalette(c("darkblue","yellow","red", "black"))(100)
plot(dvi1992, col=cl)

#let's do the same for 2006
plot(m2006)
dvi2006 = m2006[[1]]-m2006[[2]]
plot(dvi2006, col=cl)
#we see now healty vegetation is a very small amount, as deforestation is destroying the forest 

#what if we have images with different bits?
#we have to standardize the bit (normalized)
#NDVI=NIR-RED/NIR+RED
#Range of NDVI is always from -1 to 1
#it's very used worldwide
#DVI is ranging depending on the bits we have (-256, +256 if we have 8 bits)

#let's calculate the NDVI
ndvi1992 = dvi1992 / (m1992[[1]]+m1992[[2]])
plot(ndvi1992, col=cl)
#the dark red part is the healthy vegetation
ndvi2006 = dvi2006 / (m2006[[1]]+m2006[[2]])
plot(ndvi2006, col=cl) 
dev.off()

#let's create a multiframe to compare the two images
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)
#we see the situation in 2006 is way worse

#to be inclusive for daltonic
clvir <- colorRampPalette(c("violet", "dark blue", "blue", "green", "yellow"))(100) # specifying a color scheme
plot(ndvi2006, col=clvir)
plot(ndvi1992, col=clvir)

#if we want to speed up the calculation, we can use the function from imageRy package
ndvi2006a<-im.ndvi(m2006, 1, 2)
plot(ndvi2006, col=cl)

#-----------

#06 Time series analysis

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

#-----------

#07 external data import

#how to import external data
library(terra) #we recall our data 

#the working directory tells R which folder are we working on. 
#we use the function setwd and we copy and paste the path of the folder in which there are the data we want to import 
setwd("C://Users/Utente/Desktop/SPATIAL ECOLOGY IN R") #this is my folder
naja<-rast("najafiraq_etm_2003140_lrg.jpg") #rast is a function to import file
plotRGB(naja, r=1, g=2, b=3) #to see the picture

#let's do the same from another image
najaaug<-rast("najafiraq_oli_2023219_lrg.jpg")
plotRGB(najaaug, r=1, g=2, b=3)

#we can visualise the multitemporal changes making the difference between the first band of our two pictures
najadif = naja[[1]] - najaaug[[1]] 
cl <- colorRampPalette(c("brown", "grey", "orange")) (100) #to change our colours
plot(najadif, col=cl)


#Exercise: download your own preferred image
lake1<-rast("1.lakepowell_oli2_2022267_lrg.jpg") 
plotRGB(lake1, r=1, g=2, b=3) #the lake in 2022
lake2<-rast("2.lakepowell_oli_2023293_lrg.jpg")
plotRGB(lake2, r=1, g=2, b=3) #the lake in 2023

#-----------

#08 Copernicus data

#Copernicus is a european earth observatory
#link to copernicus library: https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home

install.packages("ncdf4")
library(ncdf4)
library (terra)
#we need these two libraries to import data

#we need to tell R where our data are stored. 
#we should set the working directory with the function setwd("...")
setwd("C:/Users/Utente/Downloads/") #here is where i have my data stored
soilmoisture<-rast("c_gls_SSM1km_201411230000_CEURO_S1CSAR_V1.1.1.nc")
plot(soilmoisture)
#ssm_noise is the error in the measurement

#let's plot only the first element of the data we have
plot(soilmoisture[[1]])
#let's change the colours
cl<-colorRampPalette(c("red", "orange", "yellow")) (100)
plot(soilmoisture[[1]], col=cl)

#let's crop the image we imported
#we first need to define the extent
ext<-c(22, 26, 55, 57) #we have to insert: minimum longitude, maximum longitude, minimum latitude, maximum latitude)
soilmoisture.crop<-crop(soilmoisture, ext) #we use the function crop, that takes the images and then crops it with the extent we previously set
plot(soilmoisture.crop)
plot(soilmoisture.crop[[1]], col=cl) #to plot only the first element


#i can do the same process for another image. in this way we can compare the same image in two different period. 
soilm2023_24 <- rast("c_gls_SSM1km_202311240000_CEURO_S1CSAR_V1.2.1.nc")
plot(soilm2023_24)
soilm2023_24c <- crop(soilm2023_24, ext)
plot(soilm2023_24c[[1]], col=cl)

#-----------

#09 Classification

#HOW TO CLASSIFY SATELLITES IMAGES?
#HOW TO ESTIMATE THE AMOUNT OF CHANGES IN DIFFERENT CLASSES?

#We need imageRy and terra as packages
library(terra)
library(imageRy)

im.list() #to see the list of all the files
#let's take a file related to the sun: "Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg"

#we can classify the amount of energy of sun gases. 
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") #let's import the picture we are interested in
#we should explain to the software which are the numbers of classes. here for example we expect three classes
sun.class <- im.classify(sun, num_clusters = 3)
sun.class
plot(sun.class) #we get the pixels classified for the amount of energy.
#how can i state which class has the highest energy?
plot(sun)
#the part with highest energy is on the right. so let's plot again sun.class
plot(sun.class)
#the class on the right is number two in this case. 

#let's apply this classification method to mato grosso.
m1992<-im.import("matogrosso_l5_1992219_lrg.jpg")
m2006<-im.import("matogrosso_ast_2006209_lrg.jpg")

#we can classify this images, we use only two clusters as bare soil and water in this case are difficult to discriminate
plotRGB(m1992)
m1992.class<-im.classify(m1992, num_clusters = 2)
plot(m1992.class)
#in this case, 1=forest, 2=human

#we do the same with picture from 2006
plotRGB(m2006)
m2006.class<-im.classify(m2006, num_clusters = 2)
plot(m2006.class)
#here we a lot of human intervention, as the colour 2 increased a lot. 
dev.off()

#let's plot everything to compare them
par(mfrow=c(1,2))
plot(m1992.class[[1]])
plot(m2006.class[[1]])
#in 2006 there are a lot more pixels related to human interventions

#let's check the numeric frequence of the classes
f1992<-freq(m1992.class)
f1992 #class number one is way more present than class number two

#let's calculate the percentage
tot1992 <- ncell(m1992.class) #it calculates the number of pixel in an image
tot1992
#we divide the frequency by the total number of pixels and then we mupliply by 100
percentage1992<-f1992*100/tot1992
percentage1992
#the values we are interested in, are the ones inside count (83% forest, 17% human areas)

#let's do the same for 2006
f2006<-freq(m2006.class)
f2006
tot2006 <- ncell(m2006.class) #it calculates the number of pixel in an image
tot2006
#we divide the frequency by the total number of pixels and then we mupliply by 100
percentage2006<-f2006*100/tot2006
percentage2006
#percentages are 55% for forest, 45% for human areas
#the situation worsened a lot

#let's create a table with the function data.frame
class<- c("forest", "human")
y1992<-c(83, 17)
y2006<-c(55,45)
tab<-data.frame(class, y1992, y2006)
tab

library(ggplot2) 
#let's plot the percentage of 1992 
t1<-ggplot(tab, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") #aes=aesthetics characteristics
t1
#let's get a table with the bars of the percentage of the year 2006
t2<-ggplot(tab, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
t2

#to plot them together, we can use the patchwork package. 
install.packages("patchwork")
library(patchwork)
t1+t2 #we see the two plotted together 

#let's rescale the two graphs
#we give the same scale to actually make them comparable
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100)) 
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2

#-----------

#10 Variability

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

#-----------

#11 PCA

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
