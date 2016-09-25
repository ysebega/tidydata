# The Cook Book
The data collection is an experiment that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.
The zip file downloaded from website included many files. The ones necessary for this applications are:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

## Packages needed
library(dplyr)
library(data.table)

## Reading the files
### Step 1 - Merges the training and the test sets to create one data set.
The function read.table() was used to read all the files above-mentioned.
Variables for the train data set: trainig subject(trainsubjects), training set(xtrain), and training labels(ytrain). Idem for test set:trainig subject(testsubjects), training set(xtest), and training labels(ytest). And then for training and test, two datasets were created; This create the training dataset: xytrain<-cbind(ytrain, trainsubjects, xtrain); and then 'xytest<-cbind(ytest, testsubjects, xtest)' to create the test dataset. And then to merge the 2 dataset a rbind was called on xytest and xytest.

### Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
Before extracting the measurements, I needed to create a holder for activity and subject since the regex was going to exclude these 2 columns. Call grepl function on the columns names of the dataset (grepl("mean|std", colnames(traintestdataset)). And then pass the result to subset the merged dataset created in Step 1. And tehn add activityid and subject to the extracted dataset with cbind.

### Step 3 - Uses descriptive activity names to name the activities in the data set
Descriptive names are located in this file: activity_labels.txt; Read the file, add columns such as activityid and activity.
and then merge the extracted dataset created in Step 2 to activityid and activity by activityid.And then exclude the activityid column from the selected cause not needed.

### Step 4 - Appropriately labels the data set with descriptive variable names.
To appropriately label, we need regex. gsub() and sub() functions are used to substitue some strings. Ex: x<-gsub("\\.|\\(|\\)|-", "", colnames) removes hyphens, the dots, and the parentheses from variables names. The others are just straightforward.

### Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The tidy variable is created by chaining the group_by() and summari_each() functions: (tidy<- (descnamesdata%>%group_by(subject,activity) %>%summarise_each(funs( mean))).The group_by() group by subject and activity. And then the summarise_each applies mean to the dataset created by the group_by function. And finally the tidy.txt is created with tidy dataset created.








