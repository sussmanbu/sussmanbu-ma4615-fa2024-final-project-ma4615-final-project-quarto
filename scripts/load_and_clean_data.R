# This script loads and cleans the crash reporting data
# Creates a cleaned dataset for analysis

# Load required libraries
library(tidyverse)
library(lubridate)
library(skimr)
library(here)

# Read the raw crash data
# Using here package to handle file paths properly
crash_df <- read.csv(here::here("dataset", "Crash_Reporting_-_Drivers_Data.csv"))

# Define threshold for removing columns with too many missing values
threshold <- 0.8

# Clean the data:
# 1. Remove columns with high percentage of missing values
data_clean <- crash_df |>
  select_if(~ mean(is.na(.)) < threshold)

# 2. Convert case number to character
data_clean <- data_clean |>
  mutate(Local.Case.Number = as.character(Local.Case.Number))

# 3. Convert crash date/time to proper datetime format
data_clean <- data_clean |>
  mutate(Crash.Date.Time = mdy_hms(Crash.Date.Time))

# 4. Handle missing values in route type if the column exists
if("Route_Type" %in% names(data_clean)) {
  most_common_route <- names(which.max(table(data_clean$Route_Type[!is.na(data_clean$Route_Type)])))
  data_clean <- data_clean |>
    mutate(Route_Type = replace_na(Route_Type, most_common_route))
}

# 5. Remove duplicate rows
data_clean <- data_clean |>
  distinct()

# Create a subset of the data for exploration purposes
subset_data <- data_clean |>
  slice(1:1000) # Adjust sample size as needed

# Save the cleaned datasets
# Full dataset
saveRDS(data_clean, file = here::here("dataset", "cleaned_dataset_full.rds"))
# Subset for exploration
saveRDS(subset_data, file = here::here("dataset", "cleaned_dataset.rds"))

# Print summary of cleaned data
summary(data_clean)