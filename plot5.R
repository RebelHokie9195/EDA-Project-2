## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset the Baltimore emissions data.
BaltEmissions<-NEI[which(NEI$fips=="24510"),]

# The following levels of the EI.Sector column are related to motor vehicle emissions.
# "Mobile - On-Road Diesel Heavy Duty Vehicles"       
# "Mobile - On-Road Diesel Light Duty Vehicles"       
# "Mobile - On-Road Gasoline Heavy Duty Vehicles"     
# "Mobile - On-Road Gasoline Light Duty Vehicles" 

# Find the row indices of rows related to motor vehicle SCC codes.
VehicleSourcesIndices<-grep("Vehicle",SCC$EI.Sector)

# Subset the rows related to motor vehicle SCC codes.
VehicleSourceRows<-SCC[VehicleSourcesIndices,]

# Obtain the SCC codes related to motor vehicle sources.
VehicleSCCCodes<-VehicleSourceRows$SCC

# Convert the relevant SCC codes to character format.
VehicleSCCCodes<-as.character(VehicleSCCCodes)

# Subset the emissions data related to vehicles.
VehicleData<-BaltEmissions[BaltEmissions$SCC %in% VehicleSCCCodes,]

# Calculate the total vehicle emissions data by year.
totalVehicleEmissionsBalt<-aggregate(VehicleData$Emissions,by=list(Category=VehicleData$year),FUN=sum)

#Plot the total PM2.5 vehicle emissions by year.
png("plot5.png",width=480,height=480)
plot(totalVehicleEmissionsBalt,type="p",pch=19,col="blue",xlab="Year",ylab="Total PM2.5 Emmissions",main="Total PM2.5 Emmissions from Motor Vehicles in Baltimore")
dev.off()