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
