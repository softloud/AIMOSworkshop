library(googledrive)
library(googlesheets4)
library(janitor)
library(tidyverse)

# get sheet from googledrive

(favourite <- drive_get("favourite"))

# read sheet
fav <- read_sheet(favourite)

fav <- as.data.frame(fav)

glimpse(fav)

#select just first verse, 
fav5 <- fav %>%
  select(1:6, 16, 20, 23) 

## write to csv 
write_csv(fav, here("favourite_things", "fav_all.csv"))

## write to csv 
write_csv(fav5, here("favourite_things", "fav_subset.csv"))


          