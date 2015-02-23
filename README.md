# GetCleanData
Coursera Get and lean Data course

Getting and Cleaning Data Course Project 
===========

A description of the raw data is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following: 
 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 


Data structure
====================



### The tidy data set

The general principles of tidy data are laid out by [Hadley Wickham](http://had.co.nz/) in [this paper](http://vita.had.co.nz/papers/tidy-data.pdf)
and [this video](http://vimeo.com/33727555). The paper and the video are both focused on the [R](http://www.r-project.org/) package, which you
may or may not know how to use. Regardless the four general principles you should pay attention to are:

1. Each variable you measure should be in one column
1. Each different observation of that variable should be in a different row
1. There should be one table for each "kind" of variable
1. If you have multiple tables, they should include a column in the table that allows them to be linked



### The code book

For almost any data set, the measurements you calculate will need to be described in more detail than you will sneak
into the spreadsheet. The code book contains this information. At minimum it should contain:

1. Information about the variables (including units!) in the data set not contained in the tidy data 
1. Information about the summary choices you made
1. Information about the experimental study design you used


### The original data

Each record has 561 fields. There are several blocks of related data

* 5 blocks of 40 fileds
  + tBodyAcc-XYZ
  + tGravityAcc-XYZ
  + tBodyAccJerk-XYZ
  + tBodyGyro-XYZ
  + tBodyGyroJerk-XYZ
  
* 5 blocks of 13 fields
  + tBodyAccMag
  + tGravityAccMag
  + tBodyAccJerkMag
  + tBodyGyroMag
  + tBodyGyroJerkMag
  
* 3 blocks of 79 fields
  + fBodyAcc-XYZ
  + fBodyAccJerk-XYZ
  + fBodyGyro-XYZ
  
* 4 blocks of 13 fields
  + fBodyAccMag
  + fBodyAccJerkMag
  + fBodyGyroMag
  + fBodyGyroJerkMag

* 1 block of 7 fields
  + angle
  
  

