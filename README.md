# GettingCleaningDataProject
This repo contains the files and script to perform a basic analysis for data obtained from accelerometers from the Samsung Galaxy S smartphone.

### Data source
A full description is available at the site where the data was obtained: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The data for the project can be found:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

### Codebook
For information about the analysis see the CodeBook.md file. Basically, the data consists of a variety of accelerometer measurements of various subjects doing specific activities (e.g. walking, sitting, etc).

### Packages
This script requires readr, dplyr and tidyr.

### Running the script
To run the script, create a data file in the same folder into which you unzip the data from above. The file structure should be:

/README.md

/CodeBook.md

/run_analysis.R

/data/UCI HAR Dataset/

In the run_analysis.R script change the wkdir variable to where your working directory is. After that it should run and output a file with the mean of each feature for each subject and activity. For further description of the different features, see the original documentation.
