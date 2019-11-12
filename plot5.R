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

#subset the data containing motor vehicle related code and city is Baltimore
dat = subset(NEI, NEI$SCC %in% code & fips=="24510")

# get the sum of emmision for every year
tab= aggregate(Emissions~year, data=dat,sum)

#plot
library(ggplot2)
png(file="plot5.png")
ggplot(tab, aes(factor(year), Emissions))+geom_bar(stat="identity")+
        labs( x="year", y="Baltimore Vehicle-related Emissions")
dev.off()

