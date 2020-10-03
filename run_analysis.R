# Week 4 Project on Getting and Cleaning wearable device data


library(dplyr)

filename <- "UCIHAR.zip"
# download the file if not already downloaded
if(!file.exists(filename)) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method = "curl")  
}
# unzip the zip file if folder does not exist
if(!file.exists("UCI HAR Dataset")) {
  unzip(filename)
}

# loading features.txt into features table, with column names featurenum, featurename
features <- read.table("features.txt", col.names = c("featurenum", "featurename"))
activity <- read.table("activity_labels.txt", col.names = c("activitycode", "activityname"))

#loading X_test.txt, X_train.txt, y_test.txt, y_train.txt, subject_test, subject_train
# into respective tables
x_test <- read.table("test/X_test.txt", col.names = features$featurename)
x_train <- read.table("train/X_train.txt", col.names = features$featurename)
y_test <- read.table("test/y_test.txt", col.names = "activitycode")
y_train <- read.table("train/y_train.txt", col.names = "activitycode")
subject_test <- read.table("test/subject_test.txt", col.names = "subject")
subject_train <- read.table("train/subject_train.txt", col.names = "subject")

# Below script does the first task of "Merges the training and test sets to create one data set"
# Singlesetdata will have Subject, Activity, and the readings in that order
Xdata <- rbind(x_test, x_train)
Ydata <- rbind(y_test, y_train)
Subjectdata <- rbind(subject_test, subject_train)
Singlesetdata <- cbind(Subjectdata, Ydata, Xdata)

# Task 2 is to "Extract only the measurements of mean and standard deviation"
Meansddata <- Singlesetdata %>% select(subject, activitycode, contains("mean"), contains("std"))

# Task 3 is to "Use activity names in the data set"
Meansddata$activitycode <- activity[Meansddata$activitycode, 2]

# Task 4 is to "appropriately label the data set"
names(Meansddata) <- gsub("Acc", "Accelerometer", names(Meansddata))
names(Meansddata) <- gsub("Gyro", "Gyroscope", names(Meansddata))
names(Meansddata) <- gsub("Mag", "Magnitude", names(Meansddata))
names(Meansddata) <- gsub("std", "StdDeviation", names(Meansddata))
names(Meansddata) <- gsub("^f", "Frequency", names(Meansddata))
names(Meansddata) <- gsub("^t", "Time", names(Meansddata))
names(Meansddata) <- gsub("BodyBody", "Body", names(Meansddata))

# Task 5 is to "create a second tidy data set with average of each variable
# for each activity and each subject

Tidydata <- Meansddata %>% 
  group_by(subject, activitycode) %>%
  summarise_all(list(mean))
write.table(Tidydata, "Tidydata.txt", row.names = FALSE)







