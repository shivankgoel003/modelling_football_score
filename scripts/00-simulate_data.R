#### Preamble ####
# Purpose: Simulate a scenario where a data generating process is affected by 
#instrument and human errors
# Author: Shivank Goel
# Date: 23rd February
# Contact: shivankg.goel@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have installed the 'tidyverse' and 'dplyr' packages.

#### Workspace setup ####

library(tidyverse)
library(dplyr)

#### Simulate data ####
set.seed(123)  # Setting a seed for reproducibility

# Parameters for the true data generating process
mu <- 1    # Mean
sigma <- 1 # Standard deviation
n <- 1000  # Number of observations

# Generating a sample from the normal distribution
sample <- rnorm(n, mean = mu, sd = sigma)

# Simulating the instrument error (over-writing the last 100 observations with the first 100)
sample[(n-99):n] <- sample[1:100]



# Creating a DataFrame for the sample
df <- data.frame(Observation = sample)

write_csv(df, "outputs/data/simulated_data.csv")
