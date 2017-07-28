## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# Subset the Baltimore emissions data
BaltEmissions<-NEI[which(NEI$fips=="24510"),]

# Total the emissions data by year.
BaltEmissionsTotal<-aggregate(Emissions ~ year + type, BaltEmissions, sum)

#Plot the total PM2.5 emissions by year by type
png("plot3.png",width=480,height=480)
ggplot(BaltEmissionsTotal, aes(x=year, y=Emissions, col=type))+geom_line()+labs(title="Baltimore City Emissions by Type of Source")+labs(x="Year")+labs(y="Total PM 2.5 Emissions")
dev.off()