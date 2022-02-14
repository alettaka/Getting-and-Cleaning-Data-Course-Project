# This script runs an analysis on the dataset containing data collected from the
# accelerometers from the Samsung Galaxy S smartphone retrieved here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# To run the script, unpack the datafiles, preserving the directory structure. 
# Copy the R script into the 'UCI HAR Dataset' directory, and set the 
# R workdirectory to the 'UCI HAR Dataset' directory

library(data.table)
library(plyr)
library(dplyr)
library(tidyr)

# Loading the required data files
test_x <- fread("test/X_test.txt", sep = " ")
test_x <- fread("test/X_test.txt", sep = " ")
test_y <- fread("test/y_test.txt", sep = " ")
test_subject <- fread("test/subject_test.txt", sep = " ")
train_x <- fread("train/X_train.txt", sep = " ")
train_y <- fread("train/y_train.txt", sep = " ")
train_subject <- fread("train/subject_train.txt", sep = " ")

#combine train and test datasets

all_x <- rbind(train_x, test_x)
all_y<- rbind(train_y, test_y)
all_subject <- rbind(train_subject, test_subject)

#Set column names based on the features text file

column_names <- fread("features.txt", sep = " ")
all_x <- setNames(all_x, unlist(column_names[,2]))

# Extract only the mean and standard deviation for each measurement.
mean_std_x <- select(all_x, matches("mean|std"))

#rename the y set to "Activity", and the subject set to "Subject"

setnames(all_y, names(all_y), "Activity")
setnames(all_subject, names(all_subject), "Subject")

#Combine the Subject and Activity columns with the Measurement data

accelometer_data <- cbind(all_subject, all_y, all_x)

#Change the subject id's to factor
accelometer_data$Subject <- as.factor(accelometer_data$Subject)

#Change the activity values to factor and mutate these to descriptive names
accelometer_data$Activity <- as.factor(accelometer_data$Activity)
accelometer_data$Activity <- recode_factor(accelometer_data$Activity, 
                                           "1" = "WALKING", 
                                           "2" = "WALKING_UPSTAIRS", 
                                           "3" = "WALKING_DOWNSTAIRS", 
                                           "4" = "SITTING", 
                                           "5" =  "STANDING", 
                                           "6" = "LAYING")

#creating a second, independent tidy data set from the accelometer_data dataset, 
#with the average of each variable for each activity and each subject.

# Use plyr to melt() the dataframe into long form  and split apply with 
# ddply() to get the means
accelometer_sum1 <-ddply(melt(accelometer_data, id.vars=c("Subject", "Activity")), 
                         .(Subject, Activity, variable), summarize, MeanSamples=mean(value))
# Make it tidy using spread() into a wide format so that each observation is a row
# and each variable is a column.
accelometer_summary <- spread(accelometer_sum1, variable, MeanSamples)
# generate an independent tidy dataset by writing the dataframe to a .csv file
write.table(accelometer_summary, "tidy_accelometer_summary.csv", row.name=FALSE)
```


