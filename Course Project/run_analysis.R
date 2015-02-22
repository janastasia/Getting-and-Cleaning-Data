# Let's set our working directory first
# setwd("~/Documents/Getting and Cleaning Data/Course Project")

# Step 1
# This merges the training and test sets data to create one data set instead of having the data spread between two 
# different files.

train.data <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
dim(train.data) # Original dimensions of X-train.txt: 7352*561
head(train.data)
train.label <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
table(train.label)
train.subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
test.data <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
dim(test.data) # Dimensions of X_test.txt: 2947*561
test.label <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
table(test.label)
test.subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
join.data <- rbind(train.data, test.data)
dim(join.data) # Dimensions of the joinData: 10299*561
join.label <- rbind(train.label, test.label)
dim(join.label)
join.subject <- rbind(train.subject, test.subject)
dim(join.subject) # Our new dimensions: 10299*1

# Step 2
# This step extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("./data/UCI HAR Dataset/features.txt")
dim(features) 
mean.stdindices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(mean.stdindices) 
join.data <- join.data[, mean.stdindices]
dim(join.data) # Our new dimensions: 10299*66
names(join.data) <- gsub("\\(\\)", "", features[mean.stdindices, 2]) # Cleaning our data: remove "()"
names(join.data) <- gsub("mean", "Mean", names(join.data)) # Cleaning our data: capitalize M
names(join.data) <- gsub("std", "Std", names(join.data)) # Cleaning our data: capitalize S
names(join.data) <- gsub("-", "", names(join.data)) # Cleaning our data: remove "-" in column names 

# Step 3
# We use descriptive activity names to name the activities in the data set

activity <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activity.label <- activity[join.label[, 1], 2]
join.label[, 1] <- activity.label
names(join.label) <- "activity"

# Step 4
# Appropriately label the data set with descriptive activity names

names(join.subject) <- "subject"
cleaned.data <- cbind(join.subject, join.label, join.data)
dim(cleaned.data) 
write.table(cleaned.data, "merged_data.txt") # Output: our first dataset

# Step 5
# Create a second, independent tidy data set with the average of each variable for each activity and each subject

subject.len <- length(table(join.subject)) # 30
activity.len <- dim(activity)[1] # 6
column.len <- dim(cleaned.data)[2]
result <- matrix(NA, nrow=subject.len*activity.len, ncol=column.len)
result <- as.data.frame(result)
colnames(result) <- colnames(cleaned.data)
row <- 1
for(i in 1:subject.len) {
    for(j in 1:activity.len) {
        result[row, 1] <- sort(unique(join.subject)[, 1])[i]
        result[row, 2] <- activity[j, 2]
        foo.subject <- i == cleaned.data$subject
        foo.activity <- activity[j, 2] == cleaned.data$activity
        result[row, 3:column.len] <- colMeans(cleaned.data[foo.subject&foo.activity, 3:column.len])
        row <- row + 1
    }
}
head(result)
write.table(result, "data_with_means.txt") # Output: our second dataset

# Load this into RStudio using source("run_analysis.R")
# Then load in our data_with_means.txt dataset using the following:
# data <- read.table("./data_with_means.txt")
# Let's test it with: 
# data[1:12, 1:3]
#
# Our readout should be:
#    subject          activity tBodyAccMeanX
# 1        1           walking     0.2773308
# 2        1   walkingUpstairs     0.2554617
# 3        1 walkingDownstairs     0.2891883
# 4        1           sitting     0.2612376
# 5        1          standing     0.2789176
# 6        1            laying     0.2215982
# 7        2           walking     0.2764266
# 8        2   walkingUpstairs     0.2471648
# 9        2 walkingDownstairs     0.2776153
# 10       2           sitting     0.2770874
# 11       2          standing     0.2779115
# 12       2            laying     0.2813734