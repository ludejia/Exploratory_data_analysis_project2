#Create the data set
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset data for Baltimore City from the dataset
dat = subset(NEI, fips=='24510')

#Create an array to do a summary
tab = tapply(dat$Emissions, dat$year, sum)

#Convert the array to a dataframe
tab = as.data.frame.table(tab)

#plot
png(file="plot2.png")
barplot(Freq ~ Var1, data = tab,, xlab="Baltimore City", ylab = 'Total PM2.5 Emmission')
dev.off()

