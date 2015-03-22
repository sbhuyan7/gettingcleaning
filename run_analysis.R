## Reading in txt files from the test folder in the local computer

subject_test <- read.table("./test/subject_test.txt")
y_test <- read.table("./test/y_test.txt")
X_test <- read.table("./test/X_test.txt")

## Reading in txt files from the train folder in the local computer

subject_train <- read.table("./train/subject_train.txt")
y_train <- read.table("./train/y_train.txt")
X_train <- read.table("./train/X_train.txt")

## Reading txt files for features and activity_labels

features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")


##Combining rows for test and train data for subject (id)

subject_total <- rbind(subject_train, subject_test)


##Combining rows for test and train data for y (activity number)

y_total <- rbind(y_train, y_test)


##Combining rows for test and train data for X (561 variables of measurement)

X_total <- rbind(X_train, X_test)

## Changing column names to make it more idenfiable for extraction purposes

colnames(subject_total)= "Subject"

colnames(y_total)= "Activity"

colnames(X_total) <- as.character(features$V2)


## Joining the columnns of the train and test total rows to create a data frame

ttotal <- cbind(subject_total, y_total, X_total)

## Extracting columns which have std and mean measurements.

ttotalextracted <- ttotal[,grep("mean|std|Activity|Subject", colnames(ttotal))]

## Replacing activity numbers with activity labels in the data set

ttotalextracted$Activity <- as.factor(ttotalextracted$Activity)
levels(ttotalextracted$Activity) <- c("Walking","Walking_Upstairs","Walking_Downstairs", "Sitting", "Standing", "Laying")

## Replacing variables names with more acceptable and readable variable name

names(ttotalextracted)<- make.names(names=names(ttotalextracted), unique=TRUE, allow_=TRUE)

##  Transfering contents of ttotalextracted to almost_tidy_data

almost_tidy_data <- ttotalextracted

## Using group_by function to group almost_tidy_data

almost_tidy_data_group_by <- group_by(almost_tidy_data, Subject, Activity)

## Using summarise_each function to find mean to each grpups in the data set

tidy_data <- summarise_each(almost_tidy_data_group_by, funs(mean))



## View tidy data set

View(tidy_data)

## Output file tidy_data.txt to working directory

write.table(tidy_data,file="./tidy_data.txt",row.names=FALSE)







