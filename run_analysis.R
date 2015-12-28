### data file paths
## feature names file
featureNamesFilePath <- "UCI HAR Dataset/features.txt"
## activity labels file
activityLabelsFilePath <- "UCI HAR Dataset/activity_labels.txt"
## testset measurements file
testMeasurementsFilePath <- "UCI HAR Dataset/test/X_test.txt"
## testset activity indexes file
testActivityIdxFilePath <- "UCI HAR Dataset/test/y_test.txt"
## testset subject indexes file
testSubjectsIdxFilePath <- "UCI HAR Dataset/test/subject_test.txt"
## trainSet measurements file
trainMeasurementsFilePath <- "UCI HAR Dataset/train/X_train.txt"
## trainSet activity indexes file
trainActivityIdxFilePath <- "UCI HAR Dataset/train/y_train.txt"
## trainSet subject indexes file
trainSubjectsIdxFilePath <- "UCI HAR Dataset/train/subject_train.txt"

### read data
## read features
featureNames <- read.table(featureNamesFilePath)
## read activity labels
activityLabels <- read.table(activityLabelsFilePath)
## read testset
testSet <- read.table(testMeasurementsFilePath)
testActivityIdx <- read.table(testActivityIdxFilePath)
testSubjectsIdx <- read.table(testSubjectsIdxFilePath)
## read trainingSet
trainSet <- read.table(trainMeasurementsFilePath)
trainActivityIdx <- read.table(trainActivityIdxFilePath)
trainSubjectsIdx <- read.table(trainSubjectsIdxFilePath)

### reshape the data
library(dplyr)
## set column names
names(testSet) <- makeNames(featureNames$V2)
names(trainSet) <- makeNames(featureNames$V2)
## subset the columns with .mean and .std in their name
testSet <- testSet[grepl('.mean', colnames(testSet)) | grepl('.std', colnames(testSet))]
trainSet <- trainSet[grepl('.mean', colnames(trainSet)) | grepl('.std', colnames(trainSet))]
## set name of the activity index column and 
names(testActivityIdx) <- "Activity"
names(trainActivityIdx) <- "Activity"
## set name of the subject index column
names(testSubjectsIdx) <- "SubjectID"
names(trainSubjectsIdx) <- "SubjectID"
## add above two columns to the dataset
testSet <- cbind(testSubjectsIdx,testActivityIdx,testSet)
trainSet <- cbind(trainSubjectsIdx,trainActivityIdx,trainSet)
### merge the datasets
## because original data is split into test/train we can join the using rbind()
dataSet <- rbind(trainSet,testSet)
## change the numeric index of the activity with its label
dataSet$Activity <- activityLabels[match(dataSet$Activity,activityLabels$V1),2]

### make clean data set as specified in the instructions
tidySet <- aggregate(dataSet[,3:81],list(SubjectID=dataSet$SubjectID,Activity=dataSet$Activity),mean)