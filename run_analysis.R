## This R script assumes you have downloaded the data file and unzipped
## it to a directory called "UCI HAR Dataset" in your working directory.



## Load dplyr library:

library(dplyr)


## Load all the tables necessary:

train <- read.table("UCI HAR Dataset/train/X_train.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")
trainLabels <- read.table("UCI HAR Dataset/train/y_train.txt")
testLabels <- read.table("UCI HAR Dataset/test/y_test.txt")
trainsubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
testsubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
actLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")


## Apply the variable names from the features.txt file to both main datasets:

names(train) <- features[, 2]; names(test) <- features[, 2]


## Replace activity labels with the descriptions instead of the number values:

trainLabels[, 1] <- actLabels[, 2][match(trainLabels[, 1], actLabels[, 1])]
testLabels[, 1] <- actLabels[, 2][match(testLabels[, 1], actLabels[, 1])]


## Add variables to the train and test data frames to identify which subject
## was performing the activity and what activity was being performed. Also
## adds a variable to identify which original dataset the subject came from
## for reference purposes labeled 'dataset':

train <- cbind("subject" = trainsubject[, 1],
               "dataset" = rep("Training", nrow(train)),
               "activity" = trainLabels[, 1],
               train)
test <- cbind("subject" = testsubject[, 1],
              "dataset" = rep("Test", nrow(test)),
              "activity" = testLabels[, 1],
              test)


## Combine the train and test datasets together into one data frame:

meansandstds <- rbind(train, test)


## Update variable names to exclude any characters that would cause errors
## when reading and update names for duplicate variable names:

valid_names <- make.names(names(meansandstds), unique = TRUE, allow_ = TRUE)
names(meansandstds) <- valid_names


## Update data frame to include only variables that measure the mean or
## the standard deviation (this excludes the "...meanFreq" variables as those
## were not requested to be pulled):

meansandstds <- select(meansandstds, subject:activity,
                       grep("\\.mean\\.|\\.std\\.", names(meansandstds)))


## Fix the names to comply with variable name text standards by removing
## the periods, removing duplicate "Body"s in one variable, and lower casing
## all letters in the names:

names(meansandstds) <- gsub("\\.", "", names(meansandstds))
names(meansandstds) <- gsub("BodyBody", "Body", names(meansandstds))
names(meansandstds) <- tolower(names(meansandstds))


## Create new tidy dataset composed of the averages of all the variables
## grouped by the subject and activity variables (removed the dataset variable
## as well as it is not necessary):

meansandstdsavgs <- meansandstds %>% select(-dataset) %>%
                    group_by(activity, subject) %>%
                    summarize_each(funs(mean))

## Writes the data to a txt file called "meansandstds_avgs.txt"

write.table(meansandstdsavgs, "meansandstds_avgs.txt",
            row.names = FALSE, quote = FALSE)
