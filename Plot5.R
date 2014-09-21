# Set working directory to Data folder where the data exists

setwd("~/data")

# Read the NEI and SCC files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset the data related to vehicle 
vehiclescc <-subset(SCC, grepl("vehicle", SCC.Level.Two, ignore.case=TRUE)==T)$SCC
vehicledata <- NEI[NEI$SCC %in% vehiclescc & NEI$fips == "24510",]

#Aggregate the data
emissionsbyyear <- aggregate(vehicledata$Emissions,by=list(vehicledata$year),FUN=sum)

#Modify Label names
names(emissionsbyyear) <- c("year","emissions")

#Initiate PNG Device
png(filename = "plot5.png", 
    width = 800, height = 600, 
    units = "px", bg = "transparent")

#Plot the data
qplot(emissionsbyyear$year,emissionsbyyear$emissions, data = emissionsbyyear, xlab="Year",ylab="emissions") + geom_smooth(method = "loess")

#Close the graphic device
dev.off();