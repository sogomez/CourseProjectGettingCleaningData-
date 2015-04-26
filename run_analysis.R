library(dplyr)

#Loading data from test
subject_test <- read.table("~/test/subject_test.txt", quote="\"")
X_test <- read.table("~/test/X_test.txt", quote="\"")
y_test <- read.table("~/test/y_test.txt", quote="\"")

#Loading data from train
subject_train <- read.table("~/train/subject_train.txt", quote="\"")
X_train <- read.table("~/train/X_train.txt", quote="\"")
y_train <- read.table("~/train/y_train.txt", quote="\"")

# 1.Merges the training and the test sets to create one data set.
subject<-rbind(subject_test, subject_train)
x<-rbind(X_test, X_train)
y<-rbind(y_test, y_train)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
x2<-select(x, V1:V6, V41:V46, V81:V86, V121:V126, V161:V166, V201:V202, V214:V215, V227:V228, V240:V241, V253:V254, V266:V271, V345:V350, V424:V429, V503:V504, V516:V517, V529:V530, V542:V543)

y2<-y

#renaming columns
names(subject)<-"subject"
names(y2)<-"activity"

# 3.Uses descriptive activity names to name the activities in the data set
y2$activity<-replace(y2$activity, y2$activity==1, "WALKING")
y2$activity<-replace(y2$activity, y2$activity==2, "WALKING_UPSTAIRS")
y2$activity<-replace(y2$activity, y2$activity==3, "WALKING_DOWNSTAIRS")
y2$activity<-replace(y2$activity, y2$activity==4, "SITTING")
y2$activity<-replace(y2$activity, y2$activity==5, "STANDING")
y2$activity<-replace(y2$activity, y2$activity==6, "LAYING")

#To create step 4, we load measurements name from file
f <- read.table("~/features.txt", quote="\"")

#Extract column names on mean and standard deviation
f2<-f[c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543),]

#Eliminate characters -, (, )
f2$V2<-gsub("-", "", f2$V2)
f2$V2<-gsub("\\(", "", f2$V2)
f2$V2<-gsub("\\)", "", f2$V2)

# 4.Appropriately labels the data set with descriptive variable names. 
names(x2)<-f2$V2

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
x3<-cbind(subject, y2, x2)
g<-group_by(x3, subject, activity)
tidyDataSet<-summarise_each(g, funs(mean))

# Write file to upload
# write.table(x4, file="tidyDataSet.txt", row.names=FALSE)


