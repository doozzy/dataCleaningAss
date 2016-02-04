library(dplyr)

testdata<-read.table("UCI HAR Dataset/test/X_test.txt")
traindata<-read.table("UCI HAR Dataset/train/X_train.txt")
#merge tain and test data sets
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

names(wholedata) <- features[[2]]

colnames(wholedata)[562] <- "subject"
colnames(wholedata)[563] <- "Activity"

#Extracts only the measurements on the mean and standard deviation for each measurement.
meanstd<-wholedata[,grep("mean|std", names(wholedata))]


#Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

activity<-ordered(activity[1:10299,],levels=activity_labels$V1,labels=activity_labels$V2)

wholedata$activity<-activity[[1]]



library(reshape2)
mdata <- melt(wholedata, id=c("activity","subject"))
subjmean <- dcast(mdata, subject~variable, mean)
actimean <- dcast(mdata, activity~variable, mean)
