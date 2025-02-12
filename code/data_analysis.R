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

taxon_dirty <- read_csv("data/taxon_abundance.csv", skip = 2)
head(taxon_dirty)

#only pick cyanobacteria 
taxon_clean <- taxon_dirty |> 
  select(sample_id:Cyanobacteria)
dim(taxon_clean)#what are the wide format dimensions
# pivot_longer: shape the data from wide into long format
taxon_long <- taxon_clean |> 
  #shape into log formatted data frame
  pivot_longer(cols = Proteobacteria:Cyanobacteria, 
               names_to = "Phylum", 
               values_to = "Abundance")
dim(taxon_long)

#calculate average abundance of each phylum

taxon_long |> 
  group_by(Phylum) |> 
  summarise(ave_abundance = mean(Abundance))

#plot our data

taxon_long |> 
  ggplot(aes(x = sample_id, y = Abundance, fill = Phylum)) +
  geom_col() + 
  theme(axis.text.x = element_text(angle = 90))

#joining data frames

sample_data |> 
  head(6)

taxon_clean |> 
  head(6)

#inner_join
sample_data |> 
  inner_join(taxon_clean, by = "sample_id") |> 
  dim()

#intuition check on filtering joins
length(unique(taxon_clean$sample_id))
length(unique(sample_data$sample_id))

#anti-join to see which rows are not joining
sample_data |> 
  anti_join(taxon_clean, by = "sample_id")

#fixing september samples 
taxon_clean_good_sept <- taxon_clean |> 
  #replace sample id column with fixed september names
  mutate(sample_id = str_replace(sample_id, "Sep", replacement = "September"))
dim(taxon_clean_good_sept)

#inner_join
sample_and_taxon <- sample_data |> 
  inner_join(taxon_clean_good_sept, by = "sample_id")
 
#intuition check
dim(sample_and_taxon)

#test

stopifnot(nrow(sample_and_taxon) == nrow(sample_data))

# write out our clean data into a new file
write_csv(sample_and_taxon, "data/sample_and_taxon.csv")

#quick plot of chloroflexi

sample_and_taxon |> 
  ggplot(aes(x = depth, y = Chloroflexi)) +
  geom_point() + 
  #add a statistical model
  geom_smooth()
