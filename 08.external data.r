#external data

#working directory tells R which folder are we working on. we use the function setwd and we copy and paste the path
setwd("C://Users/Utente/Desktop/SPATIAL ECOLOGY IN R")
naja<-rast("najafiraq_etm_2003140_lrg.jpg")
plotRGB(naja, r=1, g=2, b=3)
setwd("C://Users/Utente/Desktop/SPATIAL ECOLOGY IN R")

najaaug<-rast("najafiraq_oli_2023219_lrg.jpg")
plotRGB(najaaug, r=1, g=2, b=3)


#RECUPERAAAA

lake1<-rast("1.lakepowell_oli2_2022267_lrg.jpg")
plotRGB(lake1, r=1, g=2, b=3)
lake2<-rast("2.lakepowell_oli_2023293_lrg.jpg")
plotRGB(lake2, r=1, g=2, b=3)
