# Downloading the dataset
setwd("C:/Users/samar/Desktop/Programming/R/ExData_Plotting2")
# init variables about subdirectory, zipfilename and zipfilepath
subdirectory              <- "./data/"
zipFileName               <- "NEI_data.zip"
zipFilePath               <- paste0(subdirectory, zipFileName)
fileURL                   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

# If subdirectory "data" doesn't exists, then create this.
if (!file.exists("data")) {
  dir.create("data")
}

# If zip file isn't stored in subdirectory data, it will be downloaded.
if (!file.exists(zipFilePath)){
  download.file(fileURL, zipFilePath, method="curl")
}  

# Upzip downloaded zip file
if (file.exists(zipFilePath)) { 
  unzip(zipFilePath, exdir = subdirectory) 
}
