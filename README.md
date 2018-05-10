
CodeBook: lists all the measurements and provides the description of the data variables.

The run_analysis.R script will execute the following steps:

1) Download the file from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" and put the file in the data folder

2) Unzip the file. Unzipped files are in the folder "UCI HAR Dataset". The list of the files:

## files
##  [1] "activity_labels.txt"                         
##  [2] "features_info.txt"                           
##  [3] "features.txt"                                
##  [4] "README.txt"                                  
##  [5] "test/Inertial Signals/body_acc_x_test.txt"   
##  [6] "test/Inertial Signals/body_acc_y_test.txt"   
##  [7] "test/Inertial Signals/body_acc_z_test.txt"   
##  [8] "test/Inertial Signals/body_gyro_x_test.txt"  
##  [9] "test/Inertial Signals/body_gyro_y_test.txt"  
## [10] "test/Inertial Signals/body_gyro_z_test.txt"  
## [11] "test/Inertial Signals/total_acc_x_test.txt"  
## [12] "test/Inertial Signals/total_acc_y_test.txt"  
## [13] "test/Inertial Signals/total_acc_z_test.txt"  
## [14] "test/subject_test.txt"                       
## [15] "test/X_test.txt"                             
## [16] "test/y_test.txt"                             
## [17] "train/Inertial Signals/body_acc_x_train.txt" 
## [18] "train/Inertial Signals/body_acc_y_train.txt" 
## [19] "train/Inertial Signals/body_acc_z_train.txt" 
## [20] "train/Inertial Signals/body_gyro_x_train.txt"
## [21] "train/Inertial Signals/body_gyro_y_train.txt"
## [22] "train/Inertial Signals/body_gyro_z_train.txt"
## [23] "train/Inertial Signals/total_acc_x_train.txt"
## [24] "train/Inertial Signals/total_acc_y_train.txt"
## [25] "train/Inertial Signals/total_acc_z_train.txt"
## [26] "train/subject_train.txt"                     
## [27] "train/X_train.txt"                           
## [28] "train/y_train.txt"

3 Read the train and test X, Y and subject files

4. Merges the training and the test data sets to create one data set

5 Set names to variables

6 Extracts only the measurements on the mean and standard deviation for each measurement.

7 Uses descriptive activity names to name the activities in the data set

8 Appropriately labels the data set with descriptive variable names.

9 From the data set in step 4, creates a second, independent tidy data set. use library plyr

10 write the new tidy data set into file "tidydata.txt"