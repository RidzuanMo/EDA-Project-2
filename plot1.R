
NEI <- readRDS("summarySCC_PM25.rds")

e2y <- with(NEI, tapply(Emissions, year, sum, na.rm=TRUE))
barplot(e2y, main="Total Emission of PM2.5", xlab="Year", ylab="PM2.5")
