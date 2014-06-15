create_dataset <- function(maindir,data_type="train") {
    
    library(stringr)
    data_type <- "test"
    #Read in the activity labels from main directory
    filename <- paste0(maindir,"activity_labels.txt")
    activity_labels <- read.table(filename,header=FALSE,stringsAsFactors=FALSE)
    colnames(activity_labels) <- c("label","activity")
    
    #Read in the features
    filename <- paste0(dirname,"features.txt")
    features <- read.table(filename,header=FALSE)
    colnames(features) <- c("index","feature")
    
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
    #resort so the data has the same sequence as before
    labeled_activity <- labeled_activity[order(labeled_activity[,2]),]
    
    #Which features (columns) have mean and std in them
    col_means <- which(grepl("mean",features[,2]))
    col_std <- which(grepl("std",features[,2]))
    col_all <- sort(c(col_means,col_std))
    col_names <- as.character(features[col_all,2])
    
    #Read in main data
    filename <- paste0(dirname,data_type,"/X_",data_type,".txt")
    x <- read.table(filename)
    
    #Exract those columns
    base_data <- x[,col_all]
    #Add the subject vector
    base_data[,80] <- subject
    #Add the activity vector
    base_data[,81] <- labeled_activity[,3]
    #Give them reasonable names
    colnames(base_data) <- c(col_names,"subject","activity")
    base_data <- base_data[,c(80,81,1:79)]
    
    split_data <- split(base_data,list(base_data$subject,base_data$activity))
    means_list <- lapply(split_data,function(x0) {colMeans(x0[,3:81])})
    means_data <- do.call(rbind.data.frame,means_list)
    tidy_names <- paste0(col_names,"-avg")
    colnames(means_data) <- tidy_names
    split_names <- names(split_data)
    #split_activity <- strsplit(split_names,"[.]")
    split_activity <- str_split_fixed(split_names,"[.]",2)
    tsubject <- as.data.frame(as.numeric(split_activity[,1]))
    #tsubject2 <- as.numeric(tsubject)
    tactivity <- as.data.frame(split_activity[,2],stringsAsFactors=FALSE)
        
    #activity_map <- do.call(rbind.data.frame, split_activity)
    activity_map
    colnames(activity_map) <- c("subject","activity")
    activity_map
    tidy_data <- cbind(tsubject,tactivity,means_data)
    colnames(tidy_data)[1:2] <- c("subject","activity")    
    tidy_data <- tidy_data[order(tidy_data$subject),]
    rownames(tidy_data) <- NULL
    
    
    
    
}

