setwd("C:/Users/samar/Desktop/Programming/R/ExData_Plotting2")

 
## 4. Across the United States, how have emissions from coal combustion-related
## sources changed from 1999–2008?

# Load libraries
library(dplyr)
library(ggplot2)


SCCFile <- "./data/Source_Classification_Code.rds"
summarySCC_PM25File <- "./data/summarySCC_PM25.rds"

# Read files
NEI <- readRDS(summarySCC_PM25File)
SCC <- readRDS(SCCFile)


# Fetch coal-combustion only
CoalCombustionSCC0 <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Instutional - Coal",
                                                   "Fuel Comb - Electric Generation - Coal",
                                                   "Fuel Comb - Industrial Boilers, ICEs - Coal"))

# Compare to Short.Name matching both Comb and Coal
CoalCombustionSCC1 <- subset(SCC, grepl("Comb", Short.Name) & 
                               grepl("Coal", Short.Name))

# 
print(paste("Number of subsetted lines via EI.Sector:", nrow(CoalCombustionSCC0)))
print(paste("Number of subsetted lines via Short.Name:", nrow(CoalCombustionSCC1)))

# set the differences
diff0 <- setdiff(CoalCombustionSCC0$SCC, CoalCombustionSCC1$SCC)
diff1 <- setdiff(CoalCombustionSCC1$SCC, CoalCombustionSCC0$SCC)

print(paste("Number of setdiff (data via EI.Sector & Short.Name):", length(diff0)))
print(paste("Number of setdiff (data via Short.Name & EI.Sector):", length(diff1)))

# Create the union of SCCs via EI.Sector & Short.Name
CoalCombustionSCCCodes <- union(CoalCombustionSCC0$SCC, CoalCombustionSCC1$SCC)
print(paste("Number of SCCs:", length(CoalCombustionSCCCodes)))

# Fetch needed NEI data via SCCs
CoalCombustion <- subset(NEI, SCC %in% CoalCombustionSCCCodes)

# Calculate the sum of emission by type and year
coalCombustionPM25ByYear <- CoalCombustion %>% select(year, type, Emissions) %>%
  group_by(year, type) %>%
  summarise_each(funs(sum))

# Plot the result

ggplot(coalCombustionPM25ByYear, aes(x = year, y = Emissions, color = type)) +
  geom_line() +
  stat_summary(fun = sum, aes(group = 1), geom = "line", color = "purple") +
  ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + 
  xlab("Year") + 
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))



# Copy Plot in png-file
dev.copy(device = png, filename = 'plot4.png', width = 500, height = 400)
dev.off ()
