require(ggplot2)
require(plyr)

# load NEI datasource
#NEI <- readRDS("summarySCC_PM25.rds")
baltimore <- subset(NEI, fips == "24510", select=c("year", "type", "Emissions"))

# source type
pm0 <- ddply(baltimore, .(year, type), summarize, Emissions=sum(Emissions))
pm0 <- transform(pm0, type=factor(type))

# plot graph
gp <- ggplot(pm0, aes(year, log(Emissions))) + 
    geom_point() + 
    facet_grid(. ~ type) +
    geom_smooth() +
    labs(title="Baltimore City", x="year", y="log(PM2.5)")

png("plot3.png",width=480,height=480,units="px")
    print(gp)
dev.off()
