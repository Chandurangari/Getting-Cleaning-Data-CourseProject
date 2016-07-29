# Analysis Steps
The run_analysis.R perfoms the following steps in sequence.
# Step 1 - Merges the training and the test sets to create one data set.
- Download data set using download.file function
- set working directory for program
- Load libarary required for program execution
- Read lables, training and test data sets using read.table function in dataframe varibales
- Combine Training and test data using cbind
- Finally create combine merge data set of Human Actvities

# Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement
 - Assign meaningful names to data set
 - extract only required columns using grep and Regular expression
 
# Step 3 & 4 -  Uses descriptive activity names to name the activities in the data set /Appropriately labels the data set with descriptive variable names
 - Clean column names using gsub
 - Assign column names to Final combine data set
 
# Setp 5 -Independent tidy data set with the average of each variable for each activity and each subject.
-  Melt final data set as per subjectid and actvitiesName column using reshape2 package
-  Apply dcast function on melted data to calculate average of all required coulmns
-  Finally prepare tidy data set and write using write.table on disk

# Variables used in program
- ActivityNames - Read activity_lable.txt 
- Features - Read feature.txt
- SubjectTraining,Xtraining,Ytraining - Read Training Data set
- SubjectTest,Xtest,Ytest - Read Test data set
- TrainingData and TestData - Combine similar data in 2 separte variables
- HumanActivityData - final combine Training and Test Data
- Cleannames - used for cleaning names of columns
- HumanActivityDataMelt - for melting data as per Subject and Activities

# Activity Labels
- WALKING - 1
- WALKING_UPSTAIRS - 2
- WALKING_DOWNSTAIRS - 3
- SITTING - 4
- STANDING - 5
- LAYING - 6
