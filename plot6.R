library(ggplot2)

## This next line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset the emissions related to Baltimore and LA.
BaltLAEmissions<-NEI[which((NEI$fips=="24510")|(NEI$fips=="06037")),]

# The following levels of SCC$EI.Sector are related to motor vehicle emissions.
# "Mobile - On-Road Diesel Heavy Duty Vehicles"       
# "Mobile - On-Road Diesel Light Duty Vehicles"       
# "Mobile - On-Road Gasoline Heavy Duty Vehicles"     
# "Mobile - On-Road Gasoline Light Duty Vehicles" 

# Find the row indices related to vehicle emissions.
VehicleSourcesIndices<-grep("Vehicle",SCC$EI.Sector)

# Subset the rows of SCC codes related to vehicle sources.
VehicleSourceRows<-SCC[VehicleSourcesIndices,]

# Extract the SCC codes related to vehicle sources.
VehicleSCCCodes<-VehicleSourceRows$SCC

# Format the relevant SCC codes as characters.
VehicleSCCCodes<-as.character(VehicleSCCCodes)

# Extract the emissions data related to motor vehicle sources.
VehicleData<-BaltLAEmissions[BaltLAEmissions$SCC %in% VehicleSCCCodes,]

# Total the vehicle emissions data by year and city (fips code)
totalVehicleEmissionsBaltLA<-aggregate(Emissions ~ year + fips, VehicleData, sum)

#Plot the total PM2.5 emissions by year by city.
png("plot6.png",width=480,height=480)
ggplot(totalVehicleEmissionsBaltLA, aes(x=year, y=Emissions, col=fips))+geom_line(size=2)+labs(title="Total Vehicle Emmissions, L.A. (fips=06037) vs. Baltimore (fips=24510)")+labs(x="Year")+labs(y="Total PM 2.5 Emissions")
dev.off()