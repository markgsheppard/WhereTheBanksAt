#This code has been designed for replication purposes.
#For a project that evaluates the effects of a postal banking, on underbanked communities.


#Please install and load the appropriate packages.
#IPUMS: https://data2.nhgis.org/main
#https://api.census.gov/data/2018/acs/acs5/variables.html
#API KEY: https://api.census.gov/data/key_signup.html
#https://walker-data.com/tidycensus/articles/basic-usage.html#geography-in-tidycensus
#install.packages("tidycensus")
#install.packages("sf")
#install.packages("tmap")
#install.packages("usmap")
#census_api_key("10cde4d62bedba8405563e4ac057760b22a03f07")
library(tidycensus)
library(tidyverse)
library(ggplot2)
library(sf)
library(tmap)
library(usmap)

acs_data <- get_acs(
  geography = "state",
  geometry=TRUE,
  year = 2018,
  survey = "acs5",  #geometry = TRUE,
  variables = c(  
    "B01003_001", # total population
    "B19013_001" # Median Income
    ))

acs_data_2 <- acs_data %>% 
  select(-GEOID,-moe) %>%
  spread(key = variable, value = estimate) %>%
  rename("state"=NAME, "Total Population"=B01003_001, "Median Income" = B19013_001)


plot_usmap(
  data = acs_data_2, values = "Median Income", include = c("California", "Idaho", "Nevada", "Oregon", "Washington"), color = "white"
) + 
  scale_fill_continuous(
    low = "white", high = "grey", name = "Income (2018)", label = scales::comma
  ) + 
  labs(title = "Western US States", subtitle = "These are the states in the Pacific Timezone.") +
  theme(legend.position = "right")