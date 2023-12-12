library(tidyverse)
library(rvest)

page <- read_html('https://en.wikipedia.org/wiki/FIFA_World_Cup')

World_Cup <- page %>%
  html_nodes('table') %>%
  .[[4]] %>%
  html_table(header = FALSE, fill = TRUE) %>% slice(-1 * 1:2) %>%
  magrittr::set_colnames(c('Year', 'Host', 'Venues_Cities', 'Totalattendance',
                           'Matches', 'Averageattendance', 'Number', 'Venue', 'Games')) %>%
  slice(-1 * 23:26) %>%
  select(Year, Host, Matches, Totalattendance, Averageattendance) %>%
  mutate(Averageattendance = str_remove_all(Averageattendance, ','),
         Totalattendance = str_remove_all(Totalattendance, ',')) %>%
  mutate(Averageattendance = as.numeric(Averageattendance),
         Totalattendance = as.numeric(Totalattendance),
         Matches = as.numeric(Matches)) %>%
  mutate(WorldCup = paste(Host, Year)) %>%
  mutate(WorldCup = str_remove_all(WorldCup, ' ')) %>%
  select(WorldCup, Matches, Totalattendance, Averageattendance) %>%
  relocate(WorldCup, .before = Matches)

usethis::use_data(World_Cup)
