
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

#Glimpse in to data
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

rename <- function(x = 1:30){
  merged$participants[merged$participants == x] <- "Participant x"
  
}

merged$participants[merged$participants == 1] <- "Participant 1"
merged$participants[merged$participants == 2] <- "Participant 2"
merged$participants[merged$participants == 3] <- "Participant 3"
merged$participants[merged$participants == 4] <- "Participant 4"
merged$participants[merged$participants == 5] <- "Participant 5"
merged$participants[merged$participants == 6] <- "Participant 6"
merged$participants[merged$participants == 7] <- "Participant 7"
merged$participants[merged$participants == 8] <- "Participant 8"
merged$participants[merged$participants == 9] <- "Participant 9"
merged$participants[merged$participants == 10] <- "Participant 10"
merged$participants[merged$participants == 11] <- "Participant 11"
merged$participants[merged$participants == 12] <- "Participant 12"
merged$participants[merged$participants == 13] <- "Participant 13"
merged$participants[merged$participants == 14] <- "Participant 14"
merged$participants[merged$participants == 15] <- "Participant 15"
merged$participants[merged$participants == 16] <- "Participant 16"
merged$participants[merged$participants == 17] <- "Participant 17"
merged$participants[merged$participants == 18] <- "Participant 18"
merged$participants[merged$participants == 19] <- "Participant 19"
merged$participants[merged$participants == 20] <- "Participant 20"
merged$participants[merged$participants == 21] <- "Participant 21"
merged$participants[merged$participants == 22] <- "Participant 22"
merged$participants[merged$participants == 23] <- "Participant 23"
merged$participants[merged$participants == 24] <- "Participant 24"
merged$participants[merged$participants == 25] <- "Participant 25"
merged$participants[merged$participants == 26] <- "Participant 26"
merged$participants[merged$participants == 27] <- "Participant 27"
merged$participants[merged$participants == 28] <- "Participant 28"
merged$participants[merged$participants == 29] <- "Participant 29"
merged$participants[merged$participants == 30] <- "Participant 30"

#Appropriately labels the data set with descriptive variable names.
colnames(merged) <- gsub("^t", "time", colnames(merged))
colnames(merged) <- gsub("Gyro", "Gyroscop", colnames(merged))
colnames(merged) <- gsub("^f", "frequency", colnames(merged))
colnames(merged) <- gsub("Acc", "Accelerator", colnames(merged))
colnames(merged) <- gsub("Mag", "Magnitiude", colnames(merged))

#From the data set in step 4, createing a second, independent tidy data set with the average of 
#each variable for each activity and each subject.

class(merged)
class(merged.dt)
head(TidyData)
colnames(merged)

merged.dt <- data.table(merged)
TidyData <- merged.dt[, lapply(.SD, mean), by = 'participants,activities']
write.table(TidyData, file = "Tidy.txt", row.names = FALSE)
  
# output to file "tidy_data.txt"
write.table(humanActivityMeans, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)


save.image()


