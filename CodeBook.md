---
title: "CodeBook"
author: "Me"
date: "4/25/2020"
output: word_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This Markdown file acts as a CodeBook for the project at hand.

1. Read in the files and merge data
label files: activity_labels.txt and features.txt
test data: subject_test.txt, X_test.txt (assign column names as feature names), and y_test.txt
training data: subject_train.txt, X_train.txt (assign column names as feature names), and Y_train.txt

merge all training files horizontally into one training data
merge all test files horizontally into one test data
merge the training data and test data vertically into one data

2. Extract only the mean and standard deviation of the measurments
keep the subject Id and actvitiy columns
identify column names with 'mean' or 'std'

3. Use descriptive activity names to name the activities in the data set
change the activity column from numberse 1-6 to descriptive activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.

4. Label the data set with descriptive variable names
remove the () in the columns to make the variable names cleaner and easier to read

5. Create a second, independent tidy data set with the average of each variable for each activity and each subject
utilize the dplyr package to group the data set by subject ID and activity (group_by)

summarize the grouped data set and calculate the average of each variable (summarise_all(funs_mean))
For the detailed script, please refer to the run_analysis.R file


```{r variables for merging}
trainsub, trainx,trainy:- These take the variabe for the training aspect.
testsub,testx,testy:- These take the variable for the testing.
```


```{r variables for mean and standard deviation}
feat.list:- Reads the data set to get required columns.
features:- Converts the list into a vector
filtFeatId:- Gets only the mean and Standard Deviations.
```


```{r other variables}
activites:- read the table for various activities}
filtFeatNames:- This was used to take the features of the activities.
```

