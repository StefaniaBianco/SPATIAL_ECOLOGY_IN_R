#We are going to deal with relation along species in time. 
#we should use kernell density, that represents the density of the animal in time
library(overlap)

data(kerinci) ##data set of Kerinci National park in Sumatra, Indonesia
head(kerinci) #to see the first 6 rows of the dataset
summary(kerinci) #to see a summary about the variables time, species and zone

#to select information only about the tiger, we can extract them using the [] and $ and create a new dataset
tiger <- kerinci[kerinci$Sps=="tiger",]

#to change the way the time is expressed (we want it in radiant), we can do in this way:
timeRad <- kerinci$Time * 2 * pi
#we can add an additional coloumn in the data set in which we make the above calculation
kerinci$Timerad <- kerinci$Time * 2 * pi

#to extract only the temporal values of the tiger
timetig <- tiger$timeRad
#we can plot this values with densityPlot function
densityPlot(timetig, rug=TRUE)
#to see the peaks of the tiger during the day

# exercise: select only the data on macaque individuals
macaque <- kerinci[kerinci$Sps=="macaque",]
head(macaque)
timemac <- macaque$timeRad #to extract data about time of macaque
densityPlot(timemac, rug=TRUE) #to see the time distribution of the macaque during the day

#to compare the two plots
par(mfrow=c(1,2))
densityPlot(tigertime, rug=TRUE)
densityPlot(macaquetime, rug=TRUE)

#by plotting them overlapped we can see when they will be at the same time in the same place
#we will use the function "overlapPlot"
overlapPlot(timetig, timemac)
