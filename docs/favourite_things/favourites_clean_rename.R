
library(janitor)
library(tidyverse)
library(here)
library(skimr)


favourite <- read_csv(here("favourite_things", "fav_subset.csv"))

#clean names
clean <- favourite %>%
  clean_names() %>%
  rowid_to_column(var = "id") %>%
  select(-timestamp)

#check the names
names(clean)

#rename
renamed <- clean %>%
  rename(raindrops = raindrops_on_roses, 
         whiskers = whiskers_on_kittens, 
         kettles = bright_copper_kettles, 
         mittens = warm_woollen_mittens, 
         packages = brown_paper_packages_tied_up_with_string, 
         age = how_old_are_you, 
         viewings = how_many_times_have_you_seen_the_sound_of_music)

names(renamed)

# make wide data long

long <- renamed %>%
  pivot_longer(cols = raindrops:packages, 
               names_to = "things", values_to = "rating") 


# look at the structure of the data

head(long)

str(long)

glimpse(long)



#get summary

summary(long)

skim(long)

long %>%
  group_by(things) %>%
  summarise(meanrating = mean(rating)) %>%
  ggplot(aes(x = things, y = meanrating)) +
  geom_col()

long %>%
  filter(viewings < 100) %>%
  ggplot(aes(x = age, y = viewings)) +
  geom_point() +
  geom_smooth()
