require(ggplot2)
require(plyr)

# load NEI & SCC datasource
NEI <- readRDS("summarySCC_PM25.rds")

# filter for vehicle
vehicles <- subset(NEI, fips == "24510" & type == "ON-ROAD")

# transform the dataset
pm0 <- ddply(vehicles, .(year), summarize, Emissions=sum(Emissions))
pm0 <- transform(pm0, year=factor(year))

# preparing graph
gp <- ggplot(pm0, aes(year, log(Emissions))) + 
    geom_point() + 
    geom_line(group=1) +
    labs(title="Baltimore City - Emissions From Motor Vechicle", x="year", y="log(PM2.5)")

png("plot5.png",width=480,height=480,units="px")
    print(gp)
dev.off()