library(dplyr) 

setwd(C:/Users/juany/Desktop/Data Science/Coursera/Data Science - John Hopkins/Course 3 Getting and Cleaning Data/week 4 project/UCI HAR Dataset/train")

## get train_X & train_Y data and combine into train_Data##
a <- list.files(pattern=".*.txt")  
train_Data <- do.call(cbind,lapply(a, read.table))

setwd(C:/Users/juany/Desktop/Data Science/Coursera/Data Science - John Hopkins/Course 3 Getting and Cleaning Data/week 4 project/UCI HAR Dataset/test")

## get test_X & test_Y data and combine into test_Data##
b <- list.files(pattern=".*.txt")  
test_Data <- do.call(cbind,lapply(b, read.table))

## merge two datasets into one##
dataset <- rbind(train_Data, test_Data)

## return rows' average##
apply(train_Data, 1, mean)
apply(test_Data, 1, mean) 

## change to corresponding activity##
dataset$activity[dataset$activity == 1] <-"WALKING"  
dataset$activity[dataset$activity == 2] <-"WALKING UPSTAIRS"  
dataset$activity[dataset$activity == 3] <- "WALKING_DOWNSTAIRS"  
dataset$activity[dataset$activity == 4] <- "SITTING"  
dataset$activity[dataset$activity == 5] <- "STANDING"  
dataset$activity[dataset$activity == 6] <- "LAYING"

## read the features##
setwd(C:/Users/juany/Desktop/Data Science/Coursera/Data Science - John Hopkins/Course 3 Getting and Cleaning Data/week 4 project/UCI HAR Dataset)
features <- read.table("features.txt")
feature <- rbind(features[,c(1,2)], matrix(c(562,"activity", 563, "subject"), nrow = 2, byrow = TRUE))

## rename columns##
colnames(dataset) <- feature[,2]

## average on different activities##
act_mean <- aggregate(dataset$activity, dataset, mean)

## average on different subjects##
sub_mean <- aggregate(act_mean$subject, act_mean, mean) 

new_dataset <- sub_mean[,c(564,565)]

## write a new table##
write.table(new_dataset, file = "new_dataset.txt", row.name=F, quote=F)
