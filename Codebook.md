# Code book for "run_analysis.R #
This code book describes the variables, the data, and any transformations
or work that is performed to get the tidy data set in "tidy_data.txt"

It also contains the following section:

1. Data transformation - Steps of how the raw data is transformed into the tidy data.
2. Code book - Description of each variables

&nbsp;

## Section: Data Transformation ##
This section describes where the raw data is obtained, and what is done to the raw data to get the tidy data.  
It also describes the seqence of the code in "run_analysis.R".  
The output is a tidy data set of 180 observations (rows) with 68 columns (1 for subject identification, 1 for activity taken,  
and 66 variables. The tidy data set is sorted according to subject and activities, and each subject/activity pair  
will have corresponding variables set of the calulated averages.


### Data Source ###

This code will first check if the required data file "Dataset.zip" is in the working directory or not.
If it is not, it will download the file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
into the working directory and unzip the file. If the file "Dataset.zip" already exist in the working directory, it skip
the download step and proceed to unzip the file.


### Code Sequence ###
The code will perform the following task:

1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.  
3. Uses descriptive activity names to name the activities in the data set.  
4. Appropriately labels the data set with descriptive variable names.  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

&nbsp;

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

&nbsp;

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

&nbsp;

### Step 3: Name the activities in the data set. ###
The part of the code uses descriptive activity names to name the activities in the data set. The activities labels are in column 2 of the data set
"mean_std" obtained in Part 2. The code will match the label to the actual activity names in the file activity_labels.txt using the function match(),
and overwrite the label with the actual names. The output of this part of the code will still be "mean_std" data set.  


#### Files/data set required: ####
1. activity_labels.txt: Tag activity number to actual activity. eg activity 1 is WALKING.
2. "mean_std" obtained in Part 1.

&nbsp;

### Step 4: Labels the data set with descriptive variable names. ###
The part of the code will appropriately labels the data set "mean_std" with descriptive variable names.

#### Files/data set required: ####
1. "mean_std" obtained in Part 3.
2. "feature_sub" which contains the feature names of each measurment n the data set "mean_std".

##### Variable Names #####

1. Column 1 of data set indicates the subject that went for the trainig/test. So it will be named "subject"
2. Column 2 is the activity names. So it will be named "activity"
3. Column 3 onwards is the measurement data. It will be named according to the feature names indicated in "feature_sub".

&nbsp;

### Step 5: Creating tidy data set. ###
The part of the code will, from the data set in step 4, creates a second,
independent tidy data set called "tidy_data" with the average of each variable for each activity and each subject.

#### Files/data set required: ####

1. "mean_std" obtained in Part 4.

#### Steps taken to generate the tidy data set: ####
1. Calculate average of each variable (column) based on subject (column 1) and activity (column) of the data set "mean_std"
using aggregate() with function mean(), using "subject" and "activity" as index.
2. Write the tidy data set to a text file "tidy_data.txt" with row.names = FALSE

&nbsp;

### Final Step: Freeing up memory ###
Variables that are not required anymore are removed from the memory using rm() function.

&nbsp;

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

## End Section: Data Transformation ##

&nbsp;

## Section: Code Book ##
This section describes each variable and its units.  
There are a totoal of 180 observations (rows).  
Each observation contains 1 subject id, 1 action type, and 66 measurements (68 columns)


The format of the variable information will be as follows:  
[Variable Name, type]  
	[Variable Description]  
		[Range or possible value]


1. subject, int  
	Subject identifier that identify from which subject  
	(i.e. from who) is the data obtained from.  
		1 - 30
			
2. activity, Factor with 6 levels  
	The type of activity the subject is performing when the data is collected.
		LAYING
		SITTING
		STANDING
		WALKING
		WALKING_DOWNSTAIRS
		WALKING_UPSTAIRS

3. tBodyAcc-Avg(mean)-X, numeric  
	Average of the mean Body Acceleration in time domain, X-axis  
		Normalized and bounded within [-1,1]

4. tBodyAcc-Avg(mean)-Y, numeric  
	Average of the mean Body Acceleration in time domain, Y-axis  
		Normalized and bounded within [-1,1]

5. tBodyAcc-Avg(mean)-Z, numeric  
	Average of the mean Body Acceleration in time domain, Z-axis  
		Normalized and bounded within [-1,1]

6. tBodyAcc-Avg(std)-X, numeric  
	Average of the Standard Deviation of Body Acceleration in time domain, X-axis  
		Normalized and bounded within [-1,1]

7. tBodyAcc-Avg(std)-Y, numeric  
	Average of the Standard Deviation of Body Acceleration in time domain, Y-axis  
		Normalized and bounded within [-1,1]

8. tBodyAcc-Avg(std)-Z, numeric  
	Average of the Standard Deviation of Body Acceleration in time domain, Z-axis  
		Normalized and bounded within [-1,1]

9. tGravityAcc-Avg(mean)-X, numeric  
	Average of the mean of Gravity Acceleration in time domain, X-axis  
		Normalized and bounded within [-1,1]

10. tGravityAcc-Avg(mean)-Y, numeric  
	Average of the mean of Gravity Acceleration in time domain, Y-axis  
		Normalized and bounded within [-1,1]

11. tGravityAcc-Avg(mean)-Z, numeric  
	Average of the mean of Gravity Acceleration in time domain, Z-axis  
		Normalized and bounded within [-1,1]

12. tGravityAcc-Avg(std)-X, numeric  
	Average of the Standard Deviation of Gravity Acceleration in time domain, X-axis  
		Normalized and bounded within [-1,1]

13. tGravityAcc-Avg(std)-Y, numeric  
	Average of the Standard Deviation of Gravity Acceleration in time domain, Y-axis  
		Normalized and bounded within [-1,1]

14. tGravityAcc-Avg(std)-Z, numeric  
	Average of the Standard Deviation of Gravity Acceleration in time domain, Z-axis  
		Normalized and bounded within [-1,1]

15. tBodyAccJerk-Avg(mean)-X, numeric  
	Average of the mean of Jerk in Body Acceleration in time domain, X-axis  
		Normalized and bounded within [-1,1]

16. tBodyAccJerk-Avg(mean)-Y, numeric  
	Average of the mean of Jerk in Body Acceleration in time domain, Y-axis  
		Normalized and bounded within [-1,1]

17. tBodyAccJerk-Avg(mean)-Z, numeric  
	Average of the mean of Jerk in Body Acceleration in time domain, Z-axis  
		Normalized and bounded within [-1,1]

18. tBodyAccJerk-Avg(std)-X, numeric  
	Average of the Standard Deviation of Jerk in Body Acceleration in time domain, X-axis  
		Normalized and bounded within [-1,1]

19. tBodyAccJerk-Avg(std)-Y, numeric  
	Average of the Standard Deviation of Jerk in Body Acceleration in time domain, Y-axis  
		Normalized and bounded within [-1,1]

20. tBodyAccJerk-Avg(std)-Z, numeric  
	Average of the Standard Deviation of Jerk in Body Acceleration in time domain, Z-axis  
		Normalized and bounded within [-1,1]

21. tBodyGyro-Avg(mean)-X, numeric  
	Average of the mean of Body Gyro in time domain, X-axis  
		Normalized and bounded within [-1,1]

22. tBodyGyro-Avg(mean)-Y, numeric  
	Average of the mean of Body Gyro in time domain, Y-axis  
		Normalized and bounded within [-1,1]

23. tBodyGyro-Avg(mean)-Z, numeric  
	Average of the mean of Body Gyro in time domain, Z-axis  
		Normalized and bounded within [-1,1]

24. tBodyGyro-Avg(std)-X, numeric  
	Average of the Standard Deviation of Body Gyro in time domain, X-axis  
		Normalized and bounded within [-1,1]

25. tBodyGyro-Avg(std)-Y, numeric  
	Average of the Standard Deviation of Body Gyro in time domain, Y-axis  
		Normalized and bounded within [-1,1]

26. tBodyGyro-Avg(std)-Z, numeric  
	Average of the Standard Deviation of Body Gyro in time domain, Z-axis  
		Normalized and bounded within [-1,1]

27. tBodyGyroJerk-Avg(mean)-X, numeric  
	Average of the mean of Jerk in Body Gyro in time domain, X-axis  
		Normalized and bounded within [-1,1]

28. tBodyGyroJerk-Avg(mean)-Y, numeric  
	Average of the mean of Jerk in Body Gyro in time domain, Y-axis  
		Normalized and bounded within [-1,1]

29. tBodyGyroJerk-Avg(mean)-Z, numeric  
	Average of the mean of Jerk in Body Gyro in time domain, Z-axis  
		Normalized and bounded within [-1,1]

30. tBodyGyroJerk-Avg(std)-X, numeric  
	Average of the Standard Deviation of Jerk in Body Gyro in time domain, X-axis  
		Normalized and bounded within [-1,1]

31. tBodyGyroJerk-Avg(std)-Y, numeric  
	Average of the Standard Deviation of Jerk in Body Gyro in time domain, Y-axis  
		Normalized and bounded within [-1,1]

32. tBodyGyroJerk-Avg(std)-Z, numeric  
	Average of the Standard Deviation of Jerk in Body Gyro in time domain, Z-axis  
		Normalized and bounded within [-1,1]

33. tBodyAccMag-Avg(mean), numeric  
	Average of the mean of Body Acceleration Magnitude in time domain  
		Normalized and bounded within [-1,1]

34. tBodyAccMag-Avg(std), numeric  
	Average of the Standard Deviation of Body Acceleration Magnitude in time domain  
		Normalized and bounded within [-1,1]

35. tGravityAccMag-Avg(mean), numeric  
	Average of the mean of Gravitiy Acceleration Magnitude in time domain  
		Normalized and bounded within [-1,1]

36. tGravityAccMag-Avg(std), numeric  
	Average of the Standard Deviation of Gravitiy Acceleration Magnitude in time domain  
		Normalized and bounded within [-1,1]

37. tBodyAccJerkMag-Avg(mean), numeric  
	Average of the mean of Magnitude of Jerk in Body Acceleration in time domain  
		Normalized and bounded within [-1,1]

38. tBodyAccJerkMag-Avg(std), numeric  
	Average of the Standard Deviation of Magnitude of Jerk in Body Acceleration in time domain  
		Normalized and bounded within [-1,1]

39. tBodyGyroMag-Avg(mean), numeric  
	Average of the mean of Body Gyro Magnitude in time domain  
		Normalized and bounded within [-1,1]

40. tBodyGyroMag-Avg(std), numeric  
	Average of the Standard Deviation of Body Gyro Magnitude in time domain  
		Normalized and bounded within [-1,1]

41. tBodyGyroJerkMag-Avg(mean), numeric  
	Average of the mean of Magnitude of Jerk in Body Gyro in time domain  
		Normalized and bounded within [-1,1]

42. tBodyGyroJerkMag-Avg(std), numeric  
	Average of the Standard Deviation of Magnitude of Jerk in Body Gyro in time domain  
		Normalized and bounded within [-1,1]

43. fBodyAcc-Avg(mean)-X, numeric  
	Average of the mean Body Acceleration in freq domain, X-axis  
		Normalized and bounded within [-1,1]

44. fBodyAcc-Avg(mean)-Y, numeric  
	Average of the mean Body Acceleration in freq domain, Y-axis  
		Normalized and bounded within [-1,1]

45. fBodyAcc-Avg(mean)-Z, numeric  
	Average of the mean Body Acceleration in freq domain, Y-axis  
		Normalized and bounded within [-1,1]

46. fBodyAcc-Avg(std)-X, numeric  
	Average of the Standard Deviation of Body Acceleration in freq domain, X-axis  
		Normalized and bounded within [-1,1]

47. fBodyAcc-Avg(std)-Y, numeric  
	Average of the Standard Deviation of Body Acceleration in freq domain, Y-axis  
		Normalized and bounded within [-1,1]

48. fBodyAcc-Avg(std)-Z, numeric  
	Average of the Standard Deviation of Body Acceleration in freq domain, Z-axis  
		Normalized and bounded within [-1,1]

49. fBodyAccJerk-Avg(mean)-X, numeric  
	Average of the mean of Jerk in Body Acceleration in freq domain, X-axis  
		Normalized and bounded within [-1,1]

50. fBodyAccJerk-Avg(mean)-Y, numeric  
	Average of the mean of Jerk in Body Acceleration in freq domain, Y-axis  
		Normalized and bounded within [-1,1]

51. fBodyAccJerk-Avg(mean)-Z, numeric  
	Average of the mean of Jerk in Body Acceleration in freq domain, Z-axis  
		Normalized and bounded within [-1,1]

52. fBodyAccJerk-Avg(std)-X, numeric  
	Average of the Standard Deviation of Jerk in Body Acceleration in freq domain, X-axis  
		Normalized and bounded within [-1,1]

53. fBodyAccJerk-Avg(std)-Y, numeric  
	Average of the Standard Deviation of Jerk in Body Acceleration in freq domain, Y-axis  
		Normalized and bounded within [-1,1]

54. fBodyAccJerk-Avg(std)-Z, numeric  
	Average of the Standard Deviation of Jerk in Body Acceleration in freq domain, Z-axis  
		Normalized and bounded within [-1,1]

55. fBodyGyro-Avg(mean)-X, numeric  
	Average of the mean of Body Gyro in freq domain, X-axis  
		Normalized and bounded within [-1,1]

56. fBodyGyro-Avg(mean)-Y, numeric  
	Average of the mean of Body Gyro in freq domain, Y-axis  
		Normalized and bounded within [-1,1]

57. fBodyGyro-Avg(mean)-Z, numeric  
	Average of the mean of Body Gyro in freq domain, Z-axis  
		Normalized and bounded within [-1,1]

58. fBodyGyro-Avg(std)-X, numeric  
	Average of the Standard Deviation of Body Gyro in freq domain, X-axis  
		Normalized and bounded within [-1,1]

59. fBodyGyro-Avg(std)-Y, numeric  
	Average of the Standard Deviation of Body Gyro in freq domain, Y-axis  
		Normalized and bounded within [-1,1]

60. fBodyGyro-Avg(std)-Z, numeric  
	Average of the Standard Deviation of Body Gyro in freq domain, Z-axis  
		Normalized and bounded within [-1,1]

61. fBodyAccMag-Avg(mean), numeric  
	Average of the mean of Body Acceleration Magnitude in freq domain  
		Normalized and bounded within [-1,1]

62. fBodyAccMag-Avg(std), numeric  
	Average of the Standard Deviation of Body Acceleration Magnitude in freq domain  
		Normalized and bounded within [-1,1]

63. fBodyBodyAccJerkMag-Avg(mean), numeric  
	Average of the mean of Magnitude of Jerk in Body Acceleration in freq domain  
		Normalized and bounded within [-1,1]

64. fBodyBodyAccJerkMag-Avg(std), numeric  
	Average of the Standard Deviation of Magnitude of Jerk in Body Acceleration in freq domain  
		Normalized and bounded within [-1,1]

65. fBodyBodyGyroMag-Avg(mean), numeric  
	Average of the mean of Body Gyro Magnitude in freq domain  
		Normalized and bounded within [-1,1]

66. fBodyBodyGyroMag-Avg(std), numeric  
	Average of the Standard Deviation of Body Gyro Magnitude in freq domain  
		Normalized and bounded within [-1,1]

67. fBodyBodyGyroJerkMag-Avg(mean), numeric  
	Average of the mean of Magnitude of Jerk in Body Gyro in freq domain  
		Normalized and bounded within [-1,1]

68. fBodyBodyGyroJerkMag-Avg(std), numeric  
	Average of the Standard Deviation of Magnitude of Jerk in Body Gyro in freq domain  
		Normalized and bounded within [-1,1]

## End Section: Code Book ##
