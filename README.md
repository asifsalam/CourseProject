Introduction
--------------------------------------------------------
This repository contains files relevant to the class project for the course - Getting & Cleaning Data.
The files included are:
1 - README.md #This file
2 - run_analysis.R #The script used to create the tidy data set required for the project. Includes a funtion
3 - Codebood.md #Describes the variables and the transformations done to get to the tidy dataset
4 - tidy_data.fwf #Resulting tidy dataset, after the appropriate manipulations and transformations.  In fixed width format to make reading the data easier in a text editor
5 - tidy_data.tsv #Resulting tidy dataset, after the appropriate manipulations and transformations.  In tab separated format to make loading into software easier.

The purpose of this project is to clean, manipulate and transform data into a data set useful for a specific analysis.  The base data used in the project are activity data collected from a Samsung Galaxy S smartphone.  The data and associated descripition are available on the website that hosts the data here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

In this project we are required to create an R script called run_analysis.R that
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The results are communicated via github, and include the following:
1. A README.md file that describes the steps taken to create the tidy dataset required. 
2. A link to a Github repository with the script for performing the analysis
3. A code book that describes the variables, the data, and any transformations or work performed on the data called CodeBook.md.
4. A tidy data set as described above.

Description
----------------------------------------------------------
The attached run_analysis.R script creates the tidy data in the following steps:

