datacleaning_classproj
======================

This is the repo for the datacleaning class course project.  This repo contains an r script named run_analysis that reads the processes the data from the UCI HAR Dataset and creates a tidy data set.  This script assumes the UCI Har Dataset is in in the current working directory.

The script then:

1. Reads into a separate dataframes the subject,activity and measurements for test data
2. Adds the column names from the features file to the measurement dataframe created in step 1
3. Removes all measurement columns from dataframe that do not have mean( or std in their title.  This isolates the        m    measurements that are for mean and for standard deviation.  If you do not use the mean( it will pick up unwanted columns.
4. Merges the subject, activity, and measurement datafarmes for the test data into one dataframe
5. Repeat steps 1-4 for the train data set
6. Merge test and train datasets into one dataframe
7. Adds column names for the subject and activity data (activity column names found in activity labels file
8. Strips out all () and _ from the column names and replaces them . and "" respectively
9. Create a tidydata.txt file that finds the mean of the measurements grouped by subject and activity

 
