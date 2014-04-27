
# Read data from text files

testData <- read.table("./X_test.txt")
trainData <- read.table("./X_train.txt")

subjecttrain <- read.table("./subject_train.txt")
subjecttest <- read.table("./subject_test.txt")

ytrain <- read.table("./y_train.txt")
ytest <- read.table("./y_test.txt")

features <- read.table("./features.txt")

activities <- read.table("./activity_labels.txt")



# Add column names to data frames

colnames(testData) <- features$V2
colnames(trainData) <- features$V2
colnames(subjecttrain) <- "subject"
colnames(subjecttest) <- "subject"
colnames(ytest) <- "activity"
colnames(ytrain) <- "activity"



# Append columns of subject and activity on the right of the data frame

testData[562] <- subjecttest
trainData[562] <- subjecttrain
testData[563] <- ytest
trainData[563] <- ytrain


# Merge test and train data

mergedData <- merge(trainData, testData, all=TRUE)



#Create activity name data and add it to the merged data

count1 = as.integer(nrow(mergedData))
activity_name = data.frame(1:count1)
for (i in 1: count1) {
  activity_name[i,1] = as.character((activities[mergedData[i,563],2]))
}

colnames(activity_name) <- "activity_name"
mergedData$activity_name <- activity_name



# Create a data frame with only means and standard deviations (also remove activity_name to simply later processing)

keep_col <-  features[grepl("mean()", features$V2) | grepl("std()", features$V2),1]
means_and_stds <- mergedData[,c(keep_col, 562, 563)]



# Create matrix (result) of means of means and standard deviations

for (i in 1:6) {
  by_activity <- subset(means_and_stds, activity == i)
  for (j in 1:30) {
    by_acivity_subject <- subset(by_activity, subject == j)
    if (i == 1 & j == 1) {
      result <- colMeans(by_acivity_subject)    
    } else {
      result1 <- colMeans(by_acivity_subject)
      result <- rbind(result, result1)
    }    
  }  
}



# Reorder columns of results, place in a tidy data frame, ad in activity_names and write to output file

reorder_results = cbind(result[,80:81], result[,1:79])

tidy_data <- data.frame(reorder_results);  # Note this line produces warning as the unused matrix row names are converted

tidy_data$activity = as.character(activities[tidy_data$activity,2])

write.table(tidy_data, file = "./tidy_data.txt")
write.csv(tidy_data, file = "./tidy_data.csv")

