---
title: "Code Testing Book"
author: "MS"
date: "2020-02-21"
output: 
    html_document:
        keep_md: TRUE
---




```r
rm(list = ls())
```


```r
#==============================================================================#
# Install/Load Libraries
#==============================================================================#
# Package names
packages <- c("dplyr")
# Install packages not yet installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
    install.packages(packages[!installed_packages])
}
# Package loading
invisible(lapply(packages, library, character.only = TRUE))
message("Packages loaded")
```


```r
#==============================================================================#
# Load files from src directory
#==============================================================================#
# Set path of files to source
source.dir <- "./src"
# Get list of files in source directory and set the path
files.list <- list.files(source.dir) %>% 
    lapply(function(x) {paste0(source.dir, "/", x)})
# Select only R script files
source.list <- files.list[grep("\\.R$", files.list)]
# Source loading
invisible(lapply(source.list, source))
message("R script files loaded from /src")
```


```r
#==============================================================================#
# Load data
#==============================================================================#
# Directory of the dataset
data.dir <- "./data/"
# List of all features.
features <- 'features.txt'
# Links the class labels with their activity name.
activity.labels <- 'activity_labels.txt'
# Training set.
x.train <- './train/X_train.txt'
# Training set labels.
y.train <- './train/y_train.txt'
# Training set subjects
subject.train <- "./train/subject_train.txt"
# Test set.
x.test <- './test/X_test.txt'
# Test set labels.
y.test <- './test/y_test.txt'
# Test set subjects
subject.test <- "./test/subject_test.txt"

activity.labels.df <- read.table(paste0(data.dir, activity.labels))
features.df <- read.table(paste0(data.dir, features))
# Training set
x.train.df <- read.table(paste0(data.dir, x.train))
y.train.df <- read.table(paste0(data.dir, y.train))
subject.train.df <- read.table(paste0(data.dir, subject.train))
# Test set
x.test.df <- read.table(paste0(data.dir, x.test))
y.test.df <- read.table(paste0(data.dir, y.test))
subject.test.df <- read.table(paste0(data.dir, subject.test))
message("Loaded data")
```


```r
#==============================================================================#
# select columns for mean() and std()
#==============================================================================#
# create a logical mask for all the columns we wish to keep
column.mask <- function(column.names) {
    duplicated.features.column.mask <- !duplicated(column.names)
    mean.column.mask <- sapply(column.names, 
                                    function(x){grepl("*mean()*",x)})
    std.column.mask <- sapply(column.names, 
                                   function(x){grepl("*std()*",x)})
    # combine column masks to a single mask
    column.mask <- (mean.column.mask | std.column.mask) &
        duplicated.features.column.mask
    invisible(column.mask)
}

col.mask <- column.mask(features.df$V2)

# apply column mask to the dataframes
x.train.df.test <- x.train.df[,column.mask]
colnames(x.train.df.test) <- features.df[features.df$V2[column.mask],2]
x.test.df.test <- x.test.df[,column.mask]
colnames(x.test.df.test) <- features.df[features.df$V2[column.mask],2]

x.test.df.test[1,]
```


```r
#==============================================================================#
# joining the labels to the datasets
#==============================================================================#
x.train.df.test <- cbind(subject = , activity = y.train.df$V1, x.train.df)
x.test.df.test <- cbind(activity = y.test.df$V1, x.test.df)
tidy.df <- bind_rows(x.train.df.test, x.test.df.test)
ncol(x.train.df.test)
ncol(x.test.df.test)
ncol(tidy.df)
# x.test.df.test[1:5,c(1, 80)]
# x.train.df.test[1:5,c(1, 80)]
x.train.df.test[1:5,duplicated(colnames(x.train.df.test))]
```
