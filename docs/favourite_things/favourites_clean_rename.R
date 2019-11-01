
library(janitor)
library(tidyverse)
library(here)


fav <- read_csv(here("favourite_things", "favourite.csv"))

#clean names
clean <- fav %>%
  clean_names()

#check the names
names(clean)

#rename
renamed <- clean %>%
  rename(raindrops = raindrops_on_roses, 
         whiskers = whiskers_on_kittens, 
         kettles = bright_copper_kettles, 
         mittens = warm_woollen_mittens, 
         packages = brown_paper_packages_tied_up_with_string, 
         ponies = cream_colored_ponies, 
         strudels = crisp_apple_strudels, 
         schnitzel = schnitzel_with_noodles, 
         geese = wild_geese_that_fly_with_the_moon_on_their_wings, 
         sashes = girls_in_white_dresses_with_blue_satin_sashes, 
         snowflakes = snowflakes_that_stay_on_my_nose_and_eyelashes, 
         winters = silver_white_winters_that_melt_into_springs, 
         viewings = how_many_times_do_you_think_you_have_you_seen_the_sound_of_music)


# make wide data long

long <- renamed %>%
  pivot_longer(cols = raindrops:winters, 
               names_to = "things", values_to = "rating") 


# define groups of things

animals <- c("whiskers", "ponies", "geese")

weather <- c("raindrops", "snowflakes", "winters")

food <- c("strudels", "schnitzel")

other <- c("sashes", "packages", "mittens", "kettles")

bells <- c("doorbells", "sleighbells")

# make a new column classifying the things

typed <- long %>%
  mutate(type = if_else(things %in% animals, "animals", 
                  if_else(things %in% weather, "weather",
                    if_else(things %in% food, "food", 
                    if_else(things %in% bells, "bells",
                      if_else(things %in% other, "other", "none"))))))


         

