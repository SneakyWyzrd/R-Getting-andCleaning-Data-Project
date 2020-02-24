# Directory of the dataset
data.dir <- "./data/UCI HAR Data/"
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
# Load labels and features files to tables
activity.labels.df <- read.table(paste0(data.dir, activity.labels))
features.df <- read.table(paste0(data.dir, features))
# Load training set files to tables
x.train.df <- read.table(paste0(data.dir, x.train))
y.train.df <- read.table(paste0(data.dir, y.train))
subject.train.df <- read.table(paste0(data.dir, subject.train))
# Load test set files to tables
x.test.df <- read.table(paste0(data.dir, x.test))
y.test.df <- read.table(paste0(data.dir, y.test))
subject.test.df <- read.table(paste0(data.dir, subject.test))

# create separate logical masks for each variable we wish to keep
duplicated.features.column.mask <- !duplicated(features.df[,2])
mean.column.mask <- sapply(features.df[,2], function(x){grepl("*mean()*",x)})
std.column.mask <- sapply(features.df[,2], function(x){grepl("*std()*",x)})
# combine masks into a single mask for ease of use
column.mask <- (mean.column.mask | std.column.mask) & 
    duplicated.features.column.mask

# set the column names for the data
colnames(x.train.df) <- features.df[,2]
colnames(x.test.df) <- features.df[,2]
# apply column mask to the data
x.train.df <- x.train.df[,column.mask]
x.test.df <- x.test.df[,column.mask]
# change activity ID to be descriptive
y.test.df[,1] <- factor(y.test.df[,1], levels = activity.labels.df[,1],
                        labels = activity.labels.df[,2])
y.train.df[,1] <- factor(y.train.df[,1], levels = activity.labels.df[,1],
                        labels = activity.labels.df[,2])
# change subject id to be descriptive
subject.train.df <- sapply(subject.train.df, function(x) {paste("SUBJECT", x)})
subject.test.df <- sapply(subject.test.df, function(x) {paste("SUBJECT", x)})
# add columns to data for subject and activity
x.train.df <- cbind(activity = as.factor(y.train.df[,1]), x.train.df)
x.test.df <- cbind(activity = as.factor(y.test.df[,1]), x.test.df)
x.train.df <- cbind(subject = as.factor(subject.train.df[,1]), x.train.df)
x.test.df <- cbind(subject = as.factor(subject.test.df[,1]), x.test.df)

# join the dataframes together
tidy.df <- rbind(x.train.df, x.test.df)

# split tidy data by activity
activity.df <- split(tidy.df, tidy.df$activity)
# get mean/average of each column for each activity
activity.average.df <- as.data.frame(sapply(activity.df, function(x) {
    sapply(x[,3:length(x)], mean)
}))
# split tidy data by subject
subject.df <- split(tidy.df, tidy.df$subject)
# get mean/average of each column for each subject
subject.average.df <- as.data.frame(sapply(subject.df, function(x) {
    sapply(x[,3:length(x)], mean)
}))
# change rownames for each dataframe to a column
activity.average.df <- cbind(variable = row.names(activity.average.df), 
                             activity.average.df)
subject.average.df <- cbind(variable = row.names(subject.average.df),
                            subject.average.df)
# combine both dataframes into one
averages.df <- cbind(activity.average.df,
                     subject.average.df[,2:length(subject.average.df)])

# write dataframes to their own file
write.table(averages.df, "./averages.csv", append = FALSE, sep = ",", 
            row.names = F, col.names = TRUE)
write.table(tidy.df, "./tidy.csv", append = FALSE, sep = ",", 
            row.names = F, col.names = TRUE)
