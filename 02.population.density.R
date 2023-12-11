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
