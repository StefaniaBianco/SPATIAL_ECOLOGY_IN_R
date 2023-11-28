#link to copernicus library: https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home

install.packages("ncdf4")
library(ncdf4)
library (terra)
#we need these two libraries to import data

#we need to tell R where our data are stored. 
#we should set the working directory with the function setwd("...")
setwd("C:/Users/Utente/Downloads/")
soilmoisture<-rast("c_gls_SSM1km_201411230000_CEURO_S1CSAR_V1.1.1.nc")
plot(soilmoisture)
#ssm_noise is the error in the measurement
#let's plot only the first one 
plot(soilmoisture[[1]])
#let's change the colours
cl<-colorRampPalette(c("red", "orange", "yellow")) (100)
plot(soilmoisture[[1]], col=cl)
#how to crop the images we imported
#we first need to define the extent
ext<-c(22, 26, 55, 57) #we have to insert: minimum longitude, maximum longitude, minimum latitude, maximum latitude)
soilmoisture.crop<-crop(soilmoisture, ext) #we use the function crop, we take the images and then we crop the image
plot(soilmoisture.crop)
plot(soilmoisture.crop[[1]], col=cl)


#i can do the same process for another image. in this way we can compare the same image in two different period. 

