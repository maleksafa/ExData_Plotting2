# Set working directory to Data folder where the data exists

setwd("~/data")

# Read the NEI and SCC files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset Baltimore city data
neibaltimore <- subset(NEI,NEI$fips == "24510")

#Aggregate the data by year, type
emissionsbyyear <- aggregate(neibaltimore$Emissions,by=list(neibaltimore$year,neibaltimore$type),FUN=sum)

#Modify Label names
names(emissionsbyyear) <- c("year","type","emissions")

#Initiate PNG device
png(filename = "plot3.png", 
    width = 800, height = 600, 
    units = "px", bg = "transparent")

#Plot the data with facets on type 
qplot(emissionsbyyear$year,emissionsbyyear$emissions, data = emissionsbyyear, facets = .~type, xlab="Year",ylab="emissions") + geom_smooth(method = "loess")

#Close graphic device
dev.off();