
##Download the file and put the file in the data folder

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",mode="wb")

##Unzip the file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

##unzipped files are in the folder "UCI HAR Dataset". Get the list of the files

path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
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

## Read the train and test Y iles
dataYTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataYTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)

## Read the train and test X iles
dataXTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataXTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)


## Read the train and test Subject iles
dataSTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt" ),header = FALSE)
dataSTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)

## 1. Merges the training and the test data sets to create one data set
## Concatenate the data tables by rows
dataSubject <- rbind(dataSTrain, dataSTest)
dataActivity<- rbind(dataYTrain, dataYTest)
dataFeatures<- rbind(dataXTrain, dataXTest)

## Set names to variables
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

## Merge columns to get the data frame Data for all data
dataCombine <- cbind(dataSubject, dataActivity,dataFeatures)

## 2 Extracts only the measurements on the mean and standard deviation for each measurement.
## taken Names of Features with "mean" or "std"
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
## Subset the data frame Data by seleted names of Features
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
subsetData<-subset(dataCombine,select=selectedNames)

## 3 Uses descriptive activity names to name the activities in the data set
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)
subsetData$activity <- factor(subsetData$activity, 
                                 levels = activityLabels[, 1], labels = activityLabels[, 2])

## 4 Appropriately labels the data set with descriptive variable names.
names(subsetData)<-gsub("^t", "time", names(subsetData))
names(subsetData)<-gsub("^f", "frequency", names(subsetData))
names(subsetData)<-gsub("Acc", "Accelerometer", names(subsetData))
names(subsetData)<-gsub("Gyro", "Gyroscope", names(subsetData))
names(subsetData)<-gsub("Mag", "Magnitude", names(subsetData))
names(subsetData)<-gsub("BodyBody", "Body", names(subsetData))

## 5 From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
library(plyr);
Data2<-aggregate(. ~subject + activity, subsetData, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
names(Data2)<-gsub("-mean\\(\\)-", "Mean", names(Data2))
names(Data2)<-gsub("-std\\(\\)-", "Std", names(Data2))
names(Data2)<-gsub("-mean\\(\\)", "Mean", names(Data2))
names(Data2)<-gsub("-std\\(\\)", "Std", names(Data2))

write.table(Data2, file = "tidydata.txt",row.name = FALSE)str()