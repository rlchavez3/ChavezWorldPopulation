library(tidyverse)
library(readxl)

WorldPopulation <- read_excel('data-raw/World_Population.xlsx',
                              sheet = 'ESTIMATES', range = 'A17:BZ306')

WorldPopulation <- WorldPopulation %>%
  mutate(CountryName = ifelse(str_detect(Type, '^Country'),
                              `Region, subregion, country or area *`, NA)) %>%
  relocate(CountryName, .before = Index) %>%
  select(1, 9:79) %>%
  drop_na() %>%
  filter(!str_detect(CountryName, ',')) %>%
  mutate_at(vars(2:72), as.numeric)

usethis::use_data(WorldPopulation)
