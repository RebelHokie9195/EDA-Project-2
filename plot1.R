## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Total the emissions by year.
totalEmissions<-aggregate(NEI$Emissions, by=list(Category=NEI$year), FUN=sum)

#Plot the total PM2.5 coal combustion emissions by year.
png("plot1.png",width=480,height=480)
plot(totalEmissions,type="p",pch=19,col="blue",xlab="Year",ylab="Total PM2.5 Emmissions",main="Total PM2.5 Emmissions in the U.S.")
dev.off()