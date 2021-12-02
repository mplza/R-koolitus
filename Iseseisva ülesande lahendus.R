# Lae töölauale paketid: tidyverse, lubridate
library(tidyverse)
library(lubridate)

# Lae töölauale andmestik Superstore.xlsx
library(readxl)
Superstore <- read_excel("~/Downloads/Superstore.xlsx")
View(Superstore)

# Nimeta andmestik ümber: df
df <- Superstore

# Loo ülevaade andmestikust kasutades funktsioone head(), glimpse() ja summary()
head(df)
glimpse(df)
summary(df)

# 1. küsimus
# Millised on poe erinevad kliendisegmendid, tootekategooriad ja alamkategooriad?
unique(df$Segment)
unique(df$Category)
unique(df$Sub_Category)

# 2. küsimus
# Mitu erinevat toodet kuulub igasse tootekategooriasse ja alamkategooriasse?
# Reasta tulemused kategooriate kaupa suuremast väiksemani.
df %>%
  group_by(Category, Sub_Category) %>%
  summarise(Erinevate_toodete_arv = n_distinct(Product_Name)) %>%
  arrange(Category, desc(Erinevate_toodete_arv))

# 3. küsimus
# Mis on iga kliendisegmendi kõige enimmüüdud toode?
df %>%
  group_by(Segment, Product_Name) %>%
  summarise(mitu_tükki_osteti = sum(Quantity)) %>%
  filter(mitu_tükki_osteti == max(mitu_tükki_osteti))

# 4. küsimus
# Mitu tellimust tegid Wisconsini osariigi ärikliendid 2016. aasta septembris?
df %>%
  mutate(aasta = year(Order_Date),
         kuu = month(Order_Date, label = TRUE)) %>%
  select(Order_ID, aasta, kuu, State, Segment) %>%
  filter(State == 'Wisconsin',
         Segment == 'Corporate',
         aasta == 2016,
         kuu == 'Sep') %>%
  summarise(tellimuste_arv = n_distinct(Order_ID))

# 5. Koosta joonis, mis kujutab tellimuste koguarvu 2017. aastal kuude kaupa kliendisegmentide lõikes.
df %>%
  mutate(aasta = year(Order_Date),
         kuu = month(Order_Date, label = TRUE)) %>%
  filter(aasta == 2017) %>%
  group_by(kuu, Segment) %>%
  summarise(tellimuste_arv = n_distinct(Order_ID)) %>%
  ggplot(aes(kuu, tellimuste_arv, fill = Segment)) +
  geom_col() +
  facet_grid(rows = vars(Segment)) +
  labs(title = '2017. aasta tellimused',
       x = NULL,
       y = NULL)
