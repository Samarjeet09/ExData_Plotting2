setwd("C:/Users/samar/Desktop/Programming/R/ExData_Plotting2")

## 6. Compare emissions from motor vehicle sources in Baltimore City with
## emissions from motor vehicle sources in Los Angeles County, California
## (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes over time 
## in motor vehicle emissions?


# Load libraries
library(dplyr)
library(ggplot2)

SCCFile <- "./data/Source_Classification_Code.rds"
summarySCC_PM25File <- "./data/summarySCC_PM25.rds"
# Read files
NEI <- readRDS(summarySCC_PM25File)
SCC <- readRDS(SCCFile)



# Fetch data of type "ON-ROAD" from Baltimore City & Los Angeles County, California
MV <- subset(NEI, (fips == "24510" | fips == "06037") & type=="ON-ROAD")
# Use more meaningful variable names
MV <- transform(MV, region = ifelse(fips == "24510", "Baltimore City", 
                                    "Los Angeles County"))

# Calculate the sum of emission by year and region
MVPM25ByYearAndRegion <- MV %>% select (year, region, Emissions) %>% 
  group_by(year, region) %>% 
  summarise_each(funs(sum))

# Create a plot normalized to 1999 levels to better show change over time
Balt1999Emissions <- subset(MVPM25ByYearAndRegion, year == 1999 & 
                              region == "Baltimore City")$Emissions
LAC1999Emissions <- subset(MVPM25ByYearAndRegion, year == 1999 & 
                             region == "Los Angeles County")$Emissions
MVPM25ByYearAndRegionNorm <- transform(MVPM25ByYearAndRegion,
                                       EmissionsNorm = ifelse(region == 
                                                                "Baltimore City",
                                                              Emissions / Balt1999Emissions,
                                                              Emissions / LAC1999Emissions))

# Plot the result
ggplot(MVPM25ByYearAndRegionNorm, aes(x = year, y = EmissionsNorm, color = region)) +
  geom_line() +
  ggtitle(expression("Total" ~ PM[2.5] ~ "Motor Vehicle Emissions Normalized to 1999 Levels")) + 
  xlab("Year") +
  ylab(expression("Normalized" ~ PM[2.5] ~ "Emissions"))

# Copy Plot in png-file
dev.copy(device = png, filename = 'plot6.png', width = 500, height = 400)
dev.off ()
