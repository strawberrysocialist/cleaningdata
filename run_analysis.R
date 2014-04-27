get.data=FALSE
have.data=FALSE
if (get.data) {
  #STEP 0: Get the data
  url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  data_file<-"./data.zip"
  download.file(url,data_file)
  if (!file.exists(data_file)) {
    stop("Unable to download the data file.")
  }
  unzip(data_file)
  if (!file.exists("./UCI HAR Dataset")) {
    stop("Unable to unzip the data file.")
  }
  file.rename(from=c("UCI HAR Dataset"),to=c("data"))
}

#Confirm data is present
data_files<-c("./data/features.txt",
              "./data/train/X_train.txt",
              "./data/train/y_train.txt",
              "./data/train/subject_train.txt",
              "./data/test/X_test.txt",
              "./data/test/y_test.txt",
              "./data/test/subject_test.txt",
              "./data/activity_labels.txt"
)
files<-file.exists(data_files)
have.data<-all(files)

if (have.data) {
  file_index<-0
  #STEP 1: Merge the data
  #TRAIN DATA
  #Load the labels for the columns
  #"./data/features.txt"
  file_index<-file_index+1
  labels_file<-data_files[file_index]
  labels<-read.table(labels_file,stringsAsFactors=F)
  
  #Load the train data
  #"./data/train/X_train.txt"
  file_index<-file_index+1
  train_file<-data_files[file_index]
  train<-read.table(train_file)
  
  #Load the activity codes for the train data
  #"./data/train/y_train.txt"
  file_index<-file_index+1
  train_file<-data_files[file_index]
  train_y<-read.table(train_file)
  #Combine the actvity codes into the train data
  train<-cbind(train,train_y)
  rm(train_y)
  
  #Load the subjects for the train data
  #"./data/train/subject_train.txt"
  file_index<-file_index+1
  train_file<-data_files[file_index]
  train_subject<-read.table(train_file)
  #Combine the subjects with the train data
  train<-cbind(train_subject,train)
  rm(train_subject)
  
  #Label the columns
  labels<-c("Subject",labels[,2],"Activity")
  colnames(train)<-labels
  
  #TEST DATA
  #Load the test data
  #"./data/test/X_test.txt"
  file_index<-file_index+1
  test_file<-data_files[file_index]
  test<-read.table(test_file)
  
  #Load the activity codes for the test data
  #"./data/test/y_test.txt"
  file_index<-file_index+1
  test_file<-data_files[file_index]
  test_y<-read.table(test_file)
  #Combine the actvity codes into the test data
  test<-cbind(test,test_y)
  rm(test_y)
  
  #Load the subjects for the test data
  #"./data/test/subject_test.txt"
  file_index<-file_index+1
  test_file<-data_files[file_index]
  test_subject<-read.table(test_file)
  #Combine the subjects with the test data
  test<-cbind(test_subject,test)
  rm(test_subject)
  
  #Label the columns
  colnames(test)<-labels
  
  #Merge the train and test data sets
  data<-rbind(train,test)
  rm(train)
  rm(test)
  
  #STEP 2: Extract only the columns with mean and standard deviation measurements
  #Get a vector of the indices for the columns containing mean or standard deviation measurements
  #NOTE: This captures all mean or standard deviation measurements except where the mean or std dev measure is really being used to compute some other measurement, i.e., angle.
  mean_std_cols<-grep("mean|std",labels)
  #Extract those mean or standard deviation measurements
  data<-data[,c(1,mean_std_cols,ncol(data))]
  
  #STEP 3: Get the descriptive names for the activities
  #Load the activty names
  #"./data/activity_labels.txt"
  file_index<-file_index+1
  activity_names_file<-data_files[file_index]
  activity_names<-read.table(activity_names_file,stringsAsFactors=F)
  colnames(activity_names)<-c("Key","Activity")
  
  #STEP 4: Replace the activity codes with the descriptive names
  data$Activity<-factor(data$Activity,labels=activity_names$Activity)
  
  #STEP 5: Generate a new tidy dataset
  library(reshape2)
  id_cols<-labels[c(length(labels),1)]
  #var_cols<-labels[3:length(labels)-1]
  #melted<-melt(data,id.vars=id_cols,measure.vars=var_cols)
  melted<-melt(data,id.vars=id_cols)
  casted<-dcast(melted,Activity + Subject ~ ...,mean)
  head(casted[c(1:3,81)],30)
  
  #STEP 6: Output data frame as text table
  data_file<-"./data.txt"
  write.table(casted,data_file)
}
else {
  err_text<-paste(c("Missing Files: Unable to continue as these files are missing:",data_files[!files]),sep="\n")
  stop(err_text)
}