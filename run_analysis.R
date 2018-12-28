
#1 Download and unzip the datasets

filename <- "Coursera3.zip"
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, filename, method = "curl")
unzip(zipfile = "./data/Coursera3.zip",exdir = "./data")

#2 Read data from the downloaded and unzipped files.

path <- file.path("./data", "UCI HAR Dataset")
files <- list.files(path, recursive=TRUE)

activityTest  <- read.table(file.path(path, "test" , "Y_test.txt" ), header = FALSE)
activityTrain <- read.table(file.path(path, "train", "Y_train.txt"), header = FALSE)
subjectTrain <- read.table(file.path(path, "train", "subject_train.txt"), header = FALSE)
subjectTest  <- read.table(file.path(path, "test" , "subject_test.txt"), header = FALSE)
featuresTest  <- read.table(file.path(path, "test" , "X_test.txt" ), header = FALSE)
featuresTrain <- read.table(file.path(path, "train", "X_train.txt"), header = FALSE)

#3 Merges the training and the test sets to create one data set.

df_subject <- rbind(subjectTrain, subjectTest)
df_activity <- rbind(activityTrain, activityTest)
df_features <- rbind(featuresTrain, featuresTest)

names(df_subject) <- c("subject")
names(df_activity) <- c("activity")
feat_names <- read.table(file.path(path, "features.txt"), head = FALSE)
names(df_features) <- feat_names$V2
df_combine <- cbind(df_subject, df_activity)
df_all <- cbind(df_features, df_combine)

#4 Extract the measurements on the mean and standard deviation for each measurement.

subset_feat <- feat_names$V2[grep("mean\\(\\)|std\\(\\)", feat_names$V2)]
selected <- c(as.character(subset_feat), "subject", "activity" )
data <- subset(df_all, select = selected)

#5 Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table(file.path(path, "activity_labels.txt"), header = FALSE)
data$activity <- factor(data$activity, labels = activity_labels[,2])
head(data$activity, 20)

# Appropriately labels the data set with descriptive variable names

names(data) <- gsub("^t", "time", names(data))
names(data) <- gsub("^f", "frequency", names(data))
names(data) <- gsub("Acc", "Accelerometer", names(data))
names(data) <- gsub("Gyro", "Gyroscope", names(data))
names(data) <- gsub("Mag", "Magnitude", names(data))
names(data) <- gsub("BodyBody", "Body", names(data))
names(data)

# Create an independent tidy data set

df_tidy <- aggregate(. ~subject + activity, data, mean)
df_tidy <- df_tidy[order(df_tidy$subject, df_tidy$activity),]
write.table(df_tidy, file = "tidydata.txt",row.name = FALSE, quote = FALSE, sep = '\t')

