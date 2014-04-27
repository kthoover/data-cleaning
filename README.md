##  Getting and Cleaning Data Peer Assignment

#  Processing accelerometer data from smartphones



This repository contains the R code to complete the peer assessment for Gettign and Cleaning Data with Jeff Leek.

To run the R script, all data files are assumed to be in the working directory.

* The script first reads all the necessary data into data frames.
* Then column names are added to all the data frames.
* Next subject and activty columns are appended to the feature data in both the training and test sets. (trainData and testData) 
* The training and test data sets are merged.  (mergedData)
* A column with the activity name (as opposed to simply the number) is added to the merged data set.  (mergedData)
* A new data frame is created which keeps only features which are means and standard deviations.  (means_and_stds)
* Means of this data set are taken across all observations by a given subject in a given activity.  (result)
* Finally, the columns are reordered, the activity name is added back, and the tidy data is output to a file.  (tidy_data) 



Note:  The script produces both a .txt and .csv version of the final tidy data.
Note:  When the matrix result is converted into tidy_data, numerous warnings are produced as the unused matrix rows names are disgarded.


Source of original data:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 