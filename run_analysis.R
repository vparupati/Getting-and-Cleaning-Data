#  Script to clean the data set ./data/UCI HAR Dataset

# 1. Merges the training and the test sets to create one data set.

xTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
xTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
X <- rbind(xTrain, xTest)

sTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
sTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
S <- rbind(sTrain, sTest)

yTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
yTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
Y <- rbind(yTrain, yTest)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("./data/UCI HAR Dataset/features.txt")
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, indices_of_good_features]
names(X) <- features[indices_of_good_features, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(S) <- "subject"
cleaned <- cbind(S, Y, X)
write.table(cleaned, "./data/UCI_HAR_Clean_Dataset/merged_clean_data.txt")


# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(S)[,1]
numSubjects = length(unique(S)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
  for (a in 1:numActivities) {
    result[row, 1] = uniqueSubjects[s]
    result[row, 2] = activities[a, 2]
    tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
write.table(result, "./data/UCI_HAR_Clean_Dataset/data_set_with_the_averages.txt")
write.table(cleaned, "./data/UCI_HAR_Clean_Dataset/data_set_with_the_averages_NorowName.txt", row.name=FALSE)
