# load NEI datasource
NEI <- readRDS("summarySCC_PM25.rds")

# create vector with total PM2.5 by year
e2y <- with(NEI, tapply(Emissions, year, sum, na.rm=TRUE))

png("plot1.png",width=480,height=480,units="px")
    barplot(e2y, main="Total Emission of PM2.5", xlab="Year", ylab="PM2.5")
dev.off()
