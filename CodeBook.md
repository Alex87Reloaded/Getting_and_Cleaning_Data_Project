Code Book
========

This code book summarizes the resulting data fields in Tidy.txt.

### Raw data collection

Raw data are obtained from UCI Machine Learning repository.

------------------------------------------------------------------
Human Activity Recognition Using Smartphones Dataset
Version 1.0
------------------------------------------------------------------

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

### Signals

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The set of variables that were estimated from these signals are: 

*  mean(): Mean value
*  std(): Standard deviation
*  mad(): Median absolute deviation 
*  max(): Largest value in array
*  min(): Smallest value in array
*  sma(): Signal magnitude area
*  energy(): Energy measure. Sum of the squares divided by the number of values. 
*  iqr(): Interquartile range 
*  entropy(): Signal entropy
*  arCoeff(): Autoregression coefficients with Burg order equal to 4
*  correlation(): Correlation coefficient between two signals
*  maxInds(): Index of the frequency component with largest magnitude
*  meanFreq(): Weighted average of the frequency components to obtain a mean frequency
*  skewness(): Skewness of the frequency domain signal 
*  kurtosis(): Kurtosis of the frequency domain signal 
*  bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT
   of each window.
*  angle(): Angle between some vectors.

Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

Data transformation
-------------------

The raw data sets are processed with run_analisys.R script to create a tidy data
set following the next steps:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### 1. Merges the training and the test sets to create one data set.

Test and training data (X_train.txt, X_test.txt), subject ids (subject_train.txt,
subject_test.txt) and activity ids (y_train.txt, y_test.txt) are merged to obtain
a single data set. Variables are labelled with the names assigned by original
collectors (features.txt).

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

From the merged data set is extracted and intermediate data set with only the
values of estimated mean (variables with labels that contain "mean") and standard
deviation (variables with labels that contain "std").

### 3. Uses descriptive activity names to name the activities in the data set.

A new column is added to intermediate data set with the activity description.
Activity id column is used to look up descriptions in activity_labels.txt.

### 4. Appropriately labels the data set with descriptive variable names.

Labels given from the original collectors were changed:
* to obtain valid R names without parentheses, dashes and commas
* to obtain more descriptive labels

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

From the intermediate data set is created a final tidy data set where numeric
variables are averaged for each activity and each subject.

Tidy Data Set
-------------------

The tidy data set contains 10299 observations with 81 variables divided in:

*  an activity label (Activity): WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
*  an identifier of the subject who carried out the experiment (Subject):
   1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, 30
*  a 79-feature vector with time and frequency domain signal variables (numeric)

The following tables relates the 17 signals to the names used as prefix for the
variables names present in the data set.

Name                                  
------------------------------------- 
Body Acceleration                     
Gravity Acceleration                  
Body Acceleration Jerk                
Body Angular Speed                   
Body Angular Acceleration            
Body Acceleration Magnitude          
Gravity Acceleration Magnitude        
Body Acceleration Jerk Magnitude      
Body Angular Speed Magnitude         
Body Angular Acceleration Magnitude   

Time domain                                                                 
------------------------------------- 
TimeDomain.BodyAcceleration.XYZ             
TimeDomain.GravityAcceleration.XYZ          
imeDomain.BodyAccelerationJerk.XYZ         
TimeDomain.BodyAngularSpeed.XYZ             
TimeDomain.BodyAngularAcceleration.XYZ      
TimeDomain.BodyAccelerationMagnitude        
TimeDomain.GravityAccelerationMagnitude     
TimeDomain.BodyAccelerationJerkMagnitude    
TimeDomain.BodyAngularSpeedMagnitude        
TimeDomain.BodyAngularAccelerationMagnitude 

Frequency domain
------------------------------------------------
FrequencyDomain.BodyAcceleration.XYZ

FrequencyDomain.BodyAccelerationJerk.XYZ
FrequencyDomain.BodyAngularSpeed.XYZ

FrequencyDomain.BodyAccelerationMagnitude

FrequencyDomain.BodyAccelerationJerkMagnitude
FrequencyDomain.BodyAngularSpeedMagnitude
FrequencyDomain.BodyAngularAccelerationMagnitude

* ".XYZ" denotes three variables, one for each axis.
* For variables derived from mean and standard deviation estimation, the previous labels
are augmented with the terms "Mean" or "StandardDeviation".

The data set is written to the file Tidy.txt.