1. Create "data" subdirectory in the working directory,download the zipped file, and extract the data.
2. Read in the activity labels from the file "activity_labels.txt" from the main directory
3. Read in the feature list from the file "features.txt" from the main directory
4. Extract the column indices and names of the variables that have either "mean" or "std" in them
5. Call the function "create_base_data" for both the training and test data to get the base data required in order to calculate the means of each column, passing the column indices to extract, and the activities to attach to the activity labels.  The training and test data is combined into one dataframe. 
6. The function "create_base_data" does the following:
    * Reads in the subject vector (from the "subject_indicating the subject for each measurement in the measure data file
    * Reads in the activity vector indicating the activity the subject was engaged in during the measurement
    * Adds a sequence number to the activity vector, useful for later sorting
    * Adds the activity name to each activity label
    * Reads in the measurement file and extracts the columns based on the column indices
    * Adds the subject and activity names to each observation, and returns the cleaned data
7. Merged data is split by subject and activity, the column means for each part calculated and the results stored in a dataframe
8. The variables are renamed to provide meaningful names, and subject and activity attributes added.
9. The dataframe is reordered by subject and activity to create the final, tidy dataset required, and the data written to a file ("tidy_data.fwf") in fixed width format to aid reading, and in tab separated format for data manipulation.


Details, with code
--------------------------------------------------------------------------
The following details each step, along with the code.

### 1. Create "data" subdirectory in the working directory,download the zipped file, and extract the data.
```
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/HARDataset.zip")
unzip("./data/HARDataset.zip")
#Directory where the unzipped data is
dirname <- "./data/UCI HAR Dataset/"
```

### 2. Read in the activity labels from the file "activity_labels.txt" from the main directory
```
#Read in the activity labels from main directory
filename <- paste0(maindir,"activity_labels.txt")
activity_labels <- read.table(filename,header=FALSE,stringsAsFactors=FALSE)
colnames(activity_labels) <- c("label","activity")
```

### 3. Read in the feature list from the file "features.txt" from the main directory
```
#Read in the features
filename <- paste0(dirname,"features.txt")
features <- read.table(filename,header=FALSE)
colnames(features) <- c("index","feature")
```

### 4. Extract the column indices and names of the variables that have either "mean" or "std" in them
```
#Which features (columns) have mean and std in them
col_means <- which(grepl("mean",features[,2]))
col_std <- which(grepl("std",features[,2]))
col_all <- sort(c(col_means,col_std))
col_names <- as.character(features[col_all,2])
```

### 5. Call the function "create_base_data" for both the training and test data to get the base data required in order to calculate the means of each column, passing the column indices to extract, and the activities to attach to the activity labels 
```
#Extract "test" data
base_data <- create_base_data(col_all,activity_label,"test")
#Append "train" data
base_data <- rbind(base_data,create_base_data(col_all,activity_label,"train"))
```

### 6. The function "create_base_data" creates the dataset with the columns and attributes necessary for calculating the means of each column
```
create_base_data <- function(col_ind,activity_label,data_type="train") {
    #extracts columns indicated by col_ind, adds activity names as indicated by activity_label
    #and subject names, in preparation for calculating the means of each column of data
    dirname <- "./data/UCI HAR Dataset/"
        
    #Read in subject vector
    filename <- paste0(dirname,data_type,"/subject_",data_type,".txt")
    subject <- read.table(filename,header=FALSE,stringsAsFactor=FALSE)
    
    #Read in activity vector
    filename <- paste0(dirname,data_type,"/y_",data_type,".txt")
    activity <- read.table(filename,header=FALSE,)
    colnames(activity) <- "label"
    #Add a sequence number
    activity$seqno <- 1:dim(activity)[1]
    activity <- activity[,c(2,1)]
    #Add in the descriptive labels
    labeled_activity <- merge(activity,activity_labels,by="label",sort=FALSE)
    #re-sort so the data has the same sequence as before
    labeled_activity <- labeled_activity[order(labeled_activity[,2]),]
    
    #Read in main data
    filename <- paste0(dirname,data_type,"/X_",data_type,".txt")
    x <- read.table(filename)
    
    #Exract those columns
    base_data <- x[,col_ind]
    #Add the subject vector
    base_data[,80] <- subject
    #Add the activity vector
    base_data[,81] <- labeled_activity[,3]
    #Give them reasonable names
    colnames(base_data) <- c(col_names,"subject","activity")
    base_data <- base_data[,c(80,81,1:79)]
    return(base_data)
}

```

### 7. Merged data is split by subject and activity, the column means for each part calculated and the results stored in a dataframe
```
#Split the data based on subject and activity
split_data <- split(base_data,list(base_data$subject,base_data$activity))
#Calculate the means for all the columns, per split
means_list <- lapply(split_data,function(x0) {colMeans(x0[,3:81])})
#create a dataframe with the means data in list format
means_data <- do.call(rbind.data.frame,means_list)
```

### 8. The variables are renamed to provide meaningful names, and subject and activity attributes added.
```
#Create new column names indicating these are calculated means (append "avg" to all existing names)
tidy_names <- paste0(col_names,"-avg")
#Name the columns
colnames(means_data) <- tidy_names
#The list names are comprised of the subject, and the activity names
#Extract both to attach back to the dataframe
split_names <- names(split_data)
#using the function from the stringr package, splits the names into 2 parts
split_sub_act <- str_split_fixed(split_names,"[.]",2)
subject <- as.data.frame(as.numeric(split_sub_act[,1]))
activity <- as.data.frame(split_sub_activity[,2],stringsAsFactors=FALSE)
    
#add the subject and activity to the means data
tidy_data <- cbind(subject,activity,means_data)
colnames(tidy_data)[1:2] <- c("subject","activity")    
"Re-sort the data by subject and activity"
tidy_data <- tidy_data[order(tidy_data$subject),]
"The rownames are meaningless"
rownames(tidy_data) <- NULL
```

### 9. The dataframe is reordered by subject and activity to create the final, tidy dataset required, and the data written to a file ("tidy_data.fwf") in fixed width format to aid reading.
```
"Re-sort the data by subject and activity"
tidy_data <- tidy_data[order(tidy_data$subject),]
"The rownames are meaningless"
rownames(tidy_data) <- NULL

#write the data to a tab separated file called "tidy_data.tsv"
write.table(tidy_data,file="tidy_data.tsv",quote=FALSE,sep=" ",row.names=FALSE)
write.fwf(tidy_data,file="tidy_data.fwf",quote=FALSE,sep="  ")

```
