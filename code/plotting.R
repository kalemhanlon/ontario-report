##Plotting Lake Ontario Microbial Cell Abundances
#by: Kalem
#Date: January 29th, 2025

#load packages
install.packages("tidyverse")
library(tidyverse)


#load in the data
sample_data <- read_csv("sample_data.csv")
View(sample_data)
str(sample_data)

Sys.Date() #what is the date?

?round
round(3.1415)
round(3.1415, 3)

#plotting

ggplot(sample_data) +
  aes(x = temperature, 
      y = cells_per_ml/1000000, 
      colour = env_group, 
      size = chlorophyll) +
  labs(x = "Temp (C)", 
       y = "Cell Abundance (millions/mL)", 
       title = "Does temperature affect microbial abundance", 
       colour = "Environmental Group", 
       size = "Chlorophyll (ug/L)") +
  geom_point() +
  theme_test()



#buoy data

buoy_data <- read_csv("buoy_data.csv")
View(buoy_data)
glimpse(buoy_data)

ggplot(buoy_data) +
  aes(x = day_of_year, y = temperature, colour = buoy, group = sensor) +
  geom_line() 


#facet plot

ggplot(buoy_data) +
  aes(x = day_of_year, y = temperature, colour = buoy, group = sensor) +
  geom_line() +
  facet_grid(rows = vars(buoy), scales = "free")

#Cell abundances by group

ggplot(sample_data) +
  aes(x = env_group, y = cells_per_ml, colour = env_group, fill = env_group) +
  geom_boxplot(alpha = 0.4, outlier.shape = NA) + 
  geom_jitter(aes(size = chlorophyll)) +
  theme_test()

ggsave("cells_per_envGroup.png", width = 6, height = 4)
