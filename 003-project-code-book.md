# 003 Project Code Book

## Data and list files
train.data.path: Path to training set data.

train.data.list: Training set list of files.

test.data.path: Path to test set data.

test.data.list: Test set list of files.

## Features and Activities
featureData: Features file as data.

activityData: Activites file as data.

## Data frames and lists

#### training set
train.data.list.df: train set data list of 3 data frame.

train.data.list.su.df: training set Subject colunm.

train.data.list.ac.df: training set Activity colunm.

train.data.list.df: training set columns

#### test set
test.data.list.df: test set data list of 3 data frame.

test.data.list.su.df: testing set Subject colunm.

test.data.list.ac.df: testing set Activity colunm.

test.data.list.df: test set columns

## Subsets features mean and std
##### mean
mn : feature data for mean

mn.names: column names of for feature data for mean

#### std
st : feature data for std

st.names: column names of for feature data for st

mn.st: column numbers for mean and std

train.dl.mn.st.df: training set columns name for mean and std

test.dl.mn.st.df: test set columns name for mean and std

#### activity
activity.train: mathing training activities with activity ids

actID.from: from activityID

actID.to: to and activity

actIDsubt: matching function

train.dl.mn.st.suac.df: training set subjectID, activity, data_set, mean and std data frame.

test.dl.mn.st.suac.df: test set subjectID, activity, data_set, mean and std data frame.

## Putting them together
train.test.rbdf: train and test data frames rbind together

## Columns and Column Names - prefix - body - suffix

#### subject ids
subjectID

1 - 30

#### activities
activity

WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING

#### source data set
data_set

train, test

#### domain
t: Time

f: Frequency

#### accelerometer and gyroscope 3-axial raw signals

Acc: acceleration

Gyro: gyroscope

Jerk: acceleration and angular velocity were derived in time to obtain Jerk signal.

Mag: magnitude of these three-dimensional signals were calculated using the Euclidean norm

#### measurements
mean(): Mean value

std(): Standard deviation

#### directions
X

Y

Z

#### column names
1.               subjectID
2.                data_set
3.                activity
4.        t_BodyAcc_meanX
5.         t_BodyAcc_meanY
6.         t_BodyAcc_meanZ
7.      t_GravityAcc_meanX
8.      t_GravityAcc_meanY
9.      t_GravityAcc_meanZ
10.    t_BodyAccJerk_meanX
11.    t_BodyAccJerk_meanY
12.    t_BodyAccJerk_meanZ
13.       t_BodyGyro_meanX
14.       t_BodyGyro_meanY
15.       t_BodyGyro_meanZ
16.   t_BodyGyroJerk_meanX
17.   t_BodyGyroJerk_meanY
18.   t_BodyGyroJerk_meanZ
19.      t_BodyAccMag_mean
20.   t_GravityAccMag_mean
21.  t_BodyAccJerkMag_mean
22.     t_BodyGyroMag_mean
23. t_BodyGyroJerkMag_mean
24.        f_BodyAcc_meanX
25.        f_BodyAcc_meanY
26.        f_BodyAcc_meanZ
27.    f_BodyAccJerk_meanX
28.    f_BodyAccJerk_meanY
29.    f_BodyAccJerk_meanZ
30.       f_BodyGyro_meanX
31.       f_BodyGyro_meanY
32.       f_BodyGyro_meanZ
33.      f_BodyAccMag_mean
34.  f_BodyAccJerkMag_mean
35.     f_BodyGyroMag_mean
36. f_BodyGyroJerkMag_mean
37.         t_BodyAcc_stdX
38.         t_BodyAcc_stdY
39.         t_BodyAcc_stdZ
40.      t_GravityAcc_stdX
41.      t_GravityAcc_stdY
42.      t_GravityAcc_stdZ
43.     t_BodyAccJerk_stdX
44.     t_BodyAccJerk_stdY
45.     t_BodyAccJerk_stdZ
46.        t_BodyGyro_stdX
47.        t_BodyGyro_stdY
48.        t_BodyGyro_stdZ
49.    t_BodyGyroJerk_stdX
50.    t_BodyGyroJerk_stdY
51.    t_BodyGyroJerk_stdZ
52.       t_BodyAccMag_std
53.    t_GravityAccMag_std
54.   t_BodyAccJerkMag_std
55.      t_BodyGyroMag_std
56.  t_BodyGyroJerkMag_std
57.         f_BodyAcc_stdX
58.         f_BodyAcc_stdY
59.         f_BodyAcc_stdZ
60.     f_BodyAccJerk_stdX
61.     f_BodyAccJerk_stdY
62.     f_BodyAccJerk_stdZ
63.        f_BodyGyro_stdX
64.        f_BodyGyro_stdY
65.        f_BodyGyro_stdZ
66.       f_BodyAccMag_std
67.   f_BodyAccJerkMag_std
68.      f_BodyGyroMag_std
69.  f_BodyGyroJerkMag_std
