######### Getting and Cleaning Data Week 3 Project
#  You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. Creates a second, independent tidy data set with the average of each variable
# for each activity and each subject.

setwd("~/Workspace/DataAnalytics/Coursera-DS")
rm(list=ls())

### Libraries
library(tidyr)
library(reshape2)
library(stringr)
library(plyr)
library(dplyr)
library(data.table)
library(Hmisc)
library(foreach)

### Option
options(stringsAsFactors = FALSE)

###### Data files
### Features and Activities data
# source("003-getting-cleaning-data/003-projdata-features-tidy.R")

### Features Data
featureData <- read.csv(
  "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/features.csv",
  header = TRUE, sep = ",", stringsAsFactors = FALSE)

### Activity Data
activityFile <- read.table(
  "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/activity_labels.txt")
activityData <- data.frame(activityID = c(1:6), activity = gsub("_", " ", activityFile$V2))

# Path to training data
train.data.path <-
  list.files("/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/train",
             pattern = ".txt", full.names = TRUE)

# train data path list
train.data.list <- lapply(train.data.path, read.table)

# Subject: subject_train.txt - that performed an Activity: 1 - 30
# Training set: X_train.txt - 561 columns - see features.txt for column names
# Training labels/ Activity Codes: y_train.txt - activity name: 1 - 6

# train data list data frame
# Subject
train.data.list.su.df <- as.data.frame(train.data.list[1])

# Activity ID
train.data.list.ac.df <- as.data.frame(train.data.list[3])

# Training set
train.data.list.df <- as.data.frame(train.data.list[2])

# Columns of interest

### feature - columns - mean
# featureData
mn <- subset(featureData, measurement == "mean" ,
             select = c(domain, signal, measurement, direction))
mn <- cbind(mnID = as.integer(rownames(mn)), mn)

mn.names <- paste(mn$domain, mn$signal, mn$measurement, mn$direction, sep = "_")
mn.names <- gsub("mean_", "mean", mn.names)

### feature - columns - std
st <- subset(featureData, measurement == "std" ,
             c(domain, signal, measurement, direction))
st <- cbind(stID = as.integer(rownames(st)), st)

st.names <- paste(st$domain,st$signal,st$measurement, st$direction, sep = "_")
st.names <- gsub("std_", "std", st.names)

###### Subsetting/extracting training set df - mean, std, subject
### subject - column
names(train.data.list.su.df)[1] <- "subjectID"

### activityID - column
names(train.data.list.ac.df)[1] <- "activityID"

###### train set column names
### mean - columns
names(train.data.list.df)[mn$mnID] <- c(mn.names)

### std columns
names(train.data.list.df)[st$stID] <- c(st.names)

###### Train set data frames
mn.st <- c(mn$mnID, st$stID)

# train set mean and std
train.dl.mn.st.df <- train.data.list.df[c(mn.st)]

###### train - Activity labels
### train Activity code and names
# activity columns from activityID
# activityData

activity.train <- data.frame(activity = train.data.list.ac.df$activityID)

###
actID.from <- activityData$activityID
actID.to <- activityData$activity

actIDsubt <- function(pattern, replacement, x, ...) {
  for(i in 1:length(pattern))
    x <- gsub(pattern[i], replacement[i], x, ...)
    x
}

activity.train$activity <- actIDsubt(actID.from, actID.to, activity.train$activity)

# train set subject ID, activity, mean and std

train.dl.mn.st.suac.df <- data.frame(
  subjectID = train.data.list.su.df$subjectID,
  data_set = rep("training", 7352),
  activity = activity.train$activity,
  train.dl.mn.st.df[1:66])

#########
# Path to test data
test.data.path <-
  list.files("/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/test",
             pattern = ".txt", full.names = TRUE)

# test data path list
test.data.list <- lapply(test.data.path, read.table)

# Subject: that performed an Activity: 1 - 30 - subjectID
# test set
# testing labels: - activity name: 1 - 6 - activityID

# Columns of interest

# test data list data frame
# test Subject
test.data.list.su.df <- as.data.frame(test.data.list[1])

# test activity code
test.data.list.ac.df <- as.data.frame(test.data.list[3])

# test set
test.data.list.df <- as.data.frame(test.data.list[2])

###### test set - Features and Activities data
### feature - columns - mean

mn <- subset(featureData, measurement == "mean" ,
             select = c(domain, signal, measurement, direction))
mn <- cbind(mnID = as.integer(rownames(mn)), mn)

mn.names <- paste(mn$domain, mn$signal, mn$measurement, mn$direction, sep = "_")
mn.names <- gsub("mean_", "mean", mn.names)

### feature - columns - std
st <- subset(featureData, measurement == "std" ,
             c(domain, signal, measurement, direction))
st <- cbind(stID = as.integer(rownames(st)), st)

st.names <- paste(st$domain,st$signal,st$measurement, st$direction, sep = "_")
st.names <- gsub("std_", "std", st.names)

###### Subsetting/extracting test set df - mean, std, subject
### subject - column
names(test.data.list.su.df)[1] <- "subjectID"

### activityID - column
names(test.data.list.ac.df)[1] <- "activityID"

###### test set column names
### mean - columns
names(test.data.list.df)[mn$mnID] <- c(mn.names)

### std columns
names(test.data.list.df)[st$stID] <- c(st.names)

###### test set data frames
mn.st <- c(mn$mnID, st$stID)

# test set mean and std
test.dl.mn.st.df <- test.data.list.df[c(mn.st)]

###### test - Activity labels
### test Activity code and names
# activity columns from activityID
activity.test <- data.frame(activity = test.data.list.ac.df$activityID)

###
actID.from <- activityData$activityID
actID.to <- activityData$activity

actIDsubt <- function(pattern, replacement, x, ...) {
  for(i in 1:length(pattern))
    x <- gsub(pattern[i], replacement[i], x, ...)
    x
}

activity.test$activity <- actIDsubt(actID.from, actID.to, activity.test$activity)

# test set subject ID, activity, mean and std
test.dl.mn.st.suac.df <- data.frame(
  subjectID = test.data.list.su.df$subjectID,
  data_set = rep("test", 2947),
  activity = activity.test$activity,
  test.dl.mn.st.df[1:66])

############### Putting them together
### train and test subject ID, activity ID, mean and sts data frames with column names
# train.df <- train.dl.mn.st.suac.df
# test.df <- test.dl.mn.st.suac.df

### rbind()
train.test.rbdf <- rbind(train.dl.mn.st.suac.df, test.dl.mn.st.suac.df)

### semi Tidy data
getwd()
write.table(train.test.rbdf, "003-projdata/train-test.csv",
            quote = FALSE, sep = ",", col.names = TRUE, row.name = FALSE)
