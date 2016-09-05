library(data.table)
library(plyr)
library(dplyr)

# Load raw data
features <- read.table("UCI HAR Dataset/features.txt", colClasses = c("character"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("ActivityId", "Activity"))
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)

#*************** 1. Merges the training and the test sets to create one data set. **************#

# Binding data
training_data <- cbind(cbind(x_train, subject_train), y_train)
testing_data <- cbind(cbind(x_test, subject_test), y_test)
data <- rbind(training_data, testing_data)

# Label columns
labels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(data) <- labels

#** 2. Extracts only the measurements on the mean and standard deviation for each measurement. **#

data_mean_std <- data[,grepl("mean|std|Subject|ActivityId", names(data))]

#********* 3. Uses descriptive activity names to name the activities in the data set **********#

data_mean_std <- join(data_mean_std, activity_labels, by = "ActivityId", match = "first")
data_mean_std <- data_mean_std[,-1]

#**************** 4. Appropriately labels the data set with descriptive names. ****************#

# Remove parentheses
names(data_mean_std) <- gsub('\\(|\\)',"",names(data_mean_std), perl = TRUE)
# Make valid names
names(data_mean_std) <- make.names(names(data_mean_std))
# Make clearer names
names(data_mean_std) <- gsub('Acc',"Acceleration",names(data_mean_std))
names(data_mean_std) <- gsub('GyroJerk',"AngularAcceleration",names(data_mean_std))
names(data_mean_std) <- gsub('Gyro',"AngularSpeed",names(data_mean_std))
names(data_mean_std) <- gsub('Mag',"Magnitude",names(data_mean_std))
names(data_mean_std) <- gsub('^t',"TimeDomain.",names(data_mean_std))
names(data_mean_std) <- gsub('^f',"FrequencyDomain.",names(data_mean_std))
names(data_mean_std) <- gsub('\\.mean',".Mean",names(data_mean_std))
names(data_mean_std) <- gsub('\\.std',".StandardDeviation",names(data_mean_std))
names(data_mean_std) <- gsub('Freq\\.',"Frequency.",names(data_mean_std))
names(data_mean_std) <- gsub('Freq$',"Frequency",names(data_mean_std))

#******** 5. From the data set in step 4, creates a second, independent tidy data ********# 
#******** set with the average of each variable for each activity and each subject. ********#

tidyData <- ddply(data_mean_std, c("Subject","Activity"), numcolwise(mean))
write.table(tidyData, file = "Tidy.txt")
