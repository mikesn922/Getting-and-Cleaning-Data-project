# Getting-and-Cleaning-Data-project CodeBook
This code book describes the variables, the data, and any transformations or work that I performed to clean up the data

1. The raw data from the following link
  [dowlaod rawData](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. The R script did the following steps to clean the data
    1. Read test and train data
       - Read "X_test.txt" into data table "testData"
       - Read "y_test.txt" into data table "testLabel"
       - Read "subject_test.txt" into data table "testSubject"
       - Read "X_train.txt" into data table "trainData"
       - Read "y_train.txt" into data table "trainLabel"
       - Read "subject_train.txt" into data table "trainSubject"
    2. Merge data
       - Merge "testData" and "trainData" by row bind and save the new data table in "mergeData"
       - Merge "testLabel" and "trainLabel" by row bind and save the new data table in "mergeLabel"
       - Merge "testSubject" and "trainSubject" by row bind and save the bew data table in "mergeSubject"
       - Merge "mergeSubject", "mergeLabel" and "mergeData" data tables together by column bind and save the new data table in "mergeAll"
    3. Read "features.txt" into data table "features"
    4. Assign names of columns in the data table "mergeAll"
       - First column is called "subject"
       - Second column is called "activity"
       - The rest columns of "mergeAll" are named by the values saved in the second column of "features"
    5. Extract the names of the measurements contain "mean()" or "std()" in the second column of "features"
       - Extract the names of measurements contain "mean()", save the subset in "subsetNamesMean"
       - Extract the names of measurements contain "std()", save the subset in "subsetNamesStd"
       - Merge the two subsets together by row bind and save in "subsetNames"
    6. Selet the columns of data table "mergeAll" that contain the names of "subject", "activity" and the names saved in "subsetNames", and save the subset into a data table called "meanStdData"
    7. Read "activity_labels.txt" into data table "activityLabels"
    8. Rename the value in activity column of the data table "meanStdData" by the corresponding look up table in "activityLabels"
    9. Change the column names of "meanStdData" and the content in the "activity" column to lowercase. Remove "-", "_" and quote in the strings.
    10. Creates a second, independent tidy data set with the average of each variable for each activity and each subject
       - Lappy mean function over the 3rd to the last columns of the data table "meanStdData" by the groups of "subject" and "activity"
       - Save the result in a data table called "tidyAverage"
    11. Save the "tidyAverage" data table into a txt file by using write.table() with row.name=FALSE. The txt file should be in the current working directory and called "finalTidyData.txt"
3. The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. Features are normalized and bounded within [-1, 1].

