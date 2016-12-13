require(ggplot2)
require(plyr)

# load NEI & SCC datasource
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# filtering for coal combustian-related sources
fitlerSccCoal <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
SCC_COAL <- SCC[fitlerSccCoal, c("SCC", "Short.Name")]

# merge filtered SCC with NEI
NEI_COAL <- merge(NEI, SCC_COAL, by="SCC")

# transform the dataset
pm0 <- ddply(NEI_COAL, .(year), summarize, Emissions=sum(Emissions))
pm0 <- transform(pm0, year=factor(year))

# preparing graph
gp <- ggplot(pm0, aes(year, log(Emissions))) + 
    geom_point() + 
    geom_line(group=1) +
    labs(title="Emissions From Coal Combustion-Related", x="year", y="log(PM2.5)")

png("plot4.png",width=480,height=480,units="px")
    print(gp)
dev.off()
