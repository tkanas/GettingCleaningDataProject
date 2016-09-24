# Clear workspace
rm(list=ls())
# Set working directory
setwd("/Users/tatjanawiese/Datasci/Datasciencecoursera/GettingCleaningData/CourseProject")

library(plyr)

# Download dataset
if(!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data/samsdata.zip", method = "curl")
dateDownloaded <- now()
# Read dataset
unzip("./data/samsdata.zip", exdir = "./data")
trainingdata <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
testingdata <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
activitylabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
traininglabels <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
testinglabels <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

# Merge training and testing data to create single data set
mergedData <- rbind(trainingdata, testingdata)
# Get means and standard deviations (stds) of each column
means <- colMeans(mergedData)
stds <- apply(mergedData,2,sd)

# Make tidy labels, attach to mergedData
mergedLabels <- rbind(traininglabels, testinglabels)
tidyLabels <- join(mergedLabels, activitylabels)
mergedData$Activity <- tidyLabels$V2