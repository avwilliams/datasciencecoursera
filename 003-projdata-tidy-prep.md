# Tidy Data prep - Exploration

## Data structure
data in wide format

Column headers are values, not variable names

## Data elements/values composition

### TIME
Accelerometer (tAcc) and Gyroscope (tGyro)

Body tBodyAcc and Gravity (tGravityAcc)

Linear Acceleration (tBodyAccJerk) and Angular Velocity (tBodyGyroJerk)

#### Directions
3-axial X Y Z

Magnitude using Euclidean norm

### Signals
tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag

### Fast Fourier Transform

fBodyAcc, fBodyAccJerk, fBodyGyro,

### Directions
3-axial X Y Z

### Signals
fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag

fBodyAcc-bandsEnergy

### Additionals signals
gravityMean, tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean, tBodyGyroJerkMean

## Prospective t Column Names
#### Subjects:
1 -30

#### Acctivity: 
1 - 6, WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

#### prefix: 
t

#### Signals:
tBodyAcc, tBodyGravityAcc, tBodyAccJerk, tBodyGyro, tBodyGyroJerk

tBodyAccMag, tBodyGravityMag, tBodyAccJerkMag

tBodyGyroMag, tBodyGyroJerkMag

#### Measurement/Variable:
mean, sta, mad, max, min, sma, energy, iqr, entropy, arCoeff

#### Direction:
X, Y, Z

X,1 X,2 X,3 X,4

Y,1 Y,2 Y,3 Y,4

Z,1 Z,2 Z,3 Z,4

X,Y X,Z Y,Z

1, 2, 3, 4

## Prospective f Column Names
#### Subjects:
1 -30

#### Acctivity:
1 - 6, WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

#### prefix:
f

#### Signals:
fBodyAcc, fBody-bandEnergy, fBodyAccJerk, fBodyAccJerk-bandEnergy, fBodyGyro,

fBodyGyro-bandEnergy, fBodyAccMag, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag

#### Measurement/Variable:
mean, std, mad, max, min, sma, energy, iqr, entropy, maxInds, meanFreq, skewness, kurtosis, bandsEnergy

Direction:
X, Y, Z

X

X

Y

Y

Z

Z

1,8 9,16 17,24 25,32 33,40 41,48 49,56 57,64

1,16 17,32 33,48 49,64

1,24 25,48

### Angle
#### Subjects:
1 -30

#### Acctivity:
1 - 6, WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

#### prefix:
a

#### Signals:
angle(tBodyAccMean,gravity)

angle(tBodyAccJerkMean,gravityMean)

angle(tBodyGyroMean,gravityMean)

angle(tBodyJerkMean,gravityMean)

angle(X, gravityMean)

angle(Y, gravityMean)

angle(Z, gravityMean)

tBodyAccMean,gravity

tBodyAccJerkMean,gravityMean

tBodyGyroMean,gravityMean

tBodyJerkMean,gravityMean

gravityMean

gravityMean

gravityMean

#### Measurement/Variable:
angle

#### Direction:
X

Y

Z
