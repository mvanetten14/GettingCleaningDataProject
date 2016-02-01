# Codebook
The data sheets used are a subset of the original files downloadable from: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>. The complete script for the analysis can be found in "run_analysis.R".


### Input files
**UCI HAR Dataset/features.txt** is a space delimited file of the feature numbers and feature description. For details on the feature descriptions see UCI HAR Dataset/features_info.txt.

**UCI HAR Dataset/train/X_train.txt** is a fixed width format file with the measurements for each of the features in the above file. Each line is a different subject*activity

**UCI HAR Dataset/test/X_test.txt** same as above but for the test subset

**UCI HAR Dataset/activity_labels.txt** is a space delimited file of the activity number and corresponding activity description.

**UCI HAR Dataset/train/Inertial Signals/y_train.txt** is a space delimited file of the activity number for each of the records in X_train.txt

**UCI HAR Dataset/test/y_test.txt** same as above but for the X_test.txt

**UCI HAR Dataset/train/subject_train.txt** is a space delimited file of the subject number for each record in X_train.txt

**UCI HAR Dataset/test/subject_test.txt** same as above but for X_test.txt

### Processing
The above files were imported into R. The test and training sets were concatenated. Only the subset of features that were either a mean or standard deviation (features ending with either "mean()" or "std()") were retained.

The mean for each remaining feature for each subject and activity was calculated and outputted into "output.txt" where each row is a unique individual * activity and each remaining column is the mean for each feature.

The script also contains the code for a "long" format with each record being a unique subject*activity*feature. In this data set I have separated the feature name into several columns: domain_signal (t or f), signal_type (many), summary_type (mean or std), axis (X,Y or Z).
