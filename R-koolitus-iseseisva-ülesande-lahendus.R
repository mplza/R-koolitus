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

# 4. Valige 3 riiki ja leidke iga riigi keskmine rahvaarv, oodatav eluiga ja SKP.
gapminder %>%
  filter(country %in% c('Belgium', 'Ireland', 'Austria')) %>%
  group_by(country) %>%
  summarize(keskmine_rahvaarv = mean(pop),
            keskmine_oodatav_eluiga = mean(lifeExp),
            keskmine_SKP = mean(gdpPercap))

# 5. Looge eelmise ülesande lahenduse põhjal joonis, mis kujutab valitud riikide keskmist rahvaarvu, oodatavat eluiga või SKP-d. Lisage joonisele kujundused oma soovi järgi, nt värvige tulbad riikide järgi.
gapminder %>%
  filter(country %in% c('Belgium', 'Ireland', 'Austria')) %>%
  group_by(country) %>%
  summarize(keskmine_SKP = mean(gdpPercap)) %>%
  ggplot(aes(country, keskmine_SKP, fill = country)) +
  geom_col() +
  guides(fill = FALSE)