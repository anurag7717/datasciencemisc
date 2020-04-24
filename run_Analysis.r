if("dplyr" %in% rownames(installed.packages()) == FALSE) 
  {install.packages("dplyr")};library(dplyr)
if("tidyr" %in% rownames(installed.packages()) == FALSE) 
  {install.packages("tidyr")};library(tidyr)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("UCI HAR Dataset")) {
  if (!file.exists("data")) {
    dir.create("data")
  }
  download.file(fileUrl, destfile="data/har.zip", method="curl")
  unzip("data/har.zip", exdir="./")
}

# ------------------------------------------------------------------------------

trainx <- read.table("UCI HAR Dataset/train/X_train.txt", nrows=7352, comment.char="")
trainsub <- read.table("UCI HAR Dataset//train/subject_train.txt", col.names=c("subject"))
trainy <- read.table("UCI HAR Dataset/train//y_train.txt", col.names=c("activity"))
train_data <- cbind(trainx, trainsub, trainy)

testx <- read.table("UCI HAR Dataset//test/X_test.txt", nrows=2947, comment.char="")
testsub <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names=c("subject"))
testy <- read.table("UCI HAR Dataset/test//y_test.txt", col.names=c("activity"))
test_data <- cbind(testx, testsub, testy)

data <- rbind(train_data, test_data)

# ------------------------------------------------------------------------------

feat.list <- read.table("UCI HAR Dataset//features.txt", col.names = c("id", "name"))
features <- c(as.vector(feat.list[, "name"]), "subject", "activity")

filtFeatId <- grepl("mean|std|subject|activity", features) & !grepl("meanFreq", features)
filtData = data[, filtFeatId]

# ------------------------------------------------------------------------------

activities <- read.table("UCI HAR Dataset//activity_labels.txt", col.names=c("id", "name"))
for (i in 1:nrow(activities)) {
  filtData$activity[filtData$activity == activities[i, "id"]] <- as.character(activities[i, "name"])
}

# ------------------------------------------------------------------------------

filtFeatNames <- features[filtFeatId]
filtFeatNames <- gsub("\\(\\)", "", filtFeatNames)
filtFeatNames <- gsub("Acc", "-acceleration", filtFeatNames)
filtFeatNames <- gsub("Mag", "-Magnitude", filtFeatNames)
filtFeatNames <- gsub("^t(.*)$", "\\1-time", filtFeatNames)
filtFeatNames <- gsub("^f(.*)$", "\\1-frequency", filtFeatNames)
filtFeatNames <- gsub("(Jerk|Gyro)", "-\\1", filtFeatNames)
filtFeatNames <- gsub("BodyBody", "Body", filtFeatNames)
filtFeatNames <- tolower(filtFeatNames)

names(filtData) <- filtFeatNames

# ------------------------------------------------------------------------------

library(dplyr)
library(tidyr)
tidy_data <- tbl_df(filtData) %>%
  group_by('subject', 'activity') %>%
  summarise_each(funs(mean)) %>%
  gather(measurement, mean, -activity, -subject)


write.table(tidy_data, file="tidy.data.txt", row.name=FALSE)
