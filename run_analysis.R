setwd("~/R/cleaningdata/")
library("data.table")

##Read train data set & features file that contains transposed column names of the dataset
df_train    <- read.table("UCI HAR Dataset/train/X_train.txt",  colClasses="numeric")
df_features <- read.table("UCI HAR Dataset/features.txt", colClasses = "character")
#apply the values from features as column names of the train data set
for (x in 1:length(df_train)) {colnames(df_train)[x] <- df_features[x,2]}
##Reshape train dataset to only include mean and std measurements
df_train  <- df_train[grepl('mean\\(|std', names(df_train))]
##Read train subject and activity info (y) 
df_trains <- read.table("UCI HAR Dataset/train/subject_train.txt",colClasses="integer")
df_trainy <- read.table("UCI HAR Dataset/train/Y_train.txt", colClasses="numeric")
##Combine the subject, y (activity), and x files into one row
df_train  <- cbind(df_trains, df_trainy, df_train)

##Do the same for the test data set
df_test    <- read.table("UCI HAR Dataset/test/X_test.txt",colClasses="numeric")
for (x in 1:length(df_test)) {colnames(df_test)[x] <- df_features[x,2]}
df_test  <- df_test[grepl('mean\\(|std', names(df_test))]
df_tests <- read.table("UCI HAR Dataset/test/subject_test.txt",colClasses="integer")
df_testy <- read.table("UCI HAR Dataset/test/Y_test.txt",colClasses="numeric")
df_test  <- cbind(df_tests, df_testy, df_test)

##Merges the training and the test sets to create one data set.
df_merge <- rbind(df_test, df_train)

##remove () and _ from all columns
##replace with "." and ""
#add column names for subjects and activity
colnames(df_merge)[1] <- 'subject'
colnames(df_merge)[2] <- 'activity'
colnames(df_merge) <- gsub("-",".",colnames(df_merge))
colnames(df_merge) <- gsub("\\(\\)","",colnames(df_merge))



##Uses descriptive activity names to name the activities in the data set
dt_labels <-as.data.table(read.table("C:/Users/mzmolly/Documents/r/cleaningdata/UCI HAR Dataset/activity_labels.txt"))
##Appropriately labels the data set with descriptive variable names. 
df_merge$activity <-dt_labels$V2[match(df_merge$activity, dt_labels$V1)]

#2nd dataset with mean of each activity / subject
dt_tidy <- as.data.table(df_merge)
#.sd is an object referencing all columns not in the by list
dt_tidy <- dt_tidy[, lapply(.SD, mean), by = list(subject,activity)]
#sort the dataframe
dt_tidy <- dt_tidy[order(dt_tidy$subject,dt_tidy$activity),]
#write datatable to comma separated text file
write.table(dt_tidy, "C:/Users/mzmolly/Documents/r/cleaningdata/tidy_dataset.txt", sep=",")

##cleanup dataframes no longer needed
rm(df_test,df_tests,df_testy,df_train,df_trains,df_trainy, df_features, dt_labels, x)

