
# Brief About Data

The data set relevant for this code book  is located in the tidy_data.txt file of this repository. For more background information about the data set please refer the README.md. 

The tidy_data.txt contains 563 variables and 180 observations. As observations the individual 30 participants are considered while variables are different test parameters, which are explained below. 

The tidy_data.txt data file is a text file, containing space-separated values.
The first row contains the names of the variables, which are listed and described in the Variables section, and the following rows contain the values of these variables.

# Variables

## Identifiers
 * Subject
   -Subject identifier, integer, ranges from 1 to 30.

* Activity
   -Activity identifier, string with 6 possible values:
       * WALKING: subject was walking
       * WALKING_UPSTAIRS: subject was walking upstairs
       * WALKING_DOWNSTAIRS: subject was walking downstairs
       * SITTING: subject was sitting
       * STANDING: subject was standing
       * LAYING: subject was laying

## Average of Measurements
 
 All measurements are floating-point values, normalised and bounded within [-1,1].

Prior to normalisation, acceleration measurements (variables containing Accelerometer) were made in g's (9.81 m.s^2^) and gyroscope measurements (variables containing Gyroscope) were made in radians per second (rad.s^-1^).

Magnitudes of three-dimensional signals (variables containing Magnitude) were calculated using the Euclidean norm.

The measurements are classified in two domains:

   * Time-domain signals (variables prefixed by timeDomain), resulting from the capture of accelerometer and       gyroscope raw signals.

   * Frequency-domain signals (variables prefixed by frequencyDomain), resulting from the application of a         Fast Fourier Transform (FFT) to some of the time-domain signals.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals timeAccelerator-XYZ and timeGyroscop-XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (timeBodyAcceleratorJerk-XYZ and timeBodyGyroscopJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (timeBodyAccerleratorMagnitiude, timeGravityAccerleratorMagnitiude, timeBodyAccerleratorJerkMagnitiude, timeBodyGyroscopMagitiude, timeBodyGyroscopeJerkMagnitiude). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing frequencyBodyAccerlerator-XYZ, frequencyBodyAccerleratorJerk-XYZ, frequencyBodyGyroscop-XYZ, frequencyBodyAcceleratorJerkMagnitiude, frequencyBodyGyroscopMagnitiude, frequencyBodyGyroscopJerkMagnitiude. 


The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Variables of the dataset is as follows. 



## Transformations

The zip file containing the source data is located at <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.>

The following transformations were applied to the source data:

 * The data set was read as a table and column names of test sets & trainings were changed using the features     data set.
 * New columns were introduced to test and train data sets with the list of activities and participants.
 * The training and test sets were merged(row binded) to create one data set.
 * The measurements on the mean and standard deviation (i.e. signals containing the strings mean and std) were      extracted for each measurement, and the others were discarded.
 * The activity identifiers (originally coded as integers between 1 and 6) were replaced with descriptive         activity names. 
 * The variable names were replaced with descriptive variable names (e.g. tBodyAcc-mean()-X was expanded to       timeDomainBodyAccelerometerMeanX), using the following set of rules:
 * Special characters (i.e. (, ), and -) were removed.
 * The initial f and t were expanded to frequencyDomain and timeDomain respectively.
 * Acc, Gyro, Mag, Freq, mean, and std were replaced with Accelerometer, Gyroscope, Magnitude, Frequency,         Mean, and StandardDeviation respectively.
 * From the data set in step 4, the final data set was created with the average of each variable for each        activity and each subject.
 * The collection of the source data and the transformations listed above were implemented by the                 run_analysis.R R script.
