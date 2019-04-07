# Getting And Cleaning Data

## Step 1:
- Load data from files to R using *read.table* function. There are 8 files:
+ features.txt: list all variables in dataset
+ activity_labels.txt: list all activity
+ For test/train data we have 2 groups for: subject_, y_, and X_ files.

## Step 2:
- Combine test/train data to using *rbind* function

## Step 3:
- Filter X combined data for ONLY mean and standard deviation variable using *grep* function

## Step 4:
- Merge all combined data to one frame using *cbind* function

## Step 5:
- Group by subject, activity and apply summarise mean function for each variables.
- Map activity by name

## Step 6:
- Rename variables columns to match name with tity format name.

## Step 7:
- Write result to file result.txt
- Print head result
