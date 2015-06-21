# Code Book for UCI HAR Cleaned Dataset
###### See README.md for how to run clean data script(run_analysis.R) and source for raw data

##### Cleaning process (performed in run_analysis.R script)

1. Merge training and test sets to create one data set 
    * Merge of train/X_train.txt and test/X_test.txt which should result data frame of 10299X561
    * Merge of train/subject_train.txt with test/subject_test.txt, which should result data frame of 10299x1 (Subject ID)
    * Merge of train/y_train.txt with test/y_test.txt, which should result data frame of 10299x1 (Activity ID)
2. Reads features.txt and extracts only the measurements on the mean and standard deviation for each measurement. The result is a 10299x66 data frame, because only 66 out of 561 attributes are measurements on the mean and standard deviation
3. Reads activity_labels.txt and replaces the activity id with the names. the follwoing are resultent activity names
   ``walking``,``walkingupstairs``,``walkingdownstairs``,``sitting``,``standing``,``laying``
4.Appropriately labels the data set with descriptive names
   * All attribute (feature) names are converted to lower case, underscores and brackets () are removed
   * The resultant names are looks like ``tbodyacc-mean-x ``,``tbodyacc-mean-y``,``tbodyacc-mean-z``,``tbodyacc-std-x ``,``...``
5. Merge the 10299x66 data frame containing features with 10299x1 data frames containing activity labels and subject IDs. The result is saved as merged_clean_data.txt, a 10299x68 data frame such that the first column contains subject IDs, the second column activity names, and the last 66 columns are measurements. Subject IDs are integers between 1 and 30 inclusive. 
6. Create indipendent tidy data set with avarage of each mesurement for aech activity ad each subjet
7. The Result is saved as data_set_with_the_averages.txt and data_set_with_the_averages_NorowName.txt(with no row names)
   * There are 30 subjects and 6 activities, thus 180 rows in this data set with averages.
   *first column contains subject IDs, the second column contains activity names, and then the averages for each of the 66 attributes are in columns 3 to 68
