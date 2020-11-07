Code Book
==========


as descibed in the script I'm first going to check if the data and needed packages are already downloaded and download/install accordingly

## Tasks according to Coursework:

## 1. Merges the training and the test sets to create one data set.
* subject_test : subject IDs for test
* subject_train  : subject IDs for train
* X_test : values of variables in test
* X_train : values of variables in train
* y_test : activity ID in test
* y_train : activity ID in train
* activity_labels : Description of activity IDs in y_test and y_train
* features : description(label) of each variables in X_test and X_train
* dataset : bind of X_train and X_test

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
Create a vector of only mean and std labels, then use the vector to subset dataset.
* MeanStdOnly : a vector of only mean and std labels extracted from 2nd column of features
* dataset : at the end of this step, dataset will only contain mean and std variables

## 3. Uses descriptive activity names to name the activities in the data set & 4. Appropriately labels the data set with descriptive variable names.
Create a vector of "clean" feature names by getting rid of "()" at the end. Then, will apply that to the dataset to rename column labels.
* CleanFeatureNames : a vector of "clean" feature names 

Combine test data and train data of subject and activity, then give descriptive lables. Finally, bind with dataset. At the end of this step, dataset has 2 additonal columns 'subject' and 'activity' in the left side.
* subject : bind of subject_train and subject_test
* activity : bind of y_train and y_test

Group the activity column of dataset as "act_group", then rename each levels with 2nd column of activity_levels. Finally apply the renamed "act_group" to dataset's activity column.
* act_group : factored activity column of dataset 

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
In this part, dataset is melted to create tidy data. It will also add [mean of] to each column labels for better description. Finally output the data as "tidy_data.txt"
* baseData : melted tall and skinny dataset
* secondDataset : baseData which has means of each variables

