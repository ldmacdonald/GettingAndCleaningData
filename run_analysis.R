load_data <- function(folder){
  ## Uses current working directory
  dir <- getwd()
  folder_main <- paste(dir,"/", sep="")
  folder_set <- paste(folder_main,folder,"/",sep="")
  X_file <- paste(folder_set,"X_",folder,".txt",sep="")
  y_file <- paste(folder_set,"y_",folder,".txt",sep="")
  sub_file <- paste(folder_set, "subject_", folder, ".txt",sep="")
  ## Create sets for unioning
  X_set <- read.table(X_file, quote="\"")
  X_labels <- read.table(paste(folder_main,"features.txt",sep=""))
  colnames(X_set) <- X_labels[,2]
  y_set <- read.table(y_file,quote="\"")
  colnames(y_set) <- c("Activity_Id")
  subject <- read.table(sub_file,quote="\"")
  colnames(subject) <- c("Subject_Id")
  set <- cbind(subject,y_set,X_set)
  set
}
get_subsetfields <- function(){
  x <- c("Activity_Id","Subject_Id","tBodyAcc-mean()-X","tBodyAcc-mean()-Y",
    "tBodyAcc-mean()-Z","tBodyAcc-std()-X","tBodyAcc-std()-Y","tBodyAcc-std()-Z",
    "tGravityAcc-mean()-X","tGravityAcc-mean()-Y","tGravityAcc-mean()-Z","tGravityAcc-std()-X",
    "tGravityAcc-std()-Y","tGravityAcc-std()-Z","tBodyAccJerk-mean()-X","tBodyAccJerk-mean()-Y",
    "tBodyAccJerk-mean()-Z","tBodyAccJerk-std()-X","tBodyAccJerk-std()-Y","tBodyAccJerk-std()-Z",
    "tBodyGyro-mean()-X","tBodyGyro-mean()-Y","tBodyGyro-mean()-Z","tBodyGyro-std()-X","tBodyGyro-std()-Y",
    "tBodyGyro-std()-Z","tBodyGyroJerk-mean()-X","tBodyGyroJerk-mean()-Y","tBodyGyroJerk-mean()-Z",
    "tBodyGyroJerk-std()-X","tBodyGyroJerk-std()-Y","tBodyGyroJerk-std()-Z","tBodyAccMag-mean()","tBodyAccMag-std()",
    "tGravityAccMag-mean()","tGravityAccMag-std()","tBodyAccJerkMag-mean()","tBodyAccJerkMag-std()","tBodyGyroMag-mean()",
    "tBodyGyroMag-std()","tBodyGyroJerkMag-mean()","tBodyGyroJerkMag-std()","fBodyAcc-mean()-X","fBodyAcc-mean()-Y",
    "fBodyAcc-mean()-Z","fBodyAcc-std()-X","fBodyAcc-std()-Y","fBodyAcc-std()-Z","fBodyAccJerk-mean()-X","fBodyAccJerk-mean()-Y",
    "fBodyAccJerk-mean()-Z","fBodyAccJerk-std()-X","fBodyAccJerk-std()-Y","fBodyAccJerk-std()-Z","fBodyGyro-mean()-X","fBodyGyro-mean()-Y",
    "fBodyGyro-mean()-Z","fBodyGyro-std()-X","fBodyGyro-std()-Y","fBodyGyro-std()-Z","fBodyAccMag-mean()","fBodyAccMag-std()",
    "fBodyBodyAccJerkMag-mean()","fBodyBodyAccJerkMag-std()","fBodyBodyGyroMag-mean()","fBodyBodyGyroMag-std()","fBodyBodyGyroJerkMag-mean()",
    "fBodyBodyGyroJerkMag-std()"
    )
  x
}
run_analysis <- function(){
  test_set <- load_data("test")
  train_set <- load_data("train")
  set <- rbind(test_set,train_set)
  rm(test_set)
  rm(train_set)
  ## This is for reading in the columns from a file
  #subset_fields <- read.table("subset.txt",header=TRUE,quote="\"")
  #subset_name <- as.character(subset_fields$ColName)
  ## This retrieves the columns from a function
  subset_name <-get_subsetfields()
  mid.set<- subset(set,,select=subset_name)
  dir <- getwd()
  unq_sub <- unique(mid.set$Subject_Id)
  unq_act <- unique(mid.set$Activity_Id)
  act_df <- read.table(paste(dir,"/activity_labels.txt",sep=""), quote="\"")

  out.set <- data.frame()
  
  for(i in unq_sub){
    for(a in unq_act){
      sub.set <- subset(mid.set, Subject_Id==i & Activity_Id ==a)
      temp.set <- colMeans(sub.set)
      out.set <- rbind(out.set,temp.set)
    }
  }
  colnames(out.set) <- names(mid.set)
  for ( i in unique(act_df$V1)){
    x <- subset(act_df,V1==i, select=c(V2))
    out.set$Activity_Id[out.set$Activity_Id %in% toString(i)] <- toString(x[[1]])
  }
  out.set
}
