setwd("C:/Users/samar/Desktop/Programming/R/ExData_Plotting2")

## 3. Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoi
## nt, onroad, nonroad) variable, which of these four sources have seen 
## decreases in emissions from 1999–2008 for Baltimore City? Which have seen 
## increases in emissions from 1999–2008? Use the ggplot2 plotting system to 
## make a plot answer this question.

library(dplyr)
library(ggplot2)


SCCFile <- "./data/Source_Classification_Code.rds"
summarySCC_PM25File <- "./data/summarySCC_PM25.rds"

# Read files
NEI <- readRDS(summarySCC_PM25File)
SCC <- readRDS(SCCFile)


# filter data
BaltimoreCity <- NEI %>% filter(fips == 24510)
colnames(BaltimoreCity)


png("plot3.png")
ggplot(BaltimoreCity,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off()
