# Set working directory to Data folder where the data exists

setwd("~/data")

# Read the NEI and SCC files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset the data related to vehicle motor in Baltimore and los angeles city
vehiclescc <-subset(SCC, grepl("vehicle", SCC.Level.Two, ignore.case=TRUE)==T)$SCC
vehicledata <- NEI[NEI$SCC %in% vehiclescc & (NEI$fips == "24510" | NEI$fips == "06037"),]

#Aggregate the data by year, fips
emissionsbyyear <- aggregate(vehicledata$Emissions,by=list(vehicledata$year,vehicledata$fips),FUN=sum)

#Modify Label names
names(emissionsbyyear) <- c("year","fips","emissions")

#Initiate PNG Device
png(filename = "plot6.png", 
    width = 800, height = 600, 
    units = "px", bg = "transparent")

#Plot the data
g <- ggplot(data=emissionsbyyear, aes(emissionsbyyear$year, emissionsbyyear$emissions) ) 
g <- g + geom_line(aes(color=emissionsbyyear$fips)) 
g <- g + scale_color_manual(name = "City", values = c("red", "blue"), labels = c("Los Angeles","Baltimore")) 
g <- g + labs(x="Year", y ="Emissions", title="Emissions By City")

g

#Close graphic device
dev.off();