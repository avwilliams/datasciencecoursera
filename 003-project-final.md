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
train.data.path
## [1] "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/train/X_train.txt"
## [2] "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/train/subject_train.txt"
## [3] "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/train/y_train.txt"

# train data path list
train.data.list <- lapply(train.data.path, read.table)
class(train.data.list)
str(train.data.list)
## List of 3
## $ :'data.frame':  7352 obs. of  561 variables:
##   ..$ V1  : num [1:7352] 0.289 0.278 0.28 0.279 0.277
##   ..$ V99 : num [1:7352] -1 -1 -1 -1 -1 ...
##  .. [list output truncated]
## $ :'data.frame':  7352 obs. of  1 variable:
##   ..$ V1: int [1:7352] 1 1 1 1 1 1 1 1 1 1 ...
## $ :'data.frame':  7352 obs. of  1 variable:
##   ..$ V1: int [1:7352] 5 5 5 5 5 5 5 5 5 5 ...

# Training set: 561 columns - see features.txt
train.data.list[1]
head(train.data.list[[1]], 1)
tail(train.data.list[[1]], 1)

# Subject: that performed an Activity: 1 - 30
train.data.list[2]
head(train.data.list[[2]])
tail(train.data.list[[2]])
unique(train.data.list[[2]])

# Training labels: - activity name: 1 - 6
train.data.list[3]
head(train.data.list[[3]])
tail(train.data.list[[3]])
unique(train.data.list[[3]])

# train data list data frame
train.data.list.df <- as.data.frame(train.data.list)
is.data.frame(train.data.list.df)
## [1] TRUE
str(train.data.list.df)
head(train.data.list.df, 1)
tail(train.data.list.df, 1)
train.data.list.df[1,]
train.data.list.df[2,]
train.data.list.df[,1]
train.data.list.df[,562]
train.data.list.df[,563]
train.data.list.df$V1.1
train.data.list.df$V1.2

names(train.data.list.df)
names(train.data.list.df)[562:563] <- c("trsubject", "tractivity")
names(train.data.list.df)

###
# Path to test data
test.data.path <-
  list.files("/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/test",
             pattern = ".txt", full.names = TRUE)

test.data.path
## [1] "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/test/X_test.txt"
## [2] "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/test/subject_test.txt"
## [3] "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/test/y_test.txt"

# test data path list
test.data.list <- lapply(test.data.path, read.table)
class(test.data.list)
## [1] "list"
str(test.data.list)

# Test set: 561 columns - see features.txt
## List of 3
## $ :'data.frame':  2947 obs. of  561 variables:
##   ..$ V1  : num [1:2947] 0.257 0.286 0.275 0.27 0.275 ...
## .. [list output truncated]
## $ :'data.frame':  2947 obs. of  1 variable:
##   ..$ V1: int [1:2947] 2 2 2 2 2 2 2 2 2 2 ...
## $ :'data.frame':	2947 obs. of  1 variable:
##   ..$ V1: int [1:2947] 5 5 5 5 5 5 5 5 5 5 ...

# test set
test.data.list[1]
test.data.list[[1]][1]
head(test.data.list[[1]], 1)
tail(test.data.list[[1]], 1)

# Subject: that performed an Activity: 1 - 30
test.data.list[2]
head(test.data.list[[2]])
tail(test.data.list[[2]])
unique(test.data.list[[2]])

# testing labels: - activity name: 1 - 6
test.data.list[3]
head(test.data.list[[3]])
tail(test.data.list[[3]])
unique(test.data.list[[3]])

# test data list data frame
test.data.list.df <- as.data.frame(test.data.list)
str(test.data.list.df)
## 'data.frame':  2947 obs. of  563 variables:
# $ V1  : num  0.257 0.286 0.275 0.27 0.275 ...
head(test.data.list.df, 1)
tail(test.data.list.df, 1)
test.data.list.df[1,]
test.data.list.df[2,]
test.data.list.df[,1]
test.data.list.df[,562]
test.data.list.df[,563]
test.data.list.df$V1.1
test.data.list.df$V1.2

# test data list data frame names
names(test.data.list.df)
names(test.data.list.df)[562:563]
names(test.data.list.df)[562:563] <- c("tsubject", "tactivity")
names(test.data.list.df)

### Features and Activities data
featureData <- read.csv("../003-projdata/UCI-HAR-Data/features.csv", header = TRUE, sep = ";",
                        stringsAsFactors = FALSE)

str(featureData)
## 'data.frame':  561 obs. of  4 variables:
## $ prefix   : chr  "t" "t" "t" "t" ...
## $ signal   : chr  "BodyAcc" "BodyAcc" "BodyAcc" "BodyAcc" ...
## $ variable : chr  "mean" "mean" "mean" "std" ...
## $ direction: chr  "X" "Y" "Z" "X" ...
featureData
head(featureData, 10)
tail(featureData, 10)

names(featureData)
featureData[featureData$variable == "mean",]
featureData[featureData$variable == "std",]

which(featureData$variable == "mean")
which(featureData$variable == "std")

mn <- subset(featureData, variable == "mean" ,
             select = signal)
mn

st <- subset(featureData, variable == "std" ,
             select = signal)
st

###### Activity labels
# gsub(pattern, replacement, x, ignore.case = FALSE, perl = FALSE,
# fixed = FALSE, useBytes = FALSE)
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
mn
str(mn)
class(mn)
names(mn)
names.mn <- names(train.dl.df.mn)
names.mn
str(names.mn)

# rename train columns for mean variables
names(train.dl.df.mn)[1:33] <- mn$signal
train.dl.df.mn
names(train.dl.df.mn)

# std
names(train.dl.df.st)
st
class(st)
str(st)
names(st)
names.st <- names(train.dl.df.st)
names.st
str(names.st)

# rename train columns for std variables
names(train.dl.df.st)[1:33] <- st$signal
train.dl.df.st
head(train.dl.df.st, 1)
names(train.dl.df.st)

# rename train columns for subject, activity code
# and activity name variables

train.dl.df.su <- train.data.list.df$trsubject
str(train.dl.df.su)
##  int [1:7352] 1 1 1 1 1 1 1 1 1 1 ...

train.dl.df.ac <- train.data.list.df$tractivity
str(train.dl.df.ac )
## int [1:7352] 5 5 5 5 5 5 5 5 5 5 ...

train.dl.su.ac <- data.frame(trsubject = train.dl.df.su, tractcode = train.dl.df.ac)
train.dl.su.ac
head(train.dl.su.ac, 1)

# Activity code and names
activityData
activityData$actcode
activityData$activity
train.dl.su.ac$tractcode

activityData.s <- subset(train.dl.su.ac,
                         train.dl.su.ac$tractcode %in% activityData$actcode,
                         select = tractcode)
activityData.s
str(activityData.s)
activityData.s$tractcode
activityData.s[activityData.s$tractcode == 2, ]

length()
activityData.sa <- subset(activityData,
                          activityData$actcode %in% train.dl.su.ac$tractcode,
                          select = activity)
activityData.sa


###### test set df
test.dl.df.mn <- test.data.list.df[c(which(featureData$variable == "mean"))]
test.dl.df.st <- test.data.list.df[c(which(featureData$variable == "std"))]
test.dl.df.su <- test.data.list.df$tsubject
test.dl.df.ac <- test.data.list.df$tactivity

# names(test.data.list.df)[562:563] <- c("tsubject", "tactivity")
# mean
mn
str(mn)
class(mn)
names(mn)
names.mn <- names(test.dl.df.mn)
names.mn
str(names.mn)

# rename test columns for mean variables
names(test.dl.df.mn)[1:33] <- mn$signal
test.dl.df.mn
head(test.dl.df.mn, 1)
names(test.dl.df.mn)

# std
names(test.dl.df.st)
st
class(st)
str(st)
names(st)
names.st <- names(test.dl.df.st)
names.st
str(names.st)

# rename test columns for std variables
names(test.dl.df.st)[1:33] <- st$signal
test.dl.df.st
head(test.dl.df.st, 1)
names(test.dl.df.st)

# rename test columns for subject and activities variables
test.dl.df.su <- test.data.list.df$tsubject
str(test.dl.df.su)
##  int [1:2947] 2 2 2 2 2 2 2 2 2 2 ...

test.dl.df.ac <- test.data.list.df$tactivity
str(test.dl.df.ac )
## int [1:2947] 5 5 5 5 5 5 5 5 5 5 ...

test.dl.su.ac <- data.frame(tsubject = test.dl.df.su, tactivity = test.dl.df.ac)
test.dl.su.ac
head(test.dl.su.ac, 1)

###### data frame with train, test, subjects, activities,
train.dl.df.mn
head(train.dl.df.mn, 1)

train.dl.df.st
head(train.dl.df.st, 1)

train.dl.mnst.df <- data.frame(c(train.dl.df.mn, train.dl.df.st))

train.dl.df.su <- train.data.list.df$trsubject
train.dl.df.ac <- train.data.list.df$tractivity
train.dl.df.su
str(train.dl.df.su)
train.dl.df.ac
str(train.dl.df.ac)
train.suac <- data.frame(trsubject = train.dl.df.su, tractivity = train.dl.df.ac)
str(train.suac)
## 'data.frame':  7352 obs. of  2 variables:
## $ trsubject : int  1 1 1 1 1 1 1 1 1 1 ...
## $ tractivity: int  5 5 5 5 5 5 5 5 5 5 ...

###
test.dl.df.mn
test.dl.df.st

test.dl.mnst.df <- data.frame(c(test.dl.df.mn, test.dl.df.st))
rm(test.dl.mnst.suac.df)

test.dl.df.su <- test.data.list.df$trsubject
test.dl.df.ac <- test.data.list.df$tractivity
test.suac <- data.frame(tsubject = test.dl.df.su, tactivity = test.dl.df.ac)
str(test.suac)
## 'data.frame':  2947 obs. of  2 variables:
##   $ tsubject : int  2 2 2 2 2 2 2 2 2 2 ...
## $ tactivity: int  5 5 5 5 5 5 5 5 5 5 ...

###
train.dl.mnst.df
train.suac

train.dl.mnst.suac.df <- data.frame(train.dl.mnst.df, train.suac)

###
test.dl.mnst.df
test.suac

test.dl.mnst.suac.df <- data.frame(test.dl.mnst.df, test.suac)

######
train.dl.mnst.suac.df
head(train.dl.mnst.suac.df)
test.dl.mnst.suac.df
head(test.dl.mnst.suac.df)

train.test.dl.mnst.suac <- merge(train.dl.mnst.suac.df, test.dl.mnst.suac.df,
                                 by.x = "trsubject", by.y = "tsubject",
                                 all = TRUE, sort = TRUE)

train.test.dl.mnst.suac
head(train.test.dl.mnst.suac)
tail(train.test.dl.mnst.suac)

names(train.test.dl.mnst.suac)

tail(train.test.dl.mnst.suac$trsubject)

train.test.dl.mnst.suac$tactivity

7352+2947
## [1] 10299
