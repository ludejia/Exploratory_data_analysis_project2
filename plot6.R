#Create the data set
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset SCC for motor vehicle sources from the dataset
SCC2=subset(SCC, grepl('Vehicle|Highway Veh',Short.Name))
SCC3= subset(SCC2, EI.Sector!='Mobile - Non-Road Equipment - Diesel'&
                     EI.Sector!='Mobile - Non-Road Equipment - Gasoline'&
                     EI.Sector!='Mobile - Non-Road Equipment - Other' &
                     EI.Sector!='Solvent - Industrial Surface Coating & Solvent Use' &
                     EI.Sector!='Miscellaneous Non-Industrial NEC' )


#Create a vector haveing all the SCC code
code = SCC3$SCC

#subset the data containing motor vehicle related code and city is Baltimore & los Angelas
dat = subset(NEI, NEI$SCC %in% code )
dat = subset(dat, fips=="24510"|fips=="06037" )


# get the sum of emmision for every year
tab= aggregate(Emissions~year+fips, data=dat,sum)

tab$fips[tab$fips=='06037'] = 'Los Angeles County'
tab$fips[tab$fips=='24510'] = 'Baltimore City'

#plot
library(ggplot2)
png(file="plot6.png")
ggplot(tab, aes(factor(year), Emissions))+geom_bar(stat="identity")+
        facet_grid(.~fips)+labs( x="year", y="Vehicle-related Emissions")
dev.off()


