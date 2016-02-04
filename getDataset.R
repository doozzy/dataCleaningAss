fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", mode = "wb")
unzip("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
testdata<-read.table("UCI HAR Dataset/test/X_test.txt")
traindata<-read.table("UCI HAR Dataset/train/X_train.txt")