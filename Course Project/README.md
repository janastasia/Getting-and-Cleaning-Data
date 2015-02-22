Getting and Cleaning Data - Course Project (for Peer Review)
============================================================

### Overview

This repo consists of the code and data for the course project for the Getting and Cleaning Data course project offered through Coursera and Johns Hopkins University.

#### Summary of the Assignment

One of the most exciting areas in all of data science right now is wearable computing - see for example this [article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How run_analysis.R Works

To use run_analysis.R, you will need to follow the steps below.

* Before getting started, please make sure you know you're working directory (`getwd()`). You will need to save the files to your working directory so if you want to change your working directory please do so now by using `setwd()`.
* Download and unzip the files found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and place them in your working directory.
* Make sure that both the "data" folder and the run_analysis.R script are in your current working directory.
* Use `source("run_analysis.R")` in RStudio to load the run_analysis.R file.
* You'll find two output files in the current working directory:
     * **data_merged.txt:** this contains a data frame called cleanedData with dimensions of 10299*68.
     * **means_data.txt:**  this contains a data frame called result with dimensions of 180*68.
* In RStudio, run command `data <- read.table("means_data.txt")` to read the file. If run properly, there should be 6 activities and 30 subjects in total. We will have 180 rows with all combinations for each of the 66 features.