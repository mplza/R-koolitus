# Tidyverse laadimine
library(tidyverse)

# Andmestiku laadimine
library(readxl) 
gapminder <- read_excel("gapminder.xlsx") 

# 1. Leidke unikaalsete Aasia riikide nimed.
gapminder %>%
  filter(continent == 'Asia') %>%
  select(country) %>%
  unique() %>%
  print(n = Inf)

# 2. Millistes Euroopa riikides oli 1992.a aastal rahvaarv üle 10 miljoni? Reastage riigid tähestikulises järjekorras.
gapminder %>%
  filter(continent == 'Europe',
         year == 1992,
         pop > 10000000) %>%
  arrange(country)

# 3. Mitmes Aafrika riigis oli 1982. aastal oodatav eluiga alla 60?
gapminder %>%
  filter(continent == 'Africa',
         year == 1982,
         lifeExp < 60) %>%
  summarize(n_distinct(country))

# 4. Valige üks kontinent ja leidke selle keskmine oodatav eluiga läbi aastate.
gapminder %>%
  filter(continent == 'Americas') %>%
  group_by(continent, year) %>%
  summarize(keskmine_oodatav_eluiga = mean(lifeExp))

# 5. Loogejoonis, mis kujutab valitud riikide rahvaarvu, oodatavat eluiga või SKP-d läbi aastate. Kujundage joonis oma soovi järgi.
gapminder %>%
  filter(country %in% c('Belgium', 'Ireland', 'Austria')) %>%
  ggplot(aes(year, gdpPercap, fill = country)) +
  geom_col(position = 'dodge') 
