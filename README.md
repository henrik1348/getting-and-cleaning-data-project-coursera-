This is the project for Getting and Cleaning Data course on Coursera. Code is written in R. Source file is run_analysis.R. 
THe R script does the following:

1. Download and unzip the datasets needed.

2. Read data from the downloaded and unzipped files. The files that will be used to load data are listed as follows: test/subject_test.txt test/X_test.txt test/y_test.txt train/subject_train.txt train/X_train.txt train/y_train.txt

3. Merges the training and the test sets to create one data set (df_all).

4. Extracts the measurements on the mean and standard deviation for each measurement.

5. Uses descriptive activity names to name the activities in the data set

6. Appropriately labels the data set with descriptive variable names.

7. Creates an independent tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

8. Final output file is tidydata.txt