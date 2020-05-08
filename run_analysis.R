
#Loading packages
library(dplyr)
library(tidyverse)
library(RCurl)
library(lubridate)
library(data.table)

#Loading data
if(!file.exists("data")){
  dir.create("data")
}

data <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", method = "curl", data)
datedownloaded <- today()
unzip(data, list = TRUE)

xtest <- read.table(unzip(data, "UCI HAR Dataset/test/X_test.txt"))
xtest <- read.table(file.choose())
ytest <- read.table(unzip(data, "UCI HAR Dataset/test/y_test.txt"))
ytest <- read.table(file.choose())
subjecttest <- read.table(unzip(data, "UCI HAR Dataset/test/subject_test.txt"))
xtrain <- read.table(unzip(data, "UCI HAR Dataset/train/X_train.txt"))
ytrain <- read.table(unzip(data, "UCI HAR Dataset/train/y_train.txt"))

subjecttrain <- read.table(unzip(data, "UCI HAR Dataset/train/subject_train.txt"))
features <- read.table(unzip(data, "UCI HAR Dataset/features.txt"))
unlink(data)

head(xtest)
head(ytrain)
tail(ytest)
head(features)
class(xtest)
str(xtest)

#Naming colums of xtrain and xtest 
colnames(xtest) <- t(features[2])
colnames(xtrain) <- t(features[2])

xtrain$activities <- ytrain[,1]
xtrain$participants <- subjecttrain[,1]

xtest$activities <-ytest[,1]
xtest$participants <- subjecttest[,1]

#Merging xtest and xtrain datasets

merged <- rbind(xtest, xtrain) 

#Extracts only the measurements on the mean and standard deviation for each measurement.

mean <- grep("mean()", colnames(merged))
meanset <- merged[mean]
head(meanset)

std <- grep("std()", colnames(merged))
stdset <- merged[std]
head(stdset)                

#Uses descriptive activity names to name the activities in the data set
str(merged$activities)
merged$activities[merged$activities == 1] <- "walking"
merged$activities[merged$activities == 2] <- "walking _upstairs"
merged$activities[merged$activities == 3] <- "walking_downstairs"
merged$activities[merged$activities == 4] <- "sitting"
merged$activities[merged$activities == 5] <- "standing"
merged$activities[merged$activities == 6] <- "laying"

#Appropriately labels the data set with descriptive variable names.
colnames(merged) <- gsub("t", "time", colnames(merged))
colnames(merged) <- gsub("Gyro", "Gyroscop", colnames(merged))
colnames(merged) <- gsub("f", "frequency", colnames(merged))
colnames(merged) <- gsub("Acc", "Accelerator", colnames(merged))
colnames(merged) <- gsub("Mag", "Magnitiude", colnames(merged))

merged$participants <- as.character(merged$participants
merged$par [merged$participants == 1] <- "Participant 1"
