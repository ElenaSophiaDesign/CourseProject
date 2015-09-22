==================================================================
#	Coursera Getting and Cleaning Data Course Project
###	Submitted by Elena Karzhitsky
###	September 2015
==================================================================

Data for the project comes from the Human Activity Recognition Using Smartphones Data Set.  A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

You can find complete data set in

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. These measurements were used to estimate 17 variables capturing different body movements characteristics.  The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

17 defferent types of statistics were estimated fror these measurements.  For the purposes of this project only the following three statitics were included in the final data set:

- mean(): Mean value
- std(): Standard deviation
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency



The R script reads unzipped Human Activity Recognition Using Smartphones data files saved in working directory in **/UCI HAR Dataset** folder.
-  files **features.txt** and **activity_labels.txt** are saved in the root directory, 
-  files **x_test.txt, subject_test, y_test** and **x_train.txt, subject_train, y_train** are saved in corresponding **/test** and **/train** subdirectories

1.	While in the working directory read in **features** table and **activity labels** lookup vector.
2.	First work with the test subset of the data.  
	- move in the **/test** subdirectory
	- read the **X-test.txt** file in a data frame
	- add the variable names using the **features** vector 
	- with the **activity labels** vector subset the data frame to include only variable with **mean** (including **meanFreg**) and **std** in their names
	- merge activity names, subjects (tests participants IDs), and limited data frame together
3.	Saved results in R data file **HumanActivityRecognition.RDA** in the working directory.  To avoid memory problems all test specific data objects are removed.  

Next the logic from the second step above is applied to the train data subset: 
	- move in the /train subdirectory
	- read the **X-train.txt** file in a data frame
	- etc.
The train results are appended to the file **HumanActivityRecognition.RDA** created in step 3 above.  Again, all unnecessary data objects are removed.

Finally to create text file for the **project step 5** I read the data set from my computer back into R and calculate average of each variable for each activity and each subject.  after deleting fileName variable that was storing source of the data, *test* versus *train*.  The **melt** function was applied to re-arrange data in accordance with the **tidy data pinciples**: one variable per column, with the variable names stored in the rows.  Resulting file contains 14,220 rows and 5 variables.  