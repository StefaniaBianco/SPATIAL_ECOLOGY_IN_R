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

