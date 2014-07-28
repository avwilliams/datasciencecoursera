######### Getting and Cleaning Data Week 3 Project
#  You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. Creates a second, independent tidy data set with the average of each variable
# for each activity and each subject.

### Libraries
library(reshape2)
library(stringr)
library(plyr)
library(data.table)

### Option
options(stringsAsFactors = FALSE)

### Data files
# Path to training data
train.data.path <-
  list.files("/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/train",
             pattern = ".txt", full.names = TRUE)

# train data path list
train.data.list <- lapply(train.data.path, read.table)
class(train.data.list)
#str(train.data.list)

# Training set: 561 columns - see features.txt

# Subject: that performed an Activity: 1 - 30

# Training labels: - activity name: 1 - 6


# train data list data frame
train.data.list.df <- as.data.frame(train.data.list)
is.data.frame(train.data.list.df)

# rename train data list column 564 and 563
names(train.data.list.df)[c(562,563)] <- c("trsubject", "tractivity")


###
# Path to test data
test.data.path <-
  list.files("/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/test",
             pattern = ".txt", full.names = TRUE)

# test data path list
test.data.list <- lapply(test.data.path, read.table)
class(test.data.list)

# Test set: 561 columns - see features.txt

# test set

# Subject: that performed an Activity: 1 - 30

# testing labels: - activity name: 1 - 6

# test data list data frame
test.data.list.df <- as.data.frame(test.data.list)

# test data list data frame names

# rename test data list columns 562 and 563
names(test.data.list.df)[c(562,563)] <- c("tsubject", "tactivity")

### Features and Activities data
featureData <- read.csv("../003-projdata/UCI-HAR-Data/features.csv", header = TRUE, sep = ";",
                        stringsAsFactors = FALSE)

which(featureData$variable == "mean")
which(featureData$variable == "std")

mn <- subset(featureData, variable == "mean" ,
             select = signal)

st <- subset(featureData, variable == "std" ,
             select = signal)

###### Activity labels
activityFile <- read.table(
  "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/activity_labels.txt")
activityData <- data.frame(actcode = c(1:6), activity = gsub("_", " ", activityFile$V2))
activityData

###### Subsetting training set df - mean, std, subject, activity
train.dl.df.mn <- train.data.list.df[c(which(featureData$variable == "mean"))]
train.dl.df.st <- train.data.list.df[c(which(featureData$variable == "std"))]
train.dl.df.su <- train.data.list.df$trsubject
train.dl.df.ac <- train.data.list.df$tractivity

### column names
# names(train.dl.df.mn)[562:563] <- c("trsubject", "tractivity")
names(train.dl.df.mn)

# mean
names.mn <- names(train.dl.df.mn)

# rename train columns for mean variables
names(train.dl.df.mn)[1:33] <- mn$signal

# std
names.st <- names(train.dl.df.st)

# rename train columns for std variables
names(train.dl.df.st)[1:33] <- st$signal

# rename train columns for subject, activity code
# and activity name variables
train.dl.df.su <- train.data.list.df$trsubject
train.dl.df.ac <- train.data.list.df$tractivity

train.dl.su.ac <- data.frame(trsubject = train.dl.df.su, tractcode = train.dl.df.ac)


# Activity code and names
# activityData
#
#activityData.s <- subset(train.dl.su.ac,
#                         train.dl.su.ac$tractcode %in% activityData$actcode,
#                         select = tractcode)
#activityData.s
#str(activityData.s)
#activityData.s$tractcode
#activityData.s[activityData.s$tractcode == 2, ]

#length()
#activityData.sa <- subset(activityData,
#                          activityData$actcode %in% train.dl.su.ac$tractcode,
#                          select = activity)
#activityData.sa


###### test set df
test.dl.df.mn <- test.data.list.df[c(which(featureData$variable == "mean"))]
test.dl.df.st <- test.data.list.df[c(which(featureData$variable == "std"))]
test.dl.df.su <- test.data.list.df$tsubject
test.dl.df.ac <- test.data.list.df$tactivity

# names for test data subject and activiity
#names(test.data.list.df)[c(562,563)] <- c("tsubject", "tactivity")
# mean
names.mn <- names(test.dl.df.mn)

# rename test columns for mean variables
names(test.dl.df.mn)[1:33] <- mn$signal

# std
names.st <- names(test.dl.df.st)

# rename test columns for std variables
names(test.dl.df.st)[1:33] <- st$signal

# rename test columns for subject and activities variables
test.dl.df.su <- test.data.list.df$tsubject
test.dl.df.ac <- test.data.list.df$tactivity

test.dl.su.ac <- data.frame(tsubject = test.dl.df.su, tactivity = test.dl.df.ac)

###### data frame with train, test, subjects, activities,
train.dl.mnst.df <- data.frame(c(train.dl.df.mn, train.dl.df.st))

train.dl.df.su <- train.data.list.df$trsubject
train.dl.df.ac <- train.data.list.df$tractivity

train.suac <- data.frame(trsubject = train.dl.df.su, tractivity = train.dl.df.ac)

###
test.dl.mnst.df <- data.frame(c(test.dl.df.mn, test.dl.df.st))

test.dl.df.su <- test.data.list.df$tsubject
test.dl.df.ac <- test.data.list.df$tactivity

test.suac <- data.frame(tsubject = test.dl.df.su, tactivity = test.dl.df.ac)

### train set
train.dl.mnst.suac.df <- data.frame(train.dl.mnst.df, train.suac)

### test set
test.dl.mnst.suac.df <- data.frame(test.dl.mnst.df, test.suac)

######
train.test.dl.mnst.suac <- merge(train.dl.mnst.suac.df, test.dl.mnst.suac.df,
                                 by.x = "trsubject", by.y = "tsubject",
                                 all = TRUE, sort = TRUE)

7352+2947

### melt or ddply
