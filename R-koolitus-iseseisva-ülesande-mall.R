# Tidyverse laadimine
library(...) 

# Andmestiku laadimine
library(readxl) 
gapminder <- read_excel("...") 

# Andmestikuga tutvumine
head(...)
glimpse(...)
summary(...)

# Unikaalsed kontinendid ja aastad
unique(gapminder$...)
unique(gapminder$...)

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

# 4. Valige üks kontinent ja leidke selle keskmine oodatav eluiga läbi aastate.
gapminder %>%
  filter(continent == '...') %>%
  group_by(..., ...) %>%
  summarize(keskmine_oodatav_eluiga = mean(...))

# 5. Looge joonis, mis kujutab kolme vabalt valitud riigi rahvaarvu, oodatavat eluiga või SKP-d läbi aastate. Kujundage joonis oma soovi järgi.
gapminder %>%
  filter(country %in% c('...', '...', '...')) %>%
  ggplot(aes(..., ..., fill = ...)) +
  geom_col(position = '...') 
