#This script creates the tidy data set required for the Getting and Cleaning Data course
#The script will download the zipped data set, unzip the archive, read the appropriate files
#add fields, merge the data, calculate the means and create the tidy dataframe required as part
#of the course, and writes the result to a tab separated file called "tidy_data.tsv"

#Load in required libraries
require(stringr)
require(plyr)

#Read in the zipped data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/HARDataset.zip")
unzip("./data/HARDataset.zip")

#Directory where the unzipped data is
dirname <- "./data/UCI HAR Dataset/"


#A - Read in the two data sets - training & test.
#B - Extract only the measurements on the mean and standard deviation for each measurement.
#C - Use the descriptive activity names to name the columns (use the same names as the column numbers).
#D - Use the activity data (y or the output data) and attach the descriptive activity names.
#E - create a second dataset with the average of each variable per activity per subject.

#Read in the activity labels from main directory
filename <- paste0(maindir,"activity_labels.txt")
activity_labels <- read.table(filename,header=FALSE,stringsAsFactors=FALSE)
colnames(activity_labels) <- c("label","activity")

#Read in the features
filename <- paste0(dirname,"features.txt")
features <- read.table(filename,header=FALSE)
colnames(features) <- c("index","feature")

#Which features (columns) have mean and std in them
col_means <- which(grepl("mean",features[,2]))
col_std <- which(grepl("std",features[,2]))
col_all <- sort(c(col_means,col_std))
col_names <- as.character(features[col_all,2])

#Use the function "create_base_data to create the base data required for the final tidy dataset
#Using the column indices. Add subject and activity names
#Extract "test" data
base_data <- NULL
base_data <- create_base_data(col_all,activity_label,"test")
#Append "train" data
base_data <- rbind(base_data,create_base_data(col_all,activity_label,"train"))

#Split the data based on subject and activity
split_data <- split(base_data,list(base_data$subject,base_data$activity))
#Calculate the means for all the columns, per split
means_list <- lapply(split_data,function(x0) {colMeans(x0[,3:81])})
#create a dataframe with the means data in list format
means_data <- do.call(rbind.data.frame,means_list)

#Create new column names indicating these are calculated means (append "avg" to all existing names)
tidy_names <- paste0(col_names,"-av")
tidy_names <- gsub("mean","mn",tidy_names)
tidy_names <- gsub("std","sd",tidy_names)
tidy_names <- gsub("Acc","Ac",tidy_names)
tidy_names <- gsub("Body","Bd",tidy_names)
tidy_names <- gsub("Gravity","Gr",tidy_names)
tidy_names <- gsub("Gyro","Gy",tidy_names)
tidy_names <- gsub("avg","av",tidy_names)
tidy_names <- gsub("Freq","Fr",tidy_names)
tidy_names <- gsub("Jerk","Jr",tidy_names)
tidy_names <- gsub("\\()","",tidy_names)

#Name the columns
colnames(means_data) <- tidy_names
#The list names are comprised of the subject, and the activity names
#Extract both to attach back to the dataframe
split_names <- names(split_data)
#using the function from the stringr package, splits the names into 2 parts
split_sub_act <- str_split_fixed(split_names,"[.]",2)
subject <- as.data.frame(as.numeric(split_sub_act[,1]))
activity <- as.data.frame(split_sub_act[,2],stringsAsFactors=FALSE)
    
#add the subject and activity to the means data
tidy_data <- cbind(subject,activity,means_data)
colnames(tidy_data)[1:2] <- c("subject","activity")    
"Re-sort the data by subject and activity"
tidy_data <- tidy_data[order(tidy_data$subject),]
"The rownames are meaningless"
rownames(tidy_data) <- NULL

#write the data to a tab separated file called "tidy_data.tsv"
write.table(tidy_data,file="tidy_data.tsv",quote=FALSE,sep=" ",row.names=FALSE)
write.fwf(tidy_data,file="tidy_data.fwf",quote=FALSE,sep="  ")

## Function to create the base data with relevant columns and attributes
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

