# data analysis

# load packages 
library(tidyverse)

# grab the data for the analysis 

sample_data <- read_csv("data/sample_data.csv")
glimpse(sample_data)

# summarize 
summarise(sample_data, ave_cells = mean(cells_per_ml))

#syntax
sample_data |> 
  #group the data by environmental group
  group_by(env_group) |> 
  #calculate the mean
  summarise(ave_cells = mean(cells_per_ml))

# filter: subset data by rows based on some value
sample_data |> 
  # subset samples only from the deep
  filter(env_group == "Deep") |> 
  #calculate the mean cell abundance
  summarise(ave_cells = mean(cells_per_ml))

# Mutate: create new data column 

sample_data |> 
  #calculate a new column with the total nitrogen to phosphorus ratio
  mutate(tn_tp_ratio = total_nitrogen/total_phosphorus) |>
  View()

# Select: subset by entire columns
sample_data |> 
  #pick specific columns
  select(sample_id:temperature)
# select(-diss_org_carbon)


#clean up data
