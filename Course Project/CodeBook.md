Getting and Cleaning Data Course Project - Code Book
====================================================

### Data Set Code Book: Human Activity Recognition Using Smartphones

February 22nd, 2015
Codebook prepared by Jess Anastasia, based on the data and output collected and run from run_analysis.R

#### Where the data came from

Overall project site: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The dataset used in run_analysis.R can be found directly here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#### The Variables used in run_analysis.R, how they were used, and how the data was transformed

* We read and store our data from X_train.txt, y_train.txt, and subject_train.txt, found in "/data/train" into the following variables: 
     * *train.data*
     * *train.label*
     * *train.subject*
* We read and store our data from X_test.txt, y_test.txt, and subject_test.txt, found in "/data/test", into the following variables: 
     * *test.data*
     * *test.label*
     * *test.subject*
* We merge *test.data* and *train.data* into a data frame and store it in *join.data*.
* We merge *test.label* and *train.label* into a data frame and store it in *join.label*.
* We merge *test.subject* and *train.subject* into a data frame and store it in *join.subject*
* We read and store our data from features.txt, found in "/data" into a variable called *features*. We subset the data on the mean and standard deviations and store it in *mean.stdindices* which results in an indice list of 66. We subset the 66 corresponding columns and store them in *join.data*.
* We clean the column names of the subset by removing the "()" and "-" from the names and capitalize our column names.
* We read and store the data from activity_labels.txt in our *activity* variable. We transform the values of *activity.label* and *join.label*.
* We combine the *join.subject*, *join.label*, and *join.data* variables by column to get a new data frame and store it in *cleaned.data*. We name our columns "subject" and "activity". The "subject" column containst an integer ranging from 1 to 30 and the "activity" column contains 6 activity names (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). The remaining columns contain measurements rangin from -1 to 1.
* We write out our *cleaned.data* to "data_merged.txt" file.
* We generate a second data set with the average of each measurement, for each activity and each subject (*subject.len*, *activity.len*, and *column.len*) and store it in *result*.
* We write *result* to "means_data.txt".

#### Variables from the original dataset, for each activity, and each subject

For more information on these variables, please see the README.txt, features.txt, and features_info.txt found within the data folder.

* tBodyAcc-mean()-X
* tBodyAcc-mean()-Y
* tBodyAcc-mean()-Z
* tBodyAcc-std()-X
* tBodyAcc-std()-Y
* tBodyAcc-std()-Z
* tGravityAcc-mean()-X
* tGravityAcc-mean()-Y
* tGravityAcc-mean()-Z
* tGravityAcc-std()-X
* tGravityAcc-std()-Y
* tGravityAcc-std()-Z
* tBodyAccJerk-mean()-X
* tBodyAccJerk-mean()-Y
* tBodyAccJerk-mean()-Z
* tBodyAccJerk-std()-X
* tBodyAccJerk-std()-Y
* tBodyAccJerk-std()-Z
* tBodyGyro-mean()-X
* tBodyGyro-mean()-Y
* tBodyGyro-mean()-Z
* tBodyGyro-std()-X
* tBodyGyro-std()-Y
* tBodyGyro-std()-Z
* tBodyGyroJerk-mean()-X
* tBodyGyroJerk-mean()-Y
* tBodyGyroJerk-mean()-Z
* tBodyGyroJerk-std()-X
* tBodyGyroJerk-std()-Y
* tBodyGyroJerk-std()-Z
* tBodyAccMag-mean()
* tBodyAccMag-std()
* tGravityAccMag-mean()
* tGravityAccMag-std()
* tBodyAccJerkMag-mean()
* tBodyAccJerkMag-std()
* tBodyGyroMag-mean()
* tBodyGyroMag-std()
* tBodyGyroJerkMag-mean()
* tBodyGyroJerkMag-std()
* fBodyAcc-mean()-X
* fBodyAcc-mean()-Y
* fBodyAcc-mean()-Z
* fBodyAcc-std()-X
* fBodyAcc-std()-Y
* fBodyAcc-std()-Z
* fBodyAcc-meanFreq()-X
* fBodyAcc-meanFreq()-Y
* fBodyAcc-meanFreq()-Z
* fBodyAccJerk-mean()-X
* fBodyAccJerk-mean()-Y
* fBodyAccJerk-mean()-Z
* fBodyAccJerk-std()-X
* fBodyAccJerk-std()-Y
* fBodyAccJerk-std()-Z
* fBodyAccJerk-meanFreq()-X
* fBodyAccJerk-meanFreq()-Y
* fBodyAccJerk-meanFreq()-Z
* fBodyGyro-mean()-X
* fBodyGyro-mean()-Y
* fBodyGyro-mean()-Z
* fBodyGyro-std()-X
* fBodyGyro-std()-Y
* fBodyGyro-std()-Z
* fBodyGyro-meanFreq()-X
* fBodyGyro-meanFreq()-Y
* fBodyGyro-meanFreq()-Z
* fBodyAccMag-mean()
* fBodyAccMag-std()
* fBodyAccMag-meanFreq()
* fBodyBodyAccJerkMag-mean()
* fBodyBodyAccJerkMag-std()
* fBodyBodyAccJerkMag-meanFreq()
* fBodyBodyGyroMag-mean()
* fBodyBodyGyroMag-std()
* fBodyBodyGyroMag-meanFreq()
* fBodyBodyGyroJerkMag-mean()
* fBodyBodyGyroJerkMag-std()
* fBodyBodyGyroJerkMag-meanFreq()