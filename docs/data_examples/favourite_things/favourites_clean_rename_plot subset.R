# load library

library(janitor)
library(tidyverse)
library(here)
library(skimr)

# read data

fav_things <- read_csv(here("favourite_things", "fav_subset.csv"))

#clean names
clean <- fav_things %>%
  clean_names() %>%
  rowid_to_column(var = "id") %>%
  select(- timestamp)

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


ratings_summary <- long %>%
  group_by(things) %>%
  summarise(mean = mean(rating, na.rm = TRUE), 
            sd = sd(rating, na.rm = TRUE), 
            n = n(), 
            se = sd/sqrt(n)) 

# plot raw 

long %>%
  ggplot(aes(x = age, y = viewings)) +
  geom_point() 

# plot summary - simple plot

ratings_summary %>%
  ggplot(aes(x = things, y = mean)) +
  geom_col()


# summary - bells and whistles plot

long$score <- as.factor(long$score) # make score a factor so the colour work

ratings_summary %>%
  ggplot(aes(x = things, y = mean, fill = things)) +
  geom_col() +
  geom_errorbar(aes(ymin= mean-se, ymax=mean+se),
                size= 0.3,    # thinner lines
                width= 0.2)  +  # skinnier bars 
  theme_classic() +
  theme(legend.position = "none") + #remove legend
  scale_y_continuous(name = "mean rating", 
                     expand = c(0, 0), # make the bars sit on x axis
                     limits = c(0, 7), # extend y axis
                     breaks=c(0, 1, 2, 3, 4, 5, 6, 7))  

