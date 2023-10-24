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
