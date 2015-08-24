==================================================================
##	Elena Karzhitsky
##	Coursera Getting and Cleaning Data Course Project
==================================================================

##Data source is the Human Activity Recognition Using Smartphones Data Set. For the purpose of this project only mean (including meanFreq) and standard deviation ##variables were included in the final data set; the final results comprise average of each variable for each activity and each subject.  The output is formatted ##according to tidy data principles. 

This code reads unzipped Human Activity Recognition Using Smartphones data files saved in woring directory in /UCI HAR Dataset folder:\
-  file features.txt is saved in the root directory, 
-  files x_test.txt, subject_test, y_test and x_train.txt, subject_train, y_train are saved in corresponding /test and /train subdirectories

First I work with the test subset of our data: I read in features table and creat activity lookup vector while in the working directory since they are apply to both test and train data sets.  Next I work with the test data set: read the data in a data frame, add the variable names using the features vector and subset the data frame to include only variable with mean (including meanFreg) and std in their names.  Finally, I merge activity names, subjects (tests participants IDs), and limited data frame together.  Results are saved as R data file in my working directory to avoid memory problems, and all test specific data objects are removed.  Next the same steps are applied to the train data subset, and the results are appended to the file with the test data output.  Again, all unnecessary data objects are removed.

Finally, I read the data set from my computer back into R and calculate average of each variable for each activity and each subject.  To do it properly I deleted fileName variable that was storing source of the data, test versus train.  Finally, the melt function re-arranged the data set according to the tidy data pinciples: one variable per column, with the variable names stored in the rows. 


