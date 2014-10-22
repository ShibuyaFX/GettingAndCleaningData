CourseProjectGettingCleaningData <- function(){
  
  ## extraction and merging of test and train data
  columnnames <- read.table("features.txt")
  columnnamesvector <- columnnames[,"V2"]
  
  trainingdata <- read.table("X_train.txt")
  tempcompletetrain <- setNames(trainingdata, columnnamesvector)
  subjecttrain <- read.table("subject_train.txt") %>% setNames("subjectid")
  activitytrain <- read.table("y_train.txt") %>% setNames("activitylabel")
  temp <- cbind(subjecttrain,activitytrain)
  tempcompletetrain <- cbind(temp, tempcompletetrain)
  
  testdata <- read.table("X_test.txt") %>% setNames(columnnamesvector)
  subjecttest <- read.table("subject_test.txt") %>% setNames("subjectid")
  activitytest <- read.table("y_test.txt") %>% setNames("activitylabel")
  temp2 <- cbind(subjecttest, activitytest)
  tempcompletetest <- cbind(temp2, testdata)
  
  completedata <- rbind(tempcompletetrain, tempcompletetest) #row binding train and test dataset
  
  ## Replacing the activity id with text labels
  completedata2$activitylabel <- gsub("1", "Walking", completedata2$activitylabel)
  completedata2$activitylabel <- gsub("2", "WalkingUpstairs", completedata2$activitylabel)
  completedata2$activitylabel <- gsub("3", "WalkingDownstairs", completedata2$activitylabel)
  completedata2$activitylabel <- gsub("4", "Sitting", completedata2$activitylabel)
  completedata2$activitylabel <- gsub("5", "Standing", completedata2$activitylabel)
  completedata2$activitylabel <- gsub("6", "Laying", completedata2$activitylabel)
  
  ## To select required columns
  completedata3 <- completedata2[grep("subjectid|activitylabel|.*mean.*|.*std.*", names(completedata2))]
  completedata3 <- completedata3[,1:72] ## to remove the last 9 columns with names "BodyBody" which is not supposed to mean anything as no explanation is provided in features_info.txt
  
  ## Conversion of the column names to descriptive naming
  namesconversion <- names(completedata3)
  
  namesconversion <- gsub("tBodyAcc-mean", "timeBodyAccelerationMean", namesconversion)
  namesconversion <- gsub("tBodyAcc-std", "timeBodyAccelerationStandardDeviation", namesconversion) 
  namesconversion <- gsub("tGravityAcc-mean", "timeGravityAccelerationMean", namesconversion) 
  namesconversion <- gsub("tGravityAcc-std", "timeGravityAccelerationStandardDeviation", namesconversion)
  namesconversion <- gsub("tBodyAccJerk-mean", "timeBodyAccelerationJerkMean", namesconversion) 
  namesconversion <- gsub("tBodyAccJerk-std", "timeBodyAccelerationJerkStandardDeviation", namesconversion) 
  namesconversion <- gsub("tBodyGyro-mean", "timeBodyGyroscopeMean", namesconversion)
  namesconversion <- gsub("tBodyGyro-std", "timeBodyGyroscopeStandardDeviation", namesconversion)
  namesconversion <- gsub("tBodyGyroJerk-mean", "timeBodyGyroscopeJerkMean", namesconversion) 
  namesconversion <- gsub("tBodyGyroJerk-std", "timeBodyGyroscopeJerkStandardDeviation", namesconversion)
  namesconversion <- gsub("tBodyAccMag-mean", "timeBodyAccelerationMagnitudeMean", namesconversion)
  namesconversion <- gsub("tBodyAccMag-std", "timeBodyAccelerationMagnitudeStandardDeviation", namesconversion) 
  namesconversion <- gsub("tGravityAccMag-mean", "timeGravityAccelerationMagnitudeMean", namesconversion)
  namesconversion <- gsub("tGravityAccMag-std", "timeGravityAccelerationMagnitudeStandardDeviation", namesconversion)
  namesconversion <- gsub("tBodyAccJerkMag-mean", "timeBodyAccelerationJerkMagnitudeMean",namesconversion)
  namesconversion <- gsub("tBodyAccJerkMag-std", "timeBodyAccelerationJerkMagnitudeStandardDeviation",namesconversion)
  namesconversion <- gsub("tBodyGyroMag-mean", "timeBodyGyroscopeMagnitudeMean",namesconversion)
  namesconversion <- gsub("tBodyGyroMag-std", "timeBodyGyroscopeMagnitudeStandardDeviation",namesconversion)
  namesconversion <- gsub("tBodyGyroJerkMag-mean", "timeBodyGyroscopeJerkMagnitudeMean",namesconversion)
  namesconversion <- gsub("tBodyGyroJerkMag-std", "timeBodyGyroscopeJerkMagnitudeStandardDeviation",namesconversion)      
  namesconversion <- gsub("fBodyAcc-mean", "frequencyBodyAccelerationMean", namesconversion)
  namesconversion <- gsub("fBodyAcc-std", "frequencyBodyAccelerationStandardDeviation", namesconversion)
  namesconversion <- gsub("fBodyAcc-meanFreq", "frequencyBodyAccelerationMeanFreqeuncy", namesconversion)
  namesconversion <- gsub("fBodyAccJerk-mean", "frequencyBodyAccelerationJerkMean", namesconversion)
  namesconversion <- gsub("fBodyAccJerk-std", "frequencyBodyAccelerationJerkStandardDeviation",namesconversion)
  namesconversion <- gsub("fBodyAccJerk-meanFreq", "frequencyBodyAccelerationJerkMeanFrequency", namesconversion)
  namesconversion <- gsub("fBodyGyro-mean", "frequencyBodyGyroscopeMean", namesconversion)
  namesconversion <- gsub("fBodyGyro-std", "frequencyBodyGyroscopeStandardDeviation", namesconversion)
  namesconversion <- gsub("fBodyGyro-meanFreq", "frequencyBodyGyroscopeMeanFrequency", namesconversion)
  namesconversion <- gsub("fBodyAccMag-mean", "frequencyBodyAccelerationMagnitudeMean", namesconversion)
  namesconversion <- gsub("fBodyAccMag-std", "frequencyBodyAccelerationMagnitudeStandardDeviation", namesconversion)
  namesconversion <- gsub("fBodyAccMag-meanFreq", "frequencyBodyAccelerationMagnitudeMeanFrequency", namesconversion)
         
  completedata3 <- setNames(completedata3, namesconversion) ## replace the names of the data table with the descriptive names
  
  finaldataset <- completedata3 %>% group_by(activitylabel, subjectid) %>% summarise_each(funs(mean)) ## to group the dataset by the ids and take the average of each column
  write.table(finaldataset, file = "CourseProjectSubmission.txt",col.names = TRUE, row.names = FALSE ) ## write the eventual output to a text file
  
  ## Additional code to read in the generated text file and display the output in rstudio
  courseproject <- read.table("CourseProjectSubmission.txt", header = TRUE)
  View(courseproject)         
}