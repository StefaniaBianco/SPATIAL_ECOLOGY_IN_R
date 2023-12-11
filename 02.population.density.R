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

#to see an image file (raster)
bei.extra
plot(bei.extra)

#let's use only part of the bei dataset: elev
bei.extra$elev

#simplifying

elevation <- bei.extra$elev
plot(elevation)
# selecting the first element

elevation2 <- bei.extra[[1]]
plot (elevation2)
