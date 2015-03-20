# Getting and Cleaning Data Project #
&nbsp;
### Introduction ###
This repo contains the code file "run_analysis.R" that convert Raw data obtained from UCI Machine Learning Repository
to a new set of data. The raw data set contains measurement made by a smart phone that is attached to a human subject
while the subject is performing various activities as listed below:

1. WALKING
2. WALKING UPSTAIRS
3. WALKING DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

&nbsp;

The following files are in this repo:

1. README.md (this file) - Describe what this repo is all about.
2. run_analysis.R - Code that convert some raw data to tidy data set
3) cookbook.md - Describe in details how the raw data are converted to tidy data, and the details of each variables.

&nbsp;

To run the code, simply copy the code file "run_analysis.R".into your PC and type  
[source("<Drive>:/<Directory>/run_analysis.R")] in the R environment without the [].
For example, if the code is downloaded into the C: drive root directory,  
then run the code by typing [source("C:/run_analysis.R")]

&nbsp;

### Data Source ###
The raw data is obtained from UCI Machine Learning Repository.  
The general link is http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.  
The exact link (for project purpose) is https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

&nbsp;

### Important Note on the Raw Dataset "Dataset.zip" ###


For more information about this dataset, please contact: activityrecognition@smartlab.ws  

&nbsp;

**_License:_**

Use of this dataset in publications must be acknowledged by referencing the following publication [1]  

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.  
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.  
International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.  
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors  
or their institutions for its use or misuse. Any commercial use is prohibited.  
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

&nbsp;

### Data Transformation ###
The code first extracts the means and standard deviation related measurement (variable) from the raw data.
It then calculate the average of each variable for each activity and each subject.

&nbsp;

### Output ###
The output is a tidy data set, sorted according to subject and activities, and each subject/activity pair
will have corresponding variables set of the calulated averages.


Refer to cookbook.md for the details of how the data transformation was performed and the details of each variable.
