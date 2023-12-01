setwd("C:/Users/samar/Desktop/Programming/R/ExData_Plotting2")


# 5. How have emissions from motor vehicle sources changed from 1999–2008 in
## Baltimore City?

# Load libraries
library(dplyr)
library(ggplot2)

SCCFile <- "./data/Source_Classification_Code.rds"
summarySCC_PM25File <- "./data/summarySCC_PM25.rds"
# Read files
NEI <- readRDS(summarySCC_PM25File)
SCC <- readRDS(SCCFile)


BaltimoreCity <- NEI %>%
  filter(fips == "24510" , type=="ON-ROAD")%>%
  select (year, Emissions) %>% 
  group_by(year) %>% summarise(sum = sum(Emissions)) 
BaltimoreCity


ggplot(BaltimoreCity, aes(x = year, y = sum)) +
  geom_line() +
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
  xlab("Year") + 
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))    


# Copy Plot in png-file
dev.copy(device = png, filename = 'plot5.png', width = 500, height = 400)
dev.off ()

