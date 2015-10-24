#load libraries
library(data.table)

#1.1 read test data and train data into data table
testData <- data.table(read.table("./UCI HAR Dataset/test/X_test.txt"))
testLabel <- data.table(read.table("./UCI HAR Dataset/test/y_test.txt"))
testSubject <- data.table(read.table("./UCI HAR Dataset/test/subject_test.txt"))
trainData <- data.table(read.table("./UCI HAR Dataset/train/X_train.txt"))
trainLabel <- data.table(read.table("./UCI HAR Dataset/train/y_train.txt"))
trainSubject <- data.table(read.table("./UCI HAR Dataset/train/subject_train.txt"))

#1.2 merge the training and the test sets to create one data set
mergeData <- rbindlist(list(testData, trainData))
mergeLabel <- rbindlist(list(testLabel, trainLabel))
mergeSubject <- rbindlist(list(testSubject, trainSubject))
mergeAll <- cbind(mergeSubject, mergeLabel, mergeData)

#2.1 Extracts the names of the measurements contain "mean()" or "std()"
features <- data.table(read.table("./UCI HAR Dataset/features.txt"))
names(mergeAll) <- c("subject", "activity_label", as.character(features[[2]]))
subsetNamesMean <- features[like(V2, "mean\\(\\)")]
subsetNamesStd <- features[like(V2, "std\\(\\)")]
subsetNames <- rbindlist(list(subsetNamesMean, subsetNamesStd))

#2.2 select the targeted columns, including the subject and the label columns
meanStdData <- mergeAll[, c("subject", "activity_label", as.character(subsetNames[[2]])), with=FALSE]

#3 Uses descriptive activity names to name the activities in the data set
activityLabels <- data.table(read.table("./UCI HAR Dataset/activity_labels.txt"))
meanStdData[, activity_label := activityLabels[meanStdData$activity_label, .(V2),], ]

#4 Appropriately labels the data set with descriptive variable names (Done before)

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidyAverage <- meanStdData[, lapply(.SD, mean, na.rm = TRUE), by= list(subject, activity_label), .SDcols = 3:ncol(meanStdData)]
#output final tidy data table
write.table(tidyAverage, "finalTidyData.txt", row.name=FALSE)
