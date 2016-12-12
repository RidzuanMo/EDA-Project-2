# load NEI datasource
NEI <- readRDS("summarySCC_PM25.rds")

# filter - Baltimore City
baltimore <- subset(NEI, fips == "24510")

# baltimore vector with total PM2.5 by year
baltimore_e2y <- with(baltimore, tapply(Emissions, year, sum, na.rm=TRUE))

png("plot2.png",width=480,height=480,units="px")
    barplot(baltimore_e2y, main="Baltimore City Total Emission of PM2.5", xlab="Year", ylab="PM2.5")
dev.off()
