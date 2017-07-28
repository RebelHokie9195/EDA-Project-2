## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Select the emissions for the city of Baltimore (fips=24510)
BaltEmissions<-NEI[which(NEI$fips=="24510"),]

#Aggregate the Baltimore emissions by year
totalBaltEmission<-aggregate(BaltEmissions$Emissions,by=list(Category=BaltEmissions$year),FUN=sum)

#Plot the total PM2.5 emissions by year
png("plot2.png",width=480,height=480)
plot(totalBaltEmission,type="p",pch=19,col="blue",xlab="Year",ylab="Total PM2.5 Emmissions",main="Total PM2.5 Emmissions in the City of Baltimore")
dev.off()