##download & unzip the data provided

#name variables to improve readability of code
fileName <- "UCIdata.zip"
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "UCI HAR Dataset"

#if the file isn't already in the working directory it will be added through this step
if(!file.exists(fileName)){
        download.file(url,fileName, mode = "wb") 
}

#same procedure for unzipping
if(!file.exists(dir)){
	unzip("UCIdata.zip", files = NULL, exdir=".")
}

#reading the data into the environment
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")  

##now following with the tasks on the 'Peer-graded Assignment: Getting and Cleaning Data Course Project' site on coursera

#1. Merging the training and the test sets to create one data set.
dataset <- rbind(X_train,X_test)

#2. Extracting only the measurements on the mean and standard deviation for each measurement.
MeanStdOnly <- grep("mean()|std()", features[, 2]) 
dataset <- dataset[,MeanStdOnly]

#4. Appropriately label the data set with descriptive activity names.
CleanFeatureNames <- sapply(features[, 2], function(x) {gsub("[()]", "",x)})
names(dataset) <- CleanFeatureNames[MeanStdOnly]
      
     # combining test and train of subject data and activity data, giving descriptive lables
subject <- rbind(subject_train, subject_test)
names(subject) <- 'subject'
activity <- rbind(y_train, y_test)
names(activity) <- 'activity'

    # combining subject, activity, and mean and StdOnly data set to create final data set.
dataset <- cbind(subject,activity, dataset)

# 3. Using descriptive activity names to name the activities in the data set
act_group <- factor(dataset$activity)
levels(act_group) <- activity_labels[,2]
dataset$activity <- act_group

# 5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject. 

#here I will be using the reshape2 package mentioned in the README.md; same procedure as before: I'm checking if the package is already installed and load it into the library

if (!"reshape2" %in% installed.packages()) {
	install.packages("reshape2")
}
library("reshape2")

baseData <- melt(dataset,(id.vars=c("subject","activity")))
seconddataset <- dcast(baseData, subject + activity ~ variable, mean)
names(seconddataset)[-c(1:2)] <- paste("[mean of]" , names(seconddataset)[-c(1:2)] )
write.table(seconddataset, "tidy_data.txt", sep = ",")
