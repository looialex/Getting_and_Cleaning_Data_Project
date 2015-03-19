# Getting_and_Cleaning_Data_Project

This README.txt file describes the steps of how the code "run_analysis.R" obtained the tidy data "tidy_data.txt" set from the raw data.


### Project Objective ###

The goal of this code "run_analysis.R" is to prepare tidy data that can be used for later analysis.


### Data Source ###

This code will first check if the required data file "Dataset.zip" is in the working directory or not.
If it is not, it will download the file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
into the working directory and unzip the file. If the file "Dataset.zip" already exist in the working directory, it skip
the download step and proceed to unzip the file.


### Important Note on the Raw Dataset "Dataset.zip" ###

For more information about this dataset, please contact: activityrecognition@smartlab.ws

**_License:_** 
Use of this dataset in publications must be acknowledged by referencing the following publication [1]  
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.  
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.  
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


### Code Sequence ###
The code will perform the following task:

1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.  
3. Uses descriptive activity names to name the activities in the data set.  
4. Appropriately labels the data set with descriptive variable names.  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### Step 1: Merging Data ###
The part of the code Merges the training and the test sets to create one data set called "combine_data"

Based on README.txt that comes with the raw dataset, Training set = train/X_train.txt, Test set = test/X_test.txt.
The necessary files in the Raw data that are necessary for the merging are:

#### Training Data Set ####

1. subject_train.txt: Each row contains the the subject identifier that took part in the training (range 1 - 30).
2. X_train.txt: Training data set. Each row represent the data collected for each subject. Each column represent the data collect from each of the features in the feature list.
3. y_train.txt: Training labels - Tag each row of training data to the activity numbers in the activity_labels. (range 1 - 6)

#### Test Data Set ####

1. subject_test.txt: Each row contains the the subject identifier that took part in the test (range 1 - 30).
2. X_test.txt: Test data set. Each row represent the data collected for each subject.
Each column represent the data collect from each of the features in the feature list.
3. y_test.txt: Test labels - Tag each row of test data to the activity numbers in the activity_labels. (range 1 - 6)

#### Steps taken to Merges the data: ####

1. Read in training data files: subject_train.txt, X_train.txt, y_train.txt.
2. Read in test data files: subject_test.txt, X_test.txt, y_test.txt,
3. Combine (column wise) "subject_train", "y_train", "X_train" to get the merged training data set.
4. Repeat step 3 to 8 with the test sets to get the merged test data set.
5. Merge the training and test data set (row wise) to get "combine_data"


### Step 2: Extracts mean and standard deviation ###
The part of the code extracts from "combine_data" only the measurements on the mean and standard deviation for each measurement,
and store the extracted data into a new data set "mean_std"

#### Files/data set required: ####

1. features.txt: Tag each column in the training/test set to a feature. eg column 1 is tBodyAcc-mean()-X. Total 561 features
The feature list will tell us whether the measurement is mean/std dev or not.
2. "combine_data" obtained in Part 1.

#### Steps taken to extract the mean/std dev from the data:####

1. Read in feature list file: features.txt
2. Extract from the feature list, the corresponding column number in the data set that contains the mean and std dev measurement.
The search criteria used are "mean()" and "std" as stated in the features_info.txt.
3. Extract from "combine_data" the mean and std dev measurement based on the column numbers obtained from step 2) using the function grep().


### Step 3: Name the activities in the data set. ###
The part of the code uses descriptive activity names to name the activities in the data set. The activities labels are in column 2 of the data set
"mean_std" obtained in Part 2. The code will match the label to the actual activity names in the file activity_labels.txt using the function match(),
and overwrite the label with the actual names. The output of this part of the code will still be "mean_std" data set.  


#### Files/data set required: ####
1. activity_labels.txt: Tag activity number to actual activity. eg activity 1 is WALKING.
2. "mean_std" obtained in Part 1.


### Step 4: Labels the data set with descriptive variable names. ###
The part of the code will appropriately labels the data set "mean_std" with descriptive variable names.

#### Files/data set required: ####
1. "mean_std" obtained in Part 3.
2. "feature_sub" which contains the feature names of each measurment n the data set "mean_std".

##### Variable Names #####

1. Column 1 of data set indicates the subject that went for the trainig/test. So it will be named "subject"
2. Column 2 is the activity names. So it will be named "activity"
3. Column 3 onwards is the measurement data. It will be named according to the feature names indicated in "feature_sub".


### Step 5: Creating tidy data set. ###
The part of the code will, from the data set in step 4, creates a second,
independent tidy data set called "tidy_data" with the average of each variable for each activity and each subject.

#### Files/data set required: ####

1. "mean_std" obtained in Part 4.

#### Steps taken to generate the tidy data set: ####
1. Calculate average of each variable (column) based on subject (column 1) and activity (column) of the data set "mean_std"
using aggregate() with function mean(), using "subject" and "activity" as index.
2. Write the tidy data set to a text file "tidy_data.txt" with row.names = FALSE


### Final Step: Freeing up memory ###
Variables that are not required anymore are removed from the memory using rm() function.


### Output ###
Tidy data set which follows the principles:
1. Each variable is in one column,
2. Each different observation should be in different row.
3. One table for each kind of variable.

The tidy data set "tidy_data.txt" contains the following data:
1. 180 rows (observations)
2. 68 columns of which:
  1. Column 1 contains the subject ID.
  2. Column 2 contains the activity performed by the subject when the data is collected.
  3. Column 3 to 68 containst the actual 66 different variables.
