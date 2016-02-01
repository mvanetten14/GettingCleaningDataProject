########## This script gets and cleans the data for the Course Project

# change this working directory to your own
wkdir = "~/Dropbox/Other/DataSpecialization/GettingData/CourseProject"
setwd(wkdir)

# make a data folder if there isn't one
if (!file.exists("./data")) {dir.create("./data")}

# Downloaded data file if it is not already there
if(!file.exists("./data/GCDcourseproject.zip")) {download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./data/GCDcourseproject.zip")}

# Unzip file if it hasn't been
if(!file.exists("./data/UCI HAR Dataset/")) {unzip("./data/GCDcourseproject.zip", exdir = "./data")}

# Figure out which cloumns to keep (assignment only asks for means and standard deviations)
feat <- read.table("./data/UCI HAR Dataset/features.txt", header = F, sep=" ", as.is=T) #these are the column names for something
keep <- grepl(pattern = "mean|std", x = feat$V2)==TRUE & grepl(pattern = "Freq", x=feat$V2)==FALSE
featkeep <- feat [keep==T,]

# Load X files using readr
library(readr)
wd <- fwf_widths (rep(16, 561)) #each column is 16 width
trdata <- read_fwf ("./data/UCI HAR Dataset/train/X_train.txt", col_positions =  wd ,  n_max = 7352)
trdata <- trdata[, keep==TRUE] #only keep the mean and std

testdata <- read_fwf ("./data/UCI HAR Dataset/test/X_test.txt", col_positions =  wd ,  n_max = 2947)
testdata <- testdata[, keep==TRUE]


# add the type of activity to each X record
library(dplyr)
activity_type <- read.table("./data/UCI HAR Dataset/activity_labels.txt") # the human readable version of the type of activity

tractivity <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/y_train.txt") # the list of the type of activity for each record in the training set
testactivity <- read.table("./data/UCI HAR Dataset/test/y_test.txt") # same for the test set 

trsub <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
testsub <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")


trmerge <- trdata %>%
    bind_cols(tractivity) %>%
    full_join (activity_type) %>%
    bind_cols(trsub)

testmerge <- testdata %>%
    bind_cols(testactivity) %>%
    full_join (activity_type) %>%
    bind_cols(testsub)

alldata <- rbind (trmerge, testmerge)

colnames(alldata) <- c(featkeep$V2, "activity", "activity_type", "subject")

#Summarize to make tidy data
library(tidyr)

meanslong <- alldata %>%
    gather(variable, value, -(c(activity, activity_type, subject))) %>%
    separate(variable, into=c("measurement_type", "summary_type", "axis"), sep="-", remove =T) %>%
    separate(measurement_type, into=c("domain_signal", "signal_type") , 1 ,remove=T) %>%
    group_by(subject, activity_type, domain_signal, signal_type, summary_type, axis) %>%
    summarize (mean(value)) %>%
    spread("summary_type", "mean(value)") %>%
    select(subject:axis, mean_val = starts_with("mean"), std_val= starts_with("std"))

meanshort <- alldata %>%
        gather(variable, value, -(c(activity, activity_type, subject))) %>%
        group_by(subject, activity_type, variable) %>%
        summarize (mean(value)) %>%
        spread(variable, "mean(value)")

# Write the resulting table
write.table(meanshort, "output.txt", row.names = F)
