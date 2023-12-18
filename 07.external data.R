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
