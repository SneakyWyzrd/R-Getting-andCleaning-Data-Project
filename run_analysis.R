#==============================================================================#
# Project Objectives
#==============================================================================#
# 1) Merge the training and the test sets to create one data set.
#
# 2) Extract only the measurements on the mean and standard deviation
#       for each measurement.
#
# 3) Use descriptive activity names to name the activities in the data set
#
# 4) use appropriately labeled variable names for the tidy dataset.
#
# 5) From the data set in step 4, create a second, independent tidy data set
#       with the average of each variable for each activity and each subject.
#==============================================================================#
# setup sources and libraries
#==============================================================================#

# Load a list of packages and install if needed
## Package names
packages <- c("dplyr")
## Install packages not yet installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
    install.packages(packages[!installed_packages])
}
## Packages loading
lapply(packages, library, character.only = TRUE) %>% invisible()

# Source a directory of ".R" files
## Set path of files to source
source.dir <- "./src"
## Get list of files in source directory and set the path
files.list <- list.files(source.dir) %>% 
    lapply(function(x) {paste0(source.dir, "/", x)})
## Select only files that end with ".R"
source.list <- files.list[grep("\.R$", files.list)]
## Source all R script files in the directory
lapply(source.list, source) %>% invisible()

#==============================================================================#
# load data
#==============================================================================#

# Directory name for the dataset
data.dir <- "./data/"
# List of all features.
features <- 'features.txt'
# Links the class labels with their activity name.
activity.labels <- 'activity_labels.txt'
# Training set.
x.train <- './train/X_train.txt'
# Training set labels.
y.train <- './train/y_train.txt'
# Test set.
x.test <- './test/X_test.txt'
# Test set labels.
y.test <- './test/y_test.txt'

activity.labels.df <- read.table(paste0(data.dir, activity.labels))
features.df <- read.table(paste0(data.dir, features))
x.train.df <- read.table(paste0(data.dir, x.train))
y.train.df <- read.table(paste0(data.dir, y.train))
x.test.df <- read.table(paste0(data.dir, x.test))
y.test.df <- read.table(paste0(data.dir, y.test))

#==============================================================================#
# Objective 1
#==============================================================================#



#==============================================================================#
# Objective 2
#==============================================================================#



#==============================================================================#
# Objective 3
#==============================================================================#



#==============================================================================#
# Objective 4
#==============================================================================#



#==============================================================================#
# Objective 5
#==============================================================================#


