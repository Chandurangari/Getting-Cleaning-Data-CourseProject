# Setup URL for project
fileurl<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#Create directory if not exist locally
if(!file.exists("./ProjectData"))
{
    dir.create("./ProjectData")
}

#Download file in above created/exist directory
download.file(fileurl,destfile = "./ProjectData/UCI HAR Dataset.zip")

#Unzip the download file to folder and use this folder for further processing
unzip("./ProjectData/UCI HAR Dataset.zip")


# Set working directory where data was extracted and load library
setwd("E:/Data Science/R/ProjectData/UCI HAR Dataset")
library(plyr)
library(reshape2)


#Read lables data
ActivityNames <-read.table("activity_labels.txt",header = F)
ActivityNames[,2]<- as.character(ActivityNames[,2])
colnames(ActivityNames)<c("actvityid","activityName")

Features<-read.table("features.txt",header=F)
Features[,2]<-as.character(Features[,2])

# Read training data
SubjectTraining <-read.table("./train/subject_train.txt",header = F)
Xtraining <-read.table("./train/X_train.txt",header = F)
Ytraining<-read.table("./train/y_train.txt",header = F)

#Assign Column Names to Training Data
colnames(SubjectTraining) <-"subjectid"
colnames(Xtraining) <-Features[,2]
colnames(Ytraining) <-"activityid"

# Read test data
SubjectTest <-read.table("./test/subject_test.txt",header = F)
Xtest <-read.table("./test/X_test.txt",header = F)
Ytest<-read.table("./test/y_test.txt",header = F)


#Assign Column Names to Test Data
colnames(SubjectTest)<-"subjectid"
colnames(Xtest)<-Features[,2]
colnames(Ytest)<-"activityid"

# Create final data set for Training data
TrainingData<-cbind(Xtraining,SubjectTraining,Ytraining)
 - Assign 
# Create final data set for Test data
TestData<-cbind(Xtest,SubjectTest,Ytest)

# Combine both Training and Test da
HumanActivityData <-rbind(TrainingData,TestData)


#Extracts only the measurements on the mean and standard deviation columns
SelectFeatures<-grep(".*mean.*|.*std.*",Features[,2])
SelectFeatures<-c(SelectFeatures,562,563)

#Subset final Human activity data only for Extracts only the Mean and standard deviation columns
HumanActivityData<-HumanActivityData[,SelectFeatures]

# Give activity name to last columns of Human Activity data and rename Columns
# Clean column Names and reassign to Human Actvity Data
Cleannames<-colnames(HumanActivityData)
Cleannames<-gsub('[-()]','',Cleannames) - 
Cleannames<-gsub('mean','Mean',Cleannames)
Cleannames<-gsub('std','StandardDeviation',Cleannames)
Cleannames<-gsub('[Mm]ag','Magnitude',Cleannames)
Cleannames<-gsub('[Ff]req','Frequency',Cleannames)
colnames(HumanActivityData)<-Cleannames
HumanActivityData[,81]<-ActivityNames[HumanActivityData[,81],2]

#Change name of last column of data set to ActivityName from Activityid
names(HumanActivityData)[names(HumanActivityData)=="activityid"]<-"ActivityName"

#Melt Human actvity data using reshape2 package
HumanActivityDataMelt<-melt(HumanActivityData,id=c("subjectid","ActivityName"))
# Calculate mean for Subject and Actvities
Final.HumanActivityData<-dcast(HumanActivityDataMelt,subjectid+ActivityName~variable,mean)

write.table(Final.HumanActivityData,file="tidy.txt",row.names=F,col.names = T,sep="\t")