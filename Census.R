#IPUMS: https://data2.nhgis.org/main
#https://api.census.gov/data/2018/acs/acs5/variables.html
#API KEY: https://api.census.gov/data/key_signup.html
install.packages("tidycensus")
library(tidycensus)
census_api_key("10cde4d62bedba8405563e4ac057760b22a03f07")


acs_data <- get_acs(
  geography = "tracts",
  year = 2018,
  survey = "acs5",  #geometry = TRUE,
  variables = c(  
    "B01003_001", # total population
    "B19013_001" # median household income in the last 12 months (2018 inflation-adjusted dollars)
  ))

