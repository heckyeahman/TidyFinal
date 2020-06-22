download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "~/DSC2020/TidyFinal/data.zip")
unzip("~/DSC2020/TidyFinal/data.zip")
#This creates in my directory a file named UCI HAR Dataset,
#which contains all the datasets I need. Next, I load them 
#into tables.
activitylabels<-read.table("~/DSC2020/TidyFinal/UCI HAR Dataset/activity_labels.txt")
X_train<-read.table("~/DSC2020/TidyFinal/UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("~/DSC2020/TidyFinal/UCI HAR Dataset/train/Y_train.txt")
Y_test<-read.table("~/DSC2020/TidyFinal/UCI HAR Dataset/test/Y_test.txt")
X_test<-read.table("~/DSC2020/TidyFinal/UCI HAR Dataset/test/X_test.txt")
#Next, I need to link the train x&y and test x&y
#data together. Then I can merge the datasets.
test<-cbind(X_test,Y_test)
train<-cbind(X_train,Y_train)
merge<-rbind(test,train)
#The last column (562) of both datasets contains
#the number corresponding to the activity. Now I add the features data
#as a final row, so I can find the means/sds.
features<-read.table("~/DSC2020/TidyFinal/UCI HAR Dataset/features.txt")
merge2<-rbind(merge, features$V2)
sdmean<-grep("mean|std", merge2)
subbed<-merge2[,sdmean]
#Now I have a dataset of just the rows that contain
#either sd or mean data. I need to add descriptions
#of the activities each row represents.
nolabels<-subbed[1:79]
activities<-factor(subbed$V1.1, levels = 1:6, labels = activitylabels$V2)
wfactors<-cbind(nolabels,activities)
#Step 4 is to relabel each column with descriptive names.
named<-`names<-`(wfactors[,1:79], wfactors[10300,1:79])
#This cut out my activities column, so I'll add it back in.
named2<- cbind(named,activities)
#Finally, I create a independent data set with the average of
#each variable for each activity and each subject.
#I convert each variable to numeric with:
numer<-apply(named2, c(1,2), as.numeric)
avgvar<-apply(numer,2, mean, na.rm =TRUE)
#Now I'll subset each activity
walking<-grep("WALKING$", named2$activities)
walking<-named2[walking,]
walkingn<-apply(walking, c(1,2), as.numeric)
avgwalking<-apply(walkingn,2,mean,na.rm =TRUE)

walking_upstairs<-grep("WALKING_UPSTAIRS", named2$activities)
walking_upstairs<-named2[walking_upstairs,]
walking_upstairsn<-apply(walking_upstairs, c(1,2), as.numeric)
avgupstairs<- apply(walking_upstairsn,2,mean,na.rm =TRUE)

wdownstairs<- grep("WALKING_DOWNSTAIRS", named2$activities)
wdownstairs<- named2[wdownstairs,]
wdownstairsn<-apply(wdownstairs, c(1,2), as.numeric)
avgdownstairs<- apply(wdownstairsn,2,mean,na.rm =TRUE)

sitting<- grep("SITTING", named2$activities)
sitting<- named2[sitting,]
sittingn<-apply(sitting, c(1,2), as.numeric)
avgsitting<- apply(sittingn,2,mean,na.rm =TRUE)

standing<- grep("STANDING", named2$activities)
standing<- named2[standing,]
standingn<-apply(standing, c(1,2), as.numeric)
avgstanding<- apply(standingn,2,mean,na.rm =TRUE)

laying<- grep("LAYING", named2$activities)
laying<- named2[laying,]
layingn<-apply(laying, c(1,2), as.numeric)
avglaying<- apply(layingn,2,mean,na.rm =TRUE)
#combine all avgs into a dataframe.
finaldataframe<-rbind(avgvar,avgwalking,avgupstairs,avgdownstairs,avgsitting,avgstanding,avglaying)
#delete the last column, which was coerced into NA's
finaldataframe<-finaldataframe[,1:79]