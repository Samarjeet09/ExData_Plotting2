setwd("C:/Users/samar/Desktop/Programming/R/ExData_Plotting2")


## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make a
## plot answering this question.
library(dplyr)

SCCFile <- "./data/Source_Classification_Code.rds"
summarySCC_PM25File <- "./data/summarySCC_PM25.rds"

# Read files
NEI <- readRDS(summarySCC_PM25File)
SCC <- readRDS(SCCFile)


# filter data
BaltimoreCity <- NEI %>% filter(fips == 24510)

# Calculate the sum of emission by year
totalPM25ofBCByYear <- tapply(BaltimoreCity$Emissions, BaltimoreCity$year, sum)


plot(names(totalPM25ofBCByYear), totalPM25ofBCByYear, type = "l", xlab = "Year", 
     ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), 
     main = expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions by Year"))

# Copy Plot in png-file
dev.copy(device = png, filename = 'plot2.png', width = 500, height = 400)
dev.off ()
