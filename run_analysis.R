##  This code reads unzipped files saved in /UCI HAR Dataset folder:
##  file features.txt is saved in the root directory, 
##  files x_test.txt, subject_test, y_test and x_train.txt, subject_train, y_train 
##  are saved in corresponding /test and /train subdirectories

##  read in features table and create activity lookup vector

setwd("./UCI HAR Dataset/")
features <- read.table("features.txt")
featuresAll <- c(grep("mean()", features$V2), grep("std()", features$V2))
activityLkUp <- c("1" = "WALKING", "2" = "WALKING_UPSTAIRS", "3" = "WALKING_DOWNSTAIRS", "4" = "SITTING", 
                  "5" = "STANDING", "6" = "LAYING")
##  read in test data
setwd("./test")
x_test <- read.table("x_test.txt", stringsAsFactors = FALSE)

##  add column names and keep only columns with names including 'mean' or 'std'  
names(x_test) <- features[[2]]
x_testSubset <- x_test[, featuresAll]

##  read in subject and activity vectors
subject_test <- read.table("subject_test.txt", stringsAsFactors = TRUE, col.names = "subject")
activity_test <- read.table("y_test.txt", stringsAsFactors = TRUE, col.names = "activityID")
activity_test$activity <- activityLkUp[activity_test$activityID]
activity_test$activityID <- NULL

##  combine all test data
fileName <- c("test")
testAll <- cbind(fileName, subject_test, activity_test, x_testSubset)

##  write results in a file in root directory, remove unnecessary test files
setwd("../")
write.table(testAll, file = "HumanActivityRecognition.RDA", append = FALSE, col.names = TRUE, row.names = FALSE)
rm(x_test, testAll, fileName, activity_test, features, subject_test, x_testSubset)

##  read in train data
setwd("./train")
x_train <- read.table("x_train.txt", stringsAsFactors = FALSE)

##  add column names and keep only columns with names including 'mean' or 'std'
names(x_train) <- features[[2]]
x_trainSubset <- x_train[, featuresAll]

##  read in subject and activity vectors
subject_train <- read.table("subject_train.txt", stringsAsFactors = TRUE, col.names = "subject")
activity_train <- read.table("y_train.txt", stringsAsFactors = TRUE, col.names = "activityID")
activity_train$activity <- activityLkUp[activity_train$activityID]
activity_train$activityID <- NULL

##  combine all train data
fileName <- c("train")
trainAll <- cbind(fileName, subject_train, activity_train, x_trainSubset)


##  append results to the test data file in root directory, remove all files
setwd("../")
write.table(trainAll, file = "HumanActivityRecognition.RDA", append = TRUE, col.names = FALSE, row.names = FALSE)

rm(x_train, trainAll, fileName, activity_train, features, featuresAll, subject_train, x_trainSubset)

##  Creating tidy data set
##  read in RDA file created from out data

runAnalysisResults <- read.table("HumanActivityRecognition.RDA", header = TRUE)

## calculate average for each variable for each activity and each subject 
runAnalysisResults$fileName <- NULL
runAnalysisCollapsed <- runAnalysisResults %>% 
  group_by(subject, activity) %>% 
  summarise_each(funs(mean))

##  reshape data frame
library(reshape2)
tidyData <- melt(runAnalysisCollapsed, id = c("subject", "activity"))

##  write results in a text file
write.table(tidyData, file = "activityTidyData.txt", append = FALSE,  
            col.names = TRUE, row.names = FALSE)