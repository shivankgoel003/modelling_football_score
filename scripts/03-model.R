#### Preamble ####
# Purpose: Poisson Regression Analysis on Top English Football Teams
# Author: Shivank Goel
# Date: 18 March 2024
# Contact: shivankg.goel@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
# Load the football match data
england_data <- read_csv("inputs/raw_data/england.csv")

# Determine the top 5 teams based on win rate
england_wins <- england_data %>%
  mutate(Winner = case_when(
    FTHG > FTAG ~ HomeTeam,
    FTAG > FTHG ~ AwayTeam,
    TRUE ~ 'Draw'
  )) %>%
  filter(Winner != 'Draw') %>%
  count(Winner) %>%
  top_n(5)

# Filter dataset for matches with the top teams
england_top_teams <- england_data %>%
  filter(HomeTeam %in% england_wins$Winner | AwayTeam %in% england_wins$Winner)

# Fit Poisson regression model
# Model Full Time Home Goals as a function of home advantage, half-time result and shots on target
model <- glm(FTHG ~ HomeTeam + HTHG + HTAG + HST,
             data = england_top_teams, family = poisson(link = "log"))

# Print model summary
summary(model)

#### Save model ####
saveRDS(
  model,
  file = "models/poisson_model_england_top_teams.rds"
)
