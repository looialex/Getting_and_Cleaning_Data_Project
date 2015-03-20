# The goal of this program run_analysis.R is to prepare tidy data
# that can be used for later analysis.

# This program will download the data from the URL
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# into the working directory. The file will then be unzipped.

# The code will then perform the following:
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation
# for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.

# I assume we have to follow the sequence stated above
# (even though I think 4 should be performed first before 2.)

# This code will generate:
# 1) a tidy data set,
# 2) a code book for the tidy data set which describes the variables, the data,
# and any transformations or work that was performed to clean up the data,
# 3) a readme file.

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
data_file <- "Dataset.zip"

# Check if zip file exist in the working directory. If it exists, just unzip it.
# If it doesn't exist, download it and unzip in the working directory.
if (file.exists(data_file)){
        print("Zip file exists in working directory. Unzipping file...")
        unzip("./Dataset.zip")
        print("Unzip complete.")
} else {
        print("Downloading File (approx 60Mb) to you working directory.")
        print("It may take a couple of minutes.")
        download.file(URL, "./Dataset.zip")
        datedownloaded <- date()
        print("Download complete.")
        print("Unzipping file...")       
        unzip("./Dataset.zip")
        print("Unzip complete.")
}

#---------------------------Start Part 1----------------------------------------
# The part of the code Merges the training and the test sets to create
# one data set called "combine_data"

# Based on README.txt that comes with the dataset,
# Training set = train/X_train.txt, Test set = test/X_test.txt.
# The necessary files in the Raw data that are necessary for the merging are:

# Training Data Set
# 1) subject_train.txt: Each row contains the the subject identifier that
# took part in the training (range 1 - 30).
# 2) X_train.txt: Training data set. Each row represent the data collected
# for each subject. Each column represent the data collect from each of the
# features in the feature list.
# 3) y_train.txt: Training labels - Tag each row of training data to the
# activity numbers in the activity_labels. (range 1 - 6)

# Test Data Set
# 1) subject_test.txt: Each row contains the the subject identifier that
# took part in the test (range 1 - 30).
# 2) X_test.txt: Test data set. Each row represent the data collected
# for each subject. Each column represent the data collect from each of the
# features in the feature list.
# 3) y_test.txt: Test labels - Tag each row of test data to the activity
# numbers in the activity_labels. (range 1 - 6)


# Steps taken to Merges the data:
# 1) Read in training data files: subject_train.txt, X_train.txt, y_train.txt.
# 2) Read in test data files: subject_test.txt, X_test.txt, y_test.txt,
# 3) Combine (column wise) "subject_train", "y_train", "X_train" to get the
# merged training data set.
# 4) Repeat step 3 to 8 with the test sets to get the merged test data set.
# 5) Merge the training and test data set (row wise) to get "combine_data"

# Read training data related files
print("Reading and Merging Training and Test Data, and calulating average. Please wait....")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

# For checking purposes only
# names(subject_train) <- "subject"
# write.table(subject_train, "./subject_train.txt", row.names = FALSE)
# names(y_train) <- "activity"
# write.table(y_train, "./y_train.txt", row.names = FALSE)
# y_train_Label <- activity_labels[match(y_train[[1]], activity_labels[,1]),2]
# names(y_train_Label) <- "activity_label"
# write.table(y_train_Label, "./y_train_Label.txt", row.names = FALSE)
# colnames(X_train) <- features[,2]
# write.table(X_train, "./X_train.txt", row.names = FALSE)

# Merging training data set (column wise)
training_data <- cbind(subject_train, y_train, X_train)
# write.table(training_data, "./training_data.txt", row.names = FALSE)

# free up memory for variables that are not required anymore.
rm(subject_train)
rm(X_train)
rm(y_train)


# Read test data related files
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

# Merging test data set (column wise)
test_data <- cbind(subject_test, y_test, X_test)
# write.table(test_data, "./test_data.txt", row.names = FALSE)

# free up memory for variables that are not required anymore.
rm(subject_test)
rm(X_test)
rm(y_test)

# Merge training and test data set, row wise.
combine_data <- rbind(training_data, test_data)
# write.table(combine_data, "./combine_data.txt", row.names = FALSE)

# free up memory for variables that are not required anymore.
rm(training_data)
rm(test_data)

#---------------------------End Part 1------------------------------------------

#---------------------------Start Part 2----------------------------------------
# The part of the code extracts from "combine_data" only the measurements
# on the mean and standard deviation for each measurement, and store the
# extracted data into a new data set "mean_std"

