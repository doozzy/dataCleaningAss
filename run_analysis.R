library(dplyr)
library(reshape2)

testdata<-read.table("UCI HAR Dataset/test/X_test.txt")
traindata<-read.table("UCI HAR Dataset/train/X_train.txt")
#1. merge tain and test data sets
wholedata <-rbind(traindata,testdata)

testsubject<-read.table("UCI HAR Dataset/test/subject_test.txt")
trainsubject<-read.table("UCI HAR Dataset/train/subject_train.txt")
subject <-rbind(trainsubject,testsubject)

wholedata$subject<-subject[[1]]

testactivity<-read.table("UCI HAR Dataset/test/y_test.txt")
trainactivity<-read.table("UCI HAR Dataset/train/y_train.txt")
activity <-rbind(trainactivity ,testactivity)

wholedata$activity<-activity[[1]]

features <- read.table("UCI HAR Dataset/features.txt")
#4. descriptive names for variables
features[[2]]<-sub("t","time",features[[2]])
features[[2]]<-sub("f","frequency",features[[2]])
features[[2]]<-sub("\\(\\)","",features[[2]])

names(wholedata) <- features[[2]]

colnames(wholedata)[562] <- "subject"
colnames(wholedata)[563] <- "Activity"

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
meanstd<-wholedata[,grep("mean|std", names(wholedata))]


#3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

activity<-ordered(activity[1:10299,],levels=activity_labels$V1,labels=activity_labels$V2)

wholedata$activity<-activity 


#5. creates a second, independent tidy data set with the average of each variable for 
#each activity and each subject.
library(reshape2)
mdata <- melt(wholedata, id=c("activity","subject"))
actiSubmean <- dcast(mdata, subject + activity~variable, mean)
write.table(actiSubmean,file ="tidydataset.txt", row.name=FALSE)
