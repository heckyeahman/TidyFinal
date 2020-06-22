# TidyFinal
#Firstly, I create download and unzip the data, creating a file called UCI HAR Dataset
#Next, I link the train x&y and test x&y data together. Then I merge the datasets to create one called
#merge. The last column (562) of both datasets contains the number corresponding to activity (walking, #sitting, ect). I then added the features data as a final row, so I could find the means/sds.
#Having created a dataset of just the rows that contain either sd or mean data, I added descriptions
#of the activities each row represents.
#Step 4 was to relabel each column with descriptive names. This process cut out my activities column, #so I added it back in.
#Finally, I created a independent data set with the average of each variable for each activity and #each subject. I converted each variable to numbers and assigned the average to variable "avgvar".
#Then I subset each activity separately, so I could combine all of these elements into a data frame.
#Lastly, I deleted the last column, which was coerced into NA's.
