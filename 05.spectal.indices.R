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

#let's use the vegetation index to see the health state
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


cl<-colorRampPalette(c("darkblue","yellow","red", "black"))(100)
plot(dvi1992, col=cl)

#let's do the same for 2006
plot(m2006)
dvi2006 = m2006[[1]]-m2006[[2]]
plot(dvi2006, col=cl)
#we see how healty vegetation is a very small amount, as deforestation is destroying the vegetation. 

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
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

#to be inclusive for daltonic
clvir <- colorRampPalette(c("violet", "dark blue", "blue", "green", "yellow"))(100) # specifying a color scheme
plot(ndvi2006, col=clvir)
plot(ndvi1992, col=clvir)

#speeding up the calculation, we can use the function from imageRy package
ndvi2006a<-im.ndvi(m2006, 1, 2)
plot(ndvi2006, col=cl)




