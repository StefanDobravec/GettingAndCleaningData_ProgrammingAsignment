This script prepares tidy data as specified in the programming assignment. 

As input the UCI HAR Dataset is taken

First, following txt files are read that contain:
-feature names: "UCI HAR Dataset/features.txt"
-activity labels: "UCI HAR Dataset/activity_labels.txt"
-testset measurements: "UCI HAR Dataset/test/X_test.txt"
-testset activity indexes: "UCI HAR Dataset/test/y_test.txt"
-testset subject indexes: "UCI HAR Dataset/test/subject_test.txt"
-trainSet measurements: "UCI HAR Dataset/train/X_train.txt"
-trainSet activity indexes: "UCI HAR Dataset/train/y_train.txt"
-trainSet subject indexes: "UCI HAR Dataset/train/subject_train.txt"

Next, the testset and trainset data frame column names are set using data from feature names file.

Then, a subsetting of the testset and trainset data frame is done. Only variables that contain 'mean' or 'std' are kept.

Afterwards, corresponding activity indexes vector and subject indexes vector are named and added as columns to the left of the testset/trainset.

Next, the testset and trainset are merged to produce one single dataset. This is done simply by rbind.

Then, numeric activity indexes are substituted with their labels, obtained from activity labels file.

Finally, clean data set is produced as specified in programming assignment, breaking down the dataset on SubjectID and Activity, performing average of the rest of the columns in each SubjectID/Activity group.