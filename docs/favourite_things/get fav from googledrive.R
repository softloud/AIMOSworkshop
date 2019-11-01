library(googledrive)
library(googlesheets4)
library(janitor)
library(tidyverse)

# get sheet from googledrive

(favourite <- drive_get("favourite"))

# read sheet
fav <- read_sheet(favourite)

#### Charles probably wont be able to get doc from googledrive, so write to csv for her
write_csv(fav, "favourite.csv")