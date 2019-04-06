# Import library
library(dplyr)

# Common variable
data_folder <- "./dataset"
test_folder <- sprintf("%s/test", data_folder)
train_folder <- sprintf("%s/train", data_folder)

# Load data from files
feature <- read.table(sprintf("%s/features.txt", data_folder), col.names = c("id", "name"))
labels <- read.table(sprintf("%s/activity_labels.txt", data_folder), col.names = c("id", "name"))

subject_test <- read.table(sprintf("%s/subject_test.txt", test_folder), col.names=c("subject"))
y_test <- read.table(sprintf("%s/y_test.txt", test_folder), col.names=c("activity"))
X_test <- read.table(sprintf("%s/X_test.txt", test_folder))

subject_train <- read.table(sprintf("%s/subject_train.txt", train_folder), col.names=c("subject"))
y_train <- read.table(sprintf("%s/y_train.txt", train_folder), col.names=c("activity"))
X_train <- read.table(sprintf("%s/X_train.txt", train_folder))

# Processing
## Combine test/train data
subject_val <- rbind(subject_test, subject_train)
y_val <- rbind(y_test, y_train)
X_val <- rbind(X_test, X_train)

## Filter mean and std
X_val <- X_val[, grep("mean|std", feature$name)]

## Merge data
merged_data <- cbind(subject_val, y_val, X_val)

# Group data
result <- merged_data %>% 
        group_by(subject, activity) %>% 
        summarise_each(funs(mean(., na.rm = TRUE))) %>%
        mutate(activity = labels[activity, c("name")])

# Rename variable columns
variable_cols <- grep("mean|std", feature$name, value = TRUE)
variable_cols <- gsub('\\(|\\)', '', variable_cols)
variable_cols <- gsub('-', '.', variable_cols)
variable_cols <- tolower(variable_cols)
colnames(result)[3:ncol(result)] <- variable_cols

# Write result
write.table(result, file=sprintf("%s/result.txt", data_folder), row.names = FALSE)

# Print head
head(result)
