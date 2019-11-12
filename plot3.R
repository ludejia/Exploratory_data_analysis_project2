#Create the data set
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset data for Baltimore City from the dataset
dat = subset(NEI, fips=='24510')

#Create a new dataframe to do a summary
tab = aggregate(Emissions~type+year,data=dat,sum)

# Change numeric valur of the year to factors
tab$year = as.factor(tab$year)

#plot
library(ggplot2)
png(file="plot3.png")
ggplot(tab, aes(year, Emissions))+geom_bar(stat="identity")+facet_grid(.~type)+
        labs( x="Baltimore City", y="Emissions")
dev.off()