# Files/data set required:
# 1) features.txt: Tag each column in the training/test set to a feature.
# eg column 1 is tBodyAcc-mean()-X. Total 561 features
# The feature list will tell us whether the measurement is mean/std dev or not.
# 2) "combine_data" obtained in Part 1.

# Steps taken to extract the mean/std dev from the data:
# 1) Read in feature list file: features.txt
# 2) Extract from the feature list, the corresponding column number in the data
# set that contains the mean and std dev measurement. The search criteria
# used are "mean()" and "std" as stated in the features_info.txt.
# 3) Extract from "combine_data" the mean and std dev measurement based on
# the column numbers obtained from step 2).

# read feature list
features <- read.table("./UCI HAR Dataset/features.txt")

# extract the column number of data with feature mean() and std()
feature_sub <- features[grep("\\<mean()\\>|\\<std()\\>", features[,2]), ]
mean_std <- cbind(combine_data[,1], combine_data[,2],
                  combine_data[,feature_sub[,1]+2])
# write.table(feature_sub, "./feature_sub.txt", row.names = FALSE)
# write.table(mean_std, "./mean_std.txt", row.names = FALSE)

# free up memory for variables that are not required anymore.
rm(combine_data)

#---------------------------End Part 2------------------------------------------

#---------------------------Start Part 3----------------------------------------
# The part of the code uses descriptive activity names to name the activities
# in the data set. The activities labels are in column 2 of the data set
# "mean_std" obtained in Part 2. The code will match the label to the actual
# activity names in the file activity_labels.txt, and overwrite the label with
# the actual names. The output of this part of the code will still be
# "mean_std" data set.

# Files/data set required:
# 1) activity_labels.txt: Tag activity number to actual activity.
# eg activity 1 is WALKING.
# 2) "mean_std" obtained in Part 1.

# read activity names
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# match acitivity label
mean_std[[2]] <- activity_labels[match(mean_std[[2]], activity_labels[,1]),2]
# write.table(mean_std, "./mean_std_2.txt", row.names = FALSE)

#---------------------------End Part 3------------------------------------------

#---------------------------Start Part 4----------------------------------------
# The part of the code will appropriately labels the data set "mean_std"
# with descriptive variable names.

# Files/data set required:
# 1) "mean_std" obtained in Part 3.
# 2) "feature_sub" which contains the feature names of each measurment
# in the data set "mean_std".

# Column 1 of data set indicates the subject that went for the trainig/test.
# So it will be named "subject"
# Column 2 is the activity names. So it will be named "activity"
# Column 3 onwards is the measurement data. It will be named according
# to the feature names indicated in "feature_sub".

colnames(mean_std) <- c("subject", "activity", as.character(feature_sub[,2]))
# write.table(mean_std, "./mean_std_3.txt", row.names = FALSE)

#---------------------------End Part 4------------------------------------------

#---------------------------Start Part 5----------------------------------------
# The part of the code will, from the data set in step 4, creates a second,
# independent tidy data set called "tidy_data" with the average of each variable
# for each activity and each subject.

# Files/data set required:
# 1) "mean_std" obtained in Part 4.

# Steps taken to generate the tidy data set:
# 1) calculate average of each variable (column) based on subject (column 1) and
# activity (column) of the data set "mean_std"


# assign subject and activity as a list for aggregate index.
INDEX <- list(mean_std$subject, mean_std$activity)
names(INDEX) <- c("subject", "activity") # assign names to the index

# Find the average of each variable. Results are in a convenient form
tidy_data <- aggregate(mean_std[,3:ncol(mean_std)], by = INDEX, FUN = mean)

# assign new column names after mean operation.
colnames(tidy_data) <- gsub("mean()", "Avg(mean)", colnames(tidy_data), fixed = TRUE)
colnames(tidy_data) <- gsub("std()", "Avg(std)", colnames(tidy_data), fixed = TRUE)

# write tidy data set to text file
write.table(tidy_data, "./tidy_data.txt", row.names = FALSE)

# write column names of tidy data set to text file for codebook use.
#write.table(colnames(tidy_data), "./tidy_data_var.txt",
#            row.names = FALSE, col.names = FALSE, quote = FALSE)

print("Done. Tidy Data Set (tidy_data.txt) available in your working directory")

# Remove all variables from memory
rm(list=ls())

#---------------------------End Part 5------------------------------------------