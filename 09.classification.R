#HOW TO CLASSIFY SATELLITES IMAGES?
#HOW TO ESTIMATE THE AMOUNT OF CHANGES IN DIFFERENT CLASSES?

#pixels have coordinates of reflectance

#We need imageRy and terra as packages
library(terra)
library(imageRy)

im.list() #to see the list of all the files
#let's take a file related to the sun: "Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg"
#we can classify the amount of energy for example of sun gases. 
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") #let's import the picture we are interested in
#we should explain to the software what are the numbers of classes. here for example we expect three classes
sun.class <- im.classify(sun, num_clusters = 3)
sun.class
plot(sun.class) #we get the pixels classified for the amount of energy.
#how can i state which class has the highest energy?
plot(sun)
#the part with higher energy is on the right. so plot again sun.class
plot(sun.class)
#the class on the right is number two in this case. 


#let's apply this to mato grosso.
