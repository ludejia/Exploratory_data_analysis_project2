#Create the data set
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset SCC for coal combustion-related sources from the dataset
SCC2=subset(SCC, grepl('Comb.*Coal|Coal.*Comb',Short.Name))

#Create a vector haveing all the SCC code
code = SCC2$SCC

#subset the data containing coal combustion related code
dat = subset(NEI, NEI$SCC %in% code)

# get the sum of emmision for every year
tab= aggregate(Emissions~year, data=dat,sum)

#plot
library(ggplot2)
png(file="plot4.png")
ggplot(tab, aes(factor(year), Emissions))+geom_bar(stat="identity")+
        labs( x="year", y="Coal Combustion-relatedEmissions in US")
dev.off()

