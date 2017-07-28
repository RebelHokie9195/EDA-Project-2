## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# The following levels of SCC$EI.Sector are related to Coal:
# "Fuel Comb - Comm/Institutional - Coal" 
# "Fuel Comb - Electric Generation - Coal"  
# "Fuel Comb - Industrial Boilers, ICEs - Coal" 

#Find the indices of the rows that have Coal in the EI.Sector column.
CoalCombSourcesIndices<-grep("Coal",SCC$EI.Sector)

#Subset the rows of interest.
CoalCombSourceRows<-SCC[CoalCombSourcesIndices,]

#Obtain the SCC codes related to coal consumption from the rows of interest.
CoalSCCCodes<-CoalCombSourceRows$SCC

#Put the relevant SCC codes in character format.
CoalSCCCodes<-as.character(CoalSCCCodes)

#Subset the rows of emissions data based upon the SCC codes related to coal.
CoalCombData<-NEI[NEI$SCC %in% CoalSCCCodes,]

#Calculate the coal-related emissions by year.
totalCoalEmissions<-aggregate(CoalCombData$Emissions,by=list(Category=CoalCombData$year),FUN=sum)

#Plot the total PM2.5 emissions by year.
png("plot4.png",width=480,height=480)
plot(totalCoalEmissions,type="p",pch=19,col="blue",xlab="Year",ylab="Total PM2.5 Emmissions",main="Total PM2.5 Emmissions from Coal Combustion in the U.S.")
dev.off()