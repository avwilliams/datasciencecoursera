# Inspect 003 Project Data

The following files are available for the train and test data.

Their descriptions are equivalent.

### train/subject_train.txt':
Each row identifies the subject who performed the activity for each window sample.

Its range is from 1 to 30.

### Notes:
======

- Features are normalized and bounded within [-1,1].

- Each feature vector is a row on the text file.

# Data
### train
 - 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

#### To see rows
Since the rows of data are very long, -N option of the system command
less to view where lines of data begin and end.

```
less -N
```

#### Features
```
wc -l features.txt
561 features.txt
```

#### Training set
```
less -N train/X_train.txt
```

#### Training labels
```
less -N train/X_train.txt
```

#### Brief Explaination
Contains code for activity labels by rows, 1 - 6 and repeats

#### Subjects code numbers
```
less -N train/subject_train.txt
```

#### number of rows - nrow
```
wc -l train/X_train.txt
7352 train/X_train.txt

wc -l train/y_train.txt
7352 train/y_train.txt

wc -l train/subject_train.txt
7352 train/subject_train.txt

wc -l train/'Inertial Signals'/body_acc_x_train.txt
7352 train/Inertial Signals/body_acc_x_train.txt
```

### Number of columns, assuming tab separated file - ncol
```
awk -F" " '{print NF; exit}' train/X_train.txt
561

awk -F" " '{print NF; exit}' train/y_train.txt
1

awk -F" " '{print NF; exit}' train/subject_train.txt
1
```

#### Read line 1 or check for headers
```
awk 'NR == 1' train/X_train.txt | less -N
```

#### test set data files
- 'test/X_test.txt': Test set.
```
less -N ../test/X_test.txt
```

- 'test/y_test.txt': Test labels.
```
less -N ../test/y_test.txt
```

#### Brief Explaination
Contains code for activity labels by rows, 1 - 6 and repeats

#### number of rows - nrow
```
wc -l test/X_test.txt
2947 test/X_test.txt

wc -l test/y_test.txt
2947 test/y_test.tx

wc -l test/subject_test.txt
2947 test/subject_test.txt
```

### Number of columns, assuming tab separated file - ncol
```
awk -F" " '{print NF; exit}' test/X_test.txt
561

awk -F" " '{print NF; exit}' test/y_test.txt
1

awk -F" " '{print NF; exit}' test/subject_test.txt
```

### Read line 1 or check for headers
```
awk 'NR == 1' test/X_test.txt | less -N
```

### Optional Data
#### Inertial Signal files
```
cat -An train/'Inertial Signals'/body_acc_x_train.txt | less

wc -l train/'Inertial Signals'/*.txt
     7352 train/Inertial Signals/body_acc_x_train.txt
     7352 train/Inertial Signals/body_acc_y_train.txt
     7352 train/Inertial Signals/body_acc_z_train.txt
     7352 train/Inertial Signals/body_gyro_x_train.txt
     7352 train/Inertial Signals/body_gyro_y_train.txt
     7352 train/Inertial Signals/body_gyro_z_train.txt
     7352 train/Inertial Signals/total_acc_x_train.txt
     7352 train/Inertial Signals/total_acc_y_train.txt
     7352 train/Inertial Signals/total_acc_z_train.txt
```
```
cat -An test/'Inertial Signals'/body_acc_x_test.txt | less

wc -l test/'Inertial Signals'/*.txt
    2947 test/Inertial Signals/body_acc_x_test.txt
    2947 test/Inertial Signals/body_acc_y_test.txt
    2947 test/Inertial Signals/body_acc_z_test.txt
    2947 test/Inertial Signals/body_gyro_x_test.txt
    2947 test/Inertial Signals/body_gyro_y_test.txt
    2947 test/Inertial Signals/body_gyro_z_test.txt
    2947 test/Inertial Signals/total_acc_x_test.txt
    2947 test/Inertial Signals/total_acc_y_test.txt
    2947 test/Inertial Signals/total_acc_z_test.txt
   26523 total
```

