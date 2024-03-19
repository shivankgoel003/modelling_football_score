#### Preamble ####
# Purpose: Cleans the simulated data
# Author: Shivank Goel
# Date: 23rd February 2024
# Contact: shivankg.goel@mail.utoronto.ca 
# License: MIT

library(tidyverse)
library(dplyr)

# Read the simulated data (assuming it's saved as 'simulated_data.csv')
simulated_data <- read_csv("outputs/data/simulated_data.csv")

# Cleaning the data

# Step 1: Change half of the negative draws to be positive
# Identify the negative observations
negative_indices <- which(simulated_data$Observation < 0)

# Randomly select half of the negative indices
set.seed(123)  # For reproducibility
selected_negatives <- sample(negative_indices, length(negative_indices) / 2)

# Change selected negative values to positive
simulated_data$Observation[selected_negatives] <- abs(simulated_data$Observation[selected_negatives])

# Step 2: Change the decimal place on values between 1 and 1.1
# Identify the observations between 1 and 1.1
decimal_change_indices <- which(simulated_data$Observation >= 1 & simulated_data$Observation <= 1.1)

# Change the decimal place of these observations
simulated_data$Observation[decimal_change_indices] <- simulated_data$Observation[decimal_change_indices] / 10

# Output the cleaned data
write_csv(simulated_data, "outputs/data/cleaned_simulated_data.csv")
