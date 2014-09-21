#Set working directory to Data folder where the data exists
setwd("~/data")

#Read the NEI and SCC files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Aggregate the data by Year
emissionsbyyear <- aggregate(NEI$Emissions,by=list(NEI$year),FUN=sum)

#Modify Label names
names(emissionsbyyear) <- c("year","emissions")

#Initiate PNG file
png(filename = "plot1.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")

#Plot the data
plot(emissionsbyyear$year,emissionsbyyear$emissions/1000,type="l",ylab="Amount of PM2.5 (K)",xlab="year")

#Close the graphic device
dev.off();