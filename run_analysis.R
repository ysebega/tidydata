## run_analysis.R script ###
## Assuming that this script is in the same working directory like all Samsung data files

## STEP 1
## Merges the training and the test sets to create one data set.
library(dplyr)
library(data.table)

## Read features file fro columns headings
featurelabels <- read.table("features.txt")
colnames(featurelabels)<-c("feature", "featurename")

## Read the train files and combine
trainsubjects <- read.table("subject_train.txt")
colnames(trainsubjects)<-c("subject")
ytrain<-read.table("y_train.txt")
colnames(ytrain)<- c("activityid")
xtrain<-read.table("x_train.txt")
## Add columns on the train set from feature labels
colnames(xtrain)<-featurelabels$featurename
xytrain<-cbind(ytrain, trainsubjects, xtrain)

## Read the test files and combine
testsubjects <- read.table("subject_test.txt")
colnames(testsubjects)<-c("subject")
ytest<-read.table("y_test.txt")
colnames(ytest)<- c("activityid")
xtest<-read.table("x_test.txt")
## Add columns on the test set from feature labels
colnames(xtest)<-featurelabels$featurename
xytest<-cbind(ytest, testsubjects, xtest)

## Merge Train and test dataset into one
traintestdataset<-rbind(xytrain, xytest)


## STEP 2
## Extracts only the measurements on the mean and standard deviation for each measurement.

## Select activityid and subject and add to a variable holder
act<-rbind(ytrain, ytest)
subj<-rbind(trainsubjects, testsubjects)
actsubj<-cbind(act, subj)
## Extract measurements on mean and std
extractcolumns <- grepl("mean|std", colnames(traintestdataset))
## extract columns with mean and std only
meanstd<-traintestdataset[,extractcolumns]
## for every observation, add columns activityid and subject from variaoble holder actsubj
meanstdmeasure<-cbind(actsubj, meanstd)


## STEP 3
## Uses descriptive activity names to name the activities in the data set
activitylabels <- read.table("activity_labels.txt")
colnames(activitylabels)<- c("activityid","activity")
descnamesdata<-merge(activitylabels, meanstdmeasure, by="activityid")
## remove the activityid column which is not needed
descnamesdata<-select(descnamesdata, -activityid)

## STEP 4
## Appropriately labels the data set with descriptive variable names.
colnames <-names(descnamesdata)
## Good naming conventions for variables: lower care, no underscore, no dots or white spaces.  

## Remove the dots, hyphens (-) and the parentheses ()
x<-gsub("\\.|\\(|\\)|-", "", colnames)
## Remove extract body
y<-sub("BodyBody", "Body", x)
## The initial t and f stand respectively for time and frequency
z<-sub("^t", "time", y)
t<-sub("^f", "freqency", z)
## Gyro=gyroscope, Acc=acceleration and Mag=magnitude
u<-sub("Acc", "Acceleration", t)
v<-sub("Gyro", "Gyroscope", u)
w<-sub("Mag", "Magnitude", v)
## Change std to SD (standard Deviation)
i<-sub("std", "SD", w)
## Remove extract Freq from frequency variables.
j<-sub("Freq", "", i)
## Change mean to Mean
k<-sub("mean", "Mean", j)

## Re-assign cleaned columns to data set; 
names(descnamesdata)<-make.names(k, unique=TRUE)


## STEP 5
## From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
tidy<- (descnamesdata%>%group_by(subject,activity) %>%summarise_each(funs( mean)))

## Write the txt file
write.table(tidy, "tidy.txt", row.names=FALSE)
