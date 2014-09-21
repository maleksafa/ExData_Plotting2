# Set working directory to Data folder where the data exists

setwd("~/data")

# Read the NEI and SCC files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset only the data related to Baltimore City, fips = "24510"
neibaltimore <- subset(NEI,NEI$fips == "24510")

#Aggregate the data by year
emissionsbyyear <- aggregate(neibaltimore$Emissions,by=list(neibaltimore$year),FUN=sum)

#Modify Label names
names(emissionsbyyear) <- c("year","emissions")

#Open PNG device
png(filename = "plot2.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")

#Plot the data
plot(emissionsbyyear$year,emissionsbyyear$emissions/1000,type="l",ylab="Amount of PM2.5 (K)",xlab="year")

#Close graphic device
dev.off();