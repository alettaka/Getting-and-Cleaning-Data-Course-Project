# Getting-and-Cleaning-Data-Course-Project
Prepare tidy data that can be used for later analysis on data collected from the accelerometers from the Samsung Galaxy S smartphone

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
The data linked below represents data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The R script run_analysis.R in this repository does the following. 
    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names. 
    5. From the data set created in step 4, a second, independent tidy data set with the average of 
    each variable for each activity and each subject is created, and saved as tidy_accelometer_summary.csv.

To run the script, unpack the datafiles, preserving the directory structure. 
Copy the R script into the 'UCI HAR Dataset' directory, and set the 
R workdirectory to the 'UCI HAR Dataset' directory

