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

