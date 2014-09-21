# Set working directory to Data folder where the data exists

setwd("~/data")

# Read the NEI and SCC files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset the data related to coal combustion
coalcombscc <-subset(SCC, grepl("comb", SCC.Level.One, ignore.case=TRUE)==T & grepl("coal", SCC.Level.Four, ignore.case=TRUE) ==T)$SCC
coalcombdata <- NEI[NEI$SCC %in% coalComb,]

# Aggregate the data
emissionsbyyear <- aggregate(coalcombdata$Emissions,by=list(coalcombdata$year),FUN=sum)

#Modify Label names
names(emissionsbyyear) <- c("year","emissions")

# Inititate PNG Device
png(filename = "plot4.png",  
    width = 800, height = 600, 
    units = "px", bg = "transparent")

#Plot the data
qplot(emissionsbyyear$year,emissionsbyyear$emissions, data = emissionsbyyear, xlab="Year",ylab="emissions") + geom_smooth(method = "loess")

#Close the graphic device
dev.off();