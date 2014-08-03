## Getting and Cleaning Data Week 3 Project
####  You should create one R script called run_analysis.R that does the following.
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. Creates a second, independent tidy data set with the average of each variable
for each activity and each subject.

```
rm(list=ls())
setwd("~/Workspace/DataAnalytics/Coursera-DS")

#### Libraries
library(tidyr)
library(reshape2)
library(stringr)
library(plyr)
library(dplyr)
library(data.table)
library(Hmisc)
library(foreach)
```
#### Option
```
options(stringsAsFactors = FALSE)
```
###3 Data files

Path to training data
```
train.data.path <-
  list.files("/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/train",
             pattern = ".txt", full.names = TRUE)

train.data.path


## [1] "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/train/X_train.txt"
## [2] "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/train/subject_train.txt"
## [3] "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/train/y_train.txt"
```

#### train data path list
```
train.data.list <- lapply(train.data.path, read.table)
class(train.data.list)
##[1] "list"
str(train.data.list)
## List of 3
##  $ :'data.frame':  7352 obs. of  1 variable:
##   ..$ V1: int [1:7352] 1 1 1 1 1 1 1 1 1 1 ...
##  $ :'data.frame':  7352 obs. of  561 variables:
##   ..$ V1  : num [1:7352] 0.289 0.278 0.28 0.279 0.277 ...
##   .. [list output truncated]
##  $ :'data.frame':  7352 obs. of  1 variable:
##   ..$ V1: int [1:7352] 5 5 5 5 5 5 5 5 5 5 ...
```

#### Subject: subject_train.txt - that performed an Activity: 1 - 30
```
train.data.list[1]
head(train.data.list[[1]], 1)
tail(train.data.list[[1]], 1)
```

#### Training set: X_train.txt - 561 columns - see features.txt for column names
```
train.data.list[2]
head(train.data.list[[2]])
tail(train.data.list[[2]])
unique(train.data.list[[2]])
```

#### Training labels/ Activity Codes: y_train.txt - activity name: 1 - 6
```
train.data.list[3]
head(train.data.list[[3]])
tail(train.data.list[[3]])
unique(train.data.list[[3]])
```

### train data list data frame
#### Subject
```
train.data.list.su.df <- as.data.frame(train.data.list[1])
train.data.list.su.df
```

#### Activity ID
```
train.data.list.ac.df <- as.data.frame(train.data.list[3])
train.data.list.ac.df
```

#### Training set
```
train.data.list.df <- as.data.frame(train.data.list[2])
is.data.frame(train.data.list.df)

## [1] TRUE

str(train.data.list.df)
## 'data.frame':  7352 obs. of  561 variables:
## $ V1  : num  0.289 0.278 0.28 0.279 0.277 ...
## $ V2  : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
## $ V98 : num  -1 -1 -1 -1 -1 ...
## $ V99 : num  -1 -1 -1 -1 -1 ...
## [list output truncated]
```

```
names(train.data.list.df)

head(train.data.list.df, 1)
tail(train.data.list.df, 1)
train.data.list.df[1,]
train.data.list.df[2,]
train.data.list.df[,1]
train.data.list.df[,561]
```

#### Columns of interest
```
train.data.list.su.df$V1 # subject_train.txt _ subjectID
train.data.list.df[1:561] # X_train.txt - first column - tBodyAcc-mean()-X
train.data.list.ac.df$V1 # y_train,txt - activityID
```

#### train set - Features and Activities data
```
source("003-getting-cleaning-data/003-projdata-features-tidy.R")

featureData <- read.csv(
  "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/features.csv",
  header = TRUE, sep = ",", stringsAsFactors = FALSE)

str(featureData)
## 'data.frame':  561 obs. of  4 variables:
##  $ domain     : chr  "t" "t" "t" "t" ...
##  $ signal     : chr  "BodyAcc" "BodyAcc" "BodyAcc" "BodyAcc" ...
##  $ measurement: chr  "mean" "mean" "mean" "std" ...
##  $ direction  : chr  "X" "Y" "Z" "X" ...

featureData
head(featureData, 10)
tail(featureData, 10)
```

```
names(featureData)
## [1] "domain"      "signal"      "measurement" "direction"
```

#### feature - columns - mean
```
featureData[featureData$measurement == "mean",]

# grep("mean", featureData$measurement)
# length(grep("mean", featureData$measurement))
## [1] 46
# featureData$measurement[c(294,295,296,373,374,375,452,453,454,513,526,539,552)]

subset(featureData, featureData$measurement %in% "mean")
which(featureData$measurement == "mean")
length(which(featureData$measurement == "mean"))
## [1] 33

mn <- subset(featureData, measurement == "mean" ,
             select = c(domain, signal, measurement, direction))
mn
mn <- cbind(mnID = as.integer(rownames(mn)), mn)
str(mn)

paste(mn$domain, mn$signal, sep = "")
paste(mn$domain, mn$signal, mn$measurement, mn$direction, sep = "_")

mn.names <- paste(mn$domain, mn$signal, mn$measurement, mn$direction, sep = "_")
mn.names <- gsub("mean_", "mean", mn.names)
mn.names
```

### feature - columns - std
```
subset(featureData, featureData$measurement %in% "std")
featureData[featureData$measurement == "std",]
grep("std", featureData$measurement)
length(grep("std", featureData$measurement))
## [1] 33
length(which(featureData$measurement == "std"))
## [1] 33

st <- subset(featureData, measurement == "std" ,
             c(domain, signal, measurement, direction))
st <- cbind(stID = as.integer(rownames(st)), st)
str(st)

paste(st$domain,st$signal, sep = "")
paste(st$domain,st$signal,st$measurement, sep = "_")

st.names <- paste(st$domain,st$signal,st$measurement, st$direction, sep = "_")
st.names <- gsub("std_", "std", st.names)
st.names
```

### Subsetting/extracting training set df - mean, std, subject
#### subject - column
```
names(train.data.list.su.df)
train.data.list.su.df$V1
train.data.list.su.df[1]
names(train.data.list.su.df)[1]
names(train.data.list.su.df)[1] <- "subjectID"
names(train.data.list.su.df)[1]
train.data.list.su.df
str(train.data.list.su.df)
## 'data.frame':  7352 obs. of  1 variable:
## $ subjectID: int  1 1 1 1 1 1 1 1 1 1 ...
```

#### activityID - column
```
train.data.list.ac.df$V1

train.data.list.ac.df[1]
names(train.data.list.ac.df)[1]
names(train.data.list.ac.df)[1] <- "activityID"
names(train.data.list.ac.df)
```
#### train set column names
```
featureData
str(mn)
mn$mnID
st$stID
```

#### mean - columns
```
mn.names
c(mn.names)
str(mn.names)

train.data.list.df
names(train.data.list.df)
names(train.data.list.df)[mn$mnID] <- c(mn.names)
names(train.data.list.df)
head(train.data.list.df[1]) # wrong column name
```

#### std columns
```
st.names

train.data.list.df
names(train.data.list.df)
names(train.data.list.df)[st$stID] <- c(st.names)
names(train.data.list.df)
head(train.data.list.df[1]) # wrong column name
head(train.data.list.df[2])
```

###### Train set data frames
```
train.data.list.su.df
train.data.list.su.df
train.data.list.df

head(train.data.list.df)
mn$mnID
st$stID

mn.st <- c(mn$mnID, st$stID)
mn.st
length(mn.st)
train.data.list.df[c(mn.st)]
head(train.data.list.df[c(mn.st)], 1)
length(head(train.data.list.df[c(mn.st)], 1))
```

##### train set mean and std
```
train.dl.mn.st.df <- train.data.list.df[c(mn.st)]
str(train.dl.mn.st.df)
## 'data.frame':  7352 obs. of  66 variables:
##  $ t_BodyAcc_meanX       : num  0.289 0.278 0.28 0.279 0.277 ...
##  $ t_BodyAcc_meanY       : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
##  $ t_BodyAcc_meanZ       : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
head(train.dl.mn.st.df, 1)
names(train.dl.mn.st.df)
```

### train - Activity labels
#### gsub(pattern, replacement, x, ignore.case = FALSE, perl = FALSE,
#### fixed = FALSE, useBytes = FALSE)
```
activityFile <- read.table(
  "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/activity_labels.txt")
activityData <- data.frame(activityID = c(1:6), activity = gsub("_", " ", activityFile$V2))
activityData
str(activityData)

train.data.list.df
```

### train Activity code and names
##### activity columns from activityID
```
train.data.list.ac.df$V1
train.data.list.ac.df$activityID
activityData$activityID

activity.train <- data.frame(activity = train.data.list.ac.df$activityID)
activity.train
names(activity.train)
activity.train$activity

###
actID.from <- activityData$activityID
actID.from
actID.to <- activityData$activity
actID.to

actIDsubt <- function(pattern, replacement, x, ...) {
  for(i in 1:length(pattern))
    x <- gsub(pattern[i], replacement[i], x, ...)
    x
}

activity.train$activity <- actIDsubt(actID.from, actID.to, activity.train$activity)

activity.train
str(activity.train)
## 'data.frame':  7352 obs. of  1 variable:
##  $ activity: chr  "STANDING" "STANDING" "STANDING" "STANDING" ...
```

#### train set subject ID, activity, mean and std
```
activity.train
str(activity.train)

train.dl.mn.st.suac.df <- data.frame(
  subjectID = train.data.list.su.df$subjectID,
  data_set = rep("training", 7352),
  activity = activity.train$activity,
  train.dl.mn.st.df[1:66])

train.dl.mn.st.suac.df
head(train.dl.mn.st.suac.df, 1)
names(train.dl.mn.st.suac.df)
str(train.dl.mn.st.suac.df)
## 'data.frame':  7352 obs. of  69 variables:
##  $ subjectID              : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ data_set              : chr  "training" "training" "training" "training" ...
##  $ activity              : chr  "STANDING" "STANDING" "STANDING" "STANDING" ...
##  $ t_BodyAcc_meanX       : num  0.289 0.278 0.28 0.279 0.277 ...
##  $ t_BodyAcc_meanY       : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
##  $ t_BodyAcc_meanZ       : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
```

## Path to test data
```
test.data.path <-
  list.files("/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/test",
             pattern = ".txt", full.names = TRUE)

test.data.path
## [1] "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/test/X_test.txt"
## [2] "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/test/subject_test.txt"
## [3] "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/test/y_test.txt"
```

#### test data path list
```
test.data.list <- lapply(test.data.path, read.table)
class(test.data.list)
## [1] "list"
str(test.data.list)

## Test set: 561 columns - see features.txt
## List of 3
## $ :'data.frame':  2947 obs. of  1 variable:
##   ..$ V1: int [1:2947] 2 2 2 2 2 2 2 2 2 2 ...
## $ :'data.frame':  2947 obs. of  561 variables:
##   ..$ V1  : num [1:2947] 0.257 0.286 0.275 0.27 0.275 ...
## ..$ V99 : num [1:2947] -0.997 -0.999 -0.999 -0.999 -1 ...
## .. [list output truncated]
## $ :'data.frame':  2947 obs. of  1 variable:
##   ..$ V1: int [1:2947] 5 5 5 5 5 5 5 5 5 5 ...
```

#### Subject: that performed an Activity: 1 - 30 - subjectID
```
test.data.list[1]
test.data.list[[1]][1]
head(test.data.list[[1]], 1)
tail(test.data.list[[1]], 1)
```

#### test set
```
test.data.list[2]
head(test.data.list[[2]])
tail(test.data.list[[2]])
unique(test.data.list[[2]])
```

#### testing labels: - activity name: 1 - 6 - activityID
```
test.data.list[3]
head(test.data.list[[3]])
tail(test.data.list[[3]])
unique(test.data.list[[3]])
```

#### Columns of interest
```
test.data.list[[1]] # list 1 - subjectID
test.data.list[[3]] # list 3 - activityID
```

### test data list data frame
#### test Subject
```
test.data.list.su.df <- as.data.frame(test.data.list[1])
test.data.list.su.df
```

#### test activity code
```
test.data.list.ac.df <- as.data.frame(test.data.list[3])
test.data.list.ac.df
```

#### test set
```
test.data.list.df <- as.data.frame(test.data.list[2])
str(test.data.list.df)
## 'data.frame':  2947 obs. of  561 variables:
## $ V1  : num  0.257 0.286 0.275 0.27 0.275 ...
## $ V2  : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
## $ V98 : num  -0.997 -0.999 -0.999 -0.999 -1 ...
## $ V99 : num  -0.997 -0.999 -0.999 -0.999 -1 ...
## [list output truncated]

names(test.data.list.df)

head(test.data.list.df, 1)
tail(test.data.list.df, 1)
test.data.list.df[1,]
test.data.list.df[2,]
test.data.list.df[,1]
test.data.list.df[,561]

test.data.list.su.df$V1
test.data.list.ac.df$V1

test.data.list.df
```

#### test set - Features and Activities data
```
str(featureData)
## 'data.frame':  561 obs. of  4 variables:
##  $ domain     : chr  "t" "t" "t" "t" ...
##  $ signal     : chr  "BodyAcc" "BodyAcc" "BodyAcc" "BodyAcc" ...
##  $ measurement: chr  "mean" "mean" "mean" "std" ...
##  $ direction  : chr  "X" "Y" "Z" "X" ...

featureData
head(featureData, 10)
tail(featureData, 10)

names(featureData)
## [1] "domain"      "signal"      "measurement" "direction"

### feature - columns - mean
featureData[featureData$measurement == "mean",]

subset(featureData, featureData$measurement %in% "mean")
which(featureData$measurement == "mean")
length(which(featureData$measurement == "mean"))
## [1] 33

mn <- subset(featureData, measurement == "mean" ,
             select = c(domain, signal, measurement, direction))
mn
mn <- cbind(mnID = as.integer(rownames(mn)), mn)
str(mn)

paste(mn$domain, mn$signal, sep = "")
paste(mn$domain, mn$signal, mn$measurement, mn$direction, sep = "_")

mn.names <- paste(mn$domain, mn$signal, mn$measurement, mn$direction, sep = "_")
mn.names <- gsub("mean_", "mean", mn.names)
mn.names
```

#### feature - columns - std
```
subset(featureData, featureData$measurement %in% "std")
featureData[featureData$measurement == "std",]
grep("std", featureData$measurement)
length(grep("std", featureData$measurement))
## [1] 33
length(which(featureData$measurement == "std"))
## [1] 33

st <- subset(featureData, measurement == "std" ,
             c(domain, signal, measurement, direction))
st <- cbind(stID = as.integer(rownames(st)), st)
str(st)

paste(st$domain,st$signal, sep = "")
paste(st$domain,st$signal,st$measurement, sep = "_")

st.names <- paste(st$domain,st$signal,st$measurement, st$direction, sep = "_")
st.names <- gsub("std_", "std", st.names)
st.names
```

### Subsetting/extracting test set df - mean, std, subject
#### subject - column
```
names(test.data.list.su.df)
test.data.list.su.df$V1
test.data.list.su.df[1]
names(test.data.list.su.df)[1]
names(test.data.list.su.df)[1] <- "subjectID"
names(test.data.list.su.df)[1]
test.data.list.su.df
str(test.data.list.su.df)
## 'data.frame':  2947 obs. of  1 variable:
##  $ subjectID: int  2 2 2 2 2 2 2 2 2 2 ...
```

#### activityID - column
```
test.data.list.ac.df$V1

test.data.list.ac.df[1]
names(test.data.list.ac.df)[1]
names(test.data.list.ac.df)[1] <- "activityID"
names(test.data.list.ac.df)
```

#### test set column names
```
featureData
str(mn)
mn$mnID
st$stID
```

#### mean - columns
```
mn.names
c(mn.names)
str(mn.names)

test.data.list.df
names(test.data.list.df)
names(test.data.list.df)[mn$mnID] <- c(mn.names)
names(test.data.list.df)
head(test.data.list.df[1]) # wrong column name
```

#### std columns
```
st.names

test.data.list.df
names(test.data.list.df)
names(test.data.list.df)[st$stID] <- c(st.names)
names(test.data.list.df)
head(test.data.list.df[1]) # wrong column name
head(test.data.list.df[2])
```

#### test set data frames
```
test.data.list.su.df
test.data.list.su.df
test.data.list.df

head(test.data.list.df)
mn$mnID
st$stID

mn.st <- c(mn$mnID, st$stID)
mn.st
length(mn.st)
test.data.list.df[c(mn.st)]
head(test.data.list.df[c(mn.st)], 1)
length(head(test.data.list.df[c(mn.st)], 1))
```

#### test set mean and std
```
test.dl.mn.st.df <- test.data.list.df[c(mn.st)]
str(test.dl.mn.st.df)
## 'data.frame':  2947 obs. of  66 variables:
##  $ t_BodyAcc_meanX       : num  0.257 0.286 0.275 0.27 0.275 ...
##  $ t_BodyAcc_meanY       : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
##  $ t_BodyAcc_meanZ       : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
head(test.dl.mn.st.df, 1)
names(test.dl.mn.st.df)
length(test.dl.mn.st.df)
## [1] 66
```

#### test - Activity labels
```
activityFile <- read.table(
  "/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/activity_labels.txt")
activityData <- data.frame(activityID = c(1:6), activity = gsub("_", " ", activityFile$V2))
activityData
str(activityData)

test.data.list.df
```

### test Activity code and names
#### activity columns from activityID
```
test.data.list.ac.df$V1
test.data.list.ac.df$activityID
activityData$activityID

activity.test <- data.frame(activity = test.data.list.ac.df$activityID)
activity.test
names(activity.test)
activity.test$activity

###
actID.from <- activityData$activityID
actID.from
actID.to <- activityData$activity
actID.to

actIDsubt <- function(pattern, replacement, x, ...) {
  for(i in 1:length(pattern))
    x <- gsub(pattern[i], replacement[i], x, ...)
    x
}

activity.test$activity <- actIDsubt(actID.from, actID.to, activity.test$activity)

activity.test
str(activity.test)
## 'data.frame':  2947 obs. of  1 variable:
## $ activity: chr  "STANDING" "STANDING" "STANDING" "STANDING" ...
```

#### test set subject ID, activity, mean and std
```
test.dl.mn.st.suac.df <- data.frame(
  subjectID = test.data.list.su.df$subjectID,
  data_set = rep("test", 2947),
  activity = activity.test$activity,
  test.dl.mn.st.df[1:66])

test.dl.mn.st.suac.df
head(test.dl.mn.st.suac.df, 1)
names(test.dl.mn.st.suac.df)
str(test.dl.mn.st.suac.df)
## 'data.frame':  2947 obs. of  69 variables:
##  $ subjectID              : int  2 2 2 2 2 2 2 2 2 2 ...
##  $ data_set              : chr  "test" "test" "test" "test" ...
##  $ activity              : chr  "STANDING" "STANDING" "STANDING" "STANDING" ...
##  $ t_BodyAcc_meanX       : num  0.257 0.286 0.275 0.27 0.275 ...
##  $ t_BodyAcc_meanY       : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
## $ t_BodyAcc_meanZ       : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
```

## Putting them together
#### train and test subject ID, activity ID, mean and sts data frames
#### with column names
```
train.dl.mn.st.suac.df
test.dl.mn.st.suac.df

train.df <- train.dl.mn.st.suac.df
is.data.frame(train.df)
## [1] TRUE
class(train.df)
sapply(train.df, class)

test.df <- test.dl.mn.st.suac.df
is.data.frame(test.df)
## [1] TRUE
class(train.df)
sapply(train.df, class)

identical(train.df, test.df)
## [1] FALSE
```


#### rbind()
```
train.test.rbdf <- rbind(train.df, test.df)
str(train.test.rbdf)
## 'data.frame':  10299 obs. of  68 variables:
##  $ subjectID              : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ activity              : chr  "STANDING" "STANDING" "STANDING" "STANDING" ...
##  $ t_BodyAcc_meanX       : num  0.289 0.278 0.28 0.279 0.277 ...
##  $ t_BodyAcc_meanY       : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
##  $ t_BodyAcc_meanZ       : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...

7352 + 2947
## [1] 10299

names(train.test.rbdf)
describe(train.test.rbdf)
head(train.test.rbdf[c(1:4,69)])
##   subjectID data_set activity t_BodyAcc_meanX f_BodyGyroJerkMag_std
## 1         1 training STANDING       0.2885845            -0.9906975
## 2         1 training STANDING       0.2784188            -0.9963995
## 3         1 training STANDING       0.2796531            -0.9951274
## 4         1 training STANDING       0.2791739            -0.9952369
## 5         1 training STANDING       0.2766288            -0.9954648
## 6         1 training STANDING       0.2771988            -0.9952387
```

### Tidy data
```
getwd()
write.table(train.test.rbdf, "003-projdata/train-test.csv",
            quote = FALSE, sep = ",", col.names = TRUE, row.name = FALSE)
```
