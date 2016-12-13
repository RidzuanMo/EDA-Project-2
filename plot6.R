require(ggplot2)
require(plyr)

# load NEI & SCC datasource
NEI <- readRDS("summarySCC_PM25.rds")

# filter for vehicle for Baltimore and Los Angeles
vehicles <- subset(NEI, fips %in% c("24510", "06037") & type == "ON-ROAD")

# transform the dataset
pm0 <- ddply(vehicles, .(year, fips), summarize, Emissions=sum(Emissions))
pm0 <- transform(pm0, fips=factor(fips))

# reassign level(fips) with names..
levels(pm0$fips) <- c("Los Angeles", "Baltimore")

# preparing graph
gp <- ggplot(pm0, aes(year, log(Emissions))) + 
    geom_point() + 
    facet_grid(. ~ fips) +
    geom_smooth(method="lm") +
    labs(title="Comparison Emissions From Motor Vehicle", x="year", y="log(PM2.5)")

png("plot6.png",width=480,height=480,units="px")
    print(gp)
dev.off()
