# Step 1
# This merges the training and test sets data to create one data set instead of having the data spread between two 
# different files.

trainData <- read.table("./data/train/X-train.txt")
dim(trainData) # Original dimensions of X-train.txt: 7352*561
head(trainData)
trainLabel <- read.table("./data/train/y_train.txt")
table(trainLabel)
trainSubject <- read.table("./data/train/subject_train.txt")
testData <- read.table("./data/test/X_test.txt")
dim(testData) # Dimensions of X_test.txt: 2947*561
testLabel <- read.table("./data/test/y_test.txt")
table(testLabel)
testSubject <- read.table("./data/test/subject_test.txt")
joinData <- rbind(trainData, testData)
dim(joinData) # Dimensions of the joinData: 10299*561
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel)
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject) # Our new dimensions: 10299*1

# Step 2
# This step extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("./data/features.txt")
dim(features) 
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices) 
joinData <- joinData[, meanStdIndices]
dim(joinData) # Our new dimensions: 10299*66
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # Cleaning our data: remove "()"
names(joinData) <- gsub("mean", "Mean", names(joinData)) # Cleaning our data: capitalize M
names(joinData) <- gsub("std", "Std", names(joinData)) # Cleaning our data: capitalize S
names(joinData) <- gsub("-", "", names(joinData)) # Cleaning our data: remove "-" in column names 

# Step 3
# We use descriptive activity names to name the activities in the data set

activity <- read.table("./data/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

# Step 4
# Appropriately label the data set with descriptive activity names

names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
dim(cleanedData) 
write.table(cleanedData, "merged_data.txt") # Output: our first dataset

# Step 5
# Create a second, independent tidy data set with the average of each variable for each activity and each subject

subjectLen <- length(table(joinSubject)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen)
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
    for(j in 1:activityLen) {
        result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
        result[row, 2] <- activity[j, 2]
        bool1 <- i == cleanedData$subject
        bool2 <- activity[j, 2] == cleanedData$activity
        result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
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