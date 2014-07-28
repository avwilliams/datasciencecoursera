# Getting and Cleaning Data Week 3 Project

## Project Description
You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. Creates a second, independent tidy data set with the average of each variable
for each activity and each subject.

#### With the above requirement my object were to:

1. First, inspect the data with GNU/Linux command line tools

 [See 003-projdata-inspect.md](https://github.com/avwilliams/datasciencecoursera/blob/master/003-projdata-inspect.md)

2. Tidy data preparation and explore the data and it's information files in R/Rstudio

 [See 003-projdata-tidy-prep.md](https://github.com/avwilliams/datasciencecoursera/blob/master/003-projdata-tidy-prep.md)

3. Extract and merge required data variable

4. Extract data for column names to rename variables

5. Add additional columns and data to make data and results identifiable.

 [See 003-projdata-tidy-prep.md](https://github.com/avwilliams/datasciencecoursera/blob/master/003-projdata-tidy-prep.md)

6. tidy data

### Project Files
[Data Inspection](https://github.com/avwilliams/datasciencecoursera/blob/master/003-projdata-inspect.md)

[Data Exploration](https://github.com/avwilliams/datasciencecoursera/blob/master/003-projdata-tidy-prep.md)

[Project](https://github.com/avwilliams/datasciencecoursera/blob/master/003-project-final.md)

[Code Book](https://github.com/avwilliams/datasciencecoursera/blob/master/003-project-code-book.md)
[Code](https://github.com/avwilliams/datasciencecoursera/blob/master/run_analysis.R)


### Note
Time permitting to meet the deadline, i did accomplished most but not all of the task.

Per the dead line i got up to a semi tidy data frame of the train and test data set

#### Not accomplished yet:
Column with with actual activities

#### Additional Column and data for subsetting data:
prefix
measurement/variable

direction

#### Finally:
melt or ddply the merged train/test set data frame to make it long instead of wide.

### Notes
I did try to melt and ddply my current merged data frame, but my laptop can't seem
to handle it. It is currently frozen and i may have to warm boot it to make it usable
again.

There is an issue with RStudio, when i tell it to stop processing, it prompts me to
kill the R session. I tell it yes but it does not kill the rsession.

### Update
