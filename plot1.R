#Create the data set
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Create an array to do a summary
tab = tapply(NEI$Emissions, NEI$year, sum)

#Convert the array to a dataframe
tab = as.data.frame.table(tab)

#plot
png(file="plot1.png")
barplot(Freq ~ Var1, data = tab,, xlab="year", ylab = 'Total PM2.5 Emmission')
dev.off()




