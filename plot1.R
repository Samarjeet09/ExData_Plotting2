setwd("C:/Users/samar/Desktop/Programming/R/ExData_Plotting2")



## 1. Have total emissions from PM2.5 decreased in the United States from 1999
## to 2008? Using the __base__ plotting system, make a plot showing the total 
## PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and
## 2008.


SCCFile <- "./data/Source_Classification_Code.rds"
summarySCC_PM25File <- "./data/summarySCC_PM25.rds"

# Read files
NEI <- readRDS(summarySCC_PM25File)
SCC <- readRDS(SCCFile)

# Calculate the sum of emission by year
totalPM25ByYear <- tapply(NEI$Emissions, NEI$year, sum)

# Plot the result
plot(names(totalPM25ByYear), totalPM25ByYear, type = "l",
     xlab = "Year", ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))

# Copy Plot in png-file
dev.copy(device = png, filename = 'plot1.png', width = 500, height = 400)
dev.off ()
