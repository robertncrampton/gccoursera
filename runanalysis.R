
library("data.table")

activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

features <- read.table("./UCI HAR Dataset/features.txt")[,2]

extractmeansd<- grepl("mean|std", features)


xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

xtest <- xtest[,extractmeansd]

ytest[,2] = activitylabels[ytest[,1]]

##Name everything
names(ytest) = c("Activity_ID", "Activity_Label")
names(xtest) = features
names(subjecttest) = "subject"

td <- cbind(as.data.table(subjecttest), ytest, xtest)


xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")

subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

xtrain <- xtrain[,extractmeansd]

ytrain[,2] <- activitylabels[ytrain[,1]]
names(ytrain) = c("Activity_ID", "Activity_Label")
names(xtrain) = features
names(subjecttrain) = "subject"

traindata <- cbind(as.data.table(subjecttrain), ytrain, xtrain)

mergeddata <- rbind(test_data, train_data)

idlabels <-c("subject", "Activity_ID", "Activity_Label")
datalabels <- setdiff(colnames(data), id_labels)
meltdata <- = melt(data, id = id_labels, measure.vars = data_labels)

tidydata   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

write.table(tidydata, file = "./tidydata.txt")