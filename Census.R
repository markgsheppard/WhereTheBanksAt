#This code has been designed for replication purposes.
#For a project that evaluates the effects of a postal banking, on underbanked communities.

#Please install and load the appropriate packages.
#IPUMS: https://data2.nhgis.org/main
#https://api.census.gov/data/2018/acs/acs5/variables.html
#API KEY: https://api.census.gov/data/key_signup.html
#https://walker-data.com/tidycensus/articles/basic-usage.html#geography-in-tidycensus

#install.packages("usethis")
#install.packages("devtools")
#install.packages("vctrs")
#install.packages("tidycensus")
#install.packages("tidyverse")
#install.packages("sf")
#install.packages("tmap")
#install.packages("usmap")
#install.packages("censusapi")
#install.packages("tmaptools")
#install.packages("leaflet")
#install.packages("dplyr")
#install.packages("na.tools")
#install.packages("rgeos", repos="http://R-Forge.R-project.org", type="source")
#install.packages("rgdal", repos="http://R-Forge.R-project.org", type="source")
#install_github("r-spatial/sf", configure.args = "--with-proj-lib=/usr/local/lib/")
#library(sf)
#library(usethis)
#library(devtools)
#library(vctrs)

#census_api_key("10cde4d62bedba8405563e4ac057760b22a03f07", overwrite = TRUE, install = TRUE)

library(na.tools)
library(tidyverse)
library(tidycensus)

#Download Data
acs_data <- get_acs(
  geography = "county",
  geometry=TRUE,
  year = 2018,
  survey = "acs5",
  output = "wide",
  shift_geo = TRUE,
  variables = c(  
    "B01003_001", # total population
    "B19013_001" # Median Income
    )) %>% rename("County"=NAME, 
                  "Total Population"=B01003_001E, 
                  "Median Income" = B19013_001E) %>%
  select(-B19013_001M, -B01003_001M)

#Fill NA with Mean
acs_data$`Median Income` <- na.mean(acs_data$`Median Income`, option = "mean")

#Graph the Map
ggplot(acs_data) +
  geom_sf(aes(fill= `Median Income`), lwd=0, color = "blue")

#st_join and intercet 
#Alias #Anti-alias
#loop for states 
#Compute average distance
#zcta
#Block group is most granular
#Tract
#Look up the definitions by geometry

#Distance to middle
#Regression of number of banks with median income

devtools::install_github("dkahle/ggmap")
library("ggmap")
register_google(key = "AIzaSyDYYOIZhvSFh6qQG_hiXx950UOYzxgkpjw", write = TRUE)


########################TEST CODE
gc <- geocode("white house, washington dc")
map <- get_map(gc)
(bb <- attr(map, "bb"))
(bbox <- bb2bbox(bb))
# use the bounding box to get a stamen map
stamMap <- get_stamenmap(bbox)
ggmap(map) +
  geom_point(
    aes(x = lon, y = lat),
    data = gc, colour = "red", size = 3
  )

