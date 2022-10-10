# Tidyverse laadimine
library(...) 

# Andmestiku laadimine
library(readxl) 
gapminder <- read_excel("...") 

# 1. Leidke unikaalsete Aasia riikide nimed.
gapminder %>%
  filter(continent == '...') %>%
  select(...) %>%
  unique() %>%
  print(n = Inf)

# 2. Millistes Euroopa riikides oli 1992.a aastal rahvaarv üle 10 miljoni? Reastage riigid tähestikulises järjekorras.
gapminder %>%
  filter(continent == '...',
         year == ...,
         pop > ...) %>%
  arrange(...)

# 3. Mitmes Aafrika riigis oli 1982. aastal oodatav eluiga alla 60?
gapminder %>%
  filter(continent == '...',
         ... == ...,
         ... < ...) %>%
  summarize(n_distinct(...))

# 4. Valige 3 riiki ja leidke iga riigi keskmine rahvaarv, oodatav eluiga ja SKP.
gapminder %>%
  filter(country %in% c('...', '...', '...')) %>%
  group_by(...) %>%
  summarize(keskmine_rahvaarv = mean(...),
            keskmine_oodatav_eluiga = ...(...),
            keskmine_SKP = ...(...))

# 5. Looge eelmise ülesande lahenduse põhjal joonis, mis kujutab valitud riikide keskmist rahvaarvu, oodatavat eluiga või SKP-d. Lisage joonisele kujundused oma soovi järgi, nt värvige tulbad riikide järgi.
gapminder %>%
  filter(country %in% c('...', '...', '...')) %>%
  group_by(...) %>%
  summarize(... = mean(...)) %>%
  ggplot(aes(..., ..., fill = ...)) +
  geom_col() +
  theme(legend.position = 'none')
