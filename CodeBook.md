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



