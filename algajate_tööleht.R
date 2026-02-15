# R õppepäeva tööleht


## 2.4 RStudio töökeskkond ja koodi jooksutamine

# Kirjutage konsooli suvalisi arvutustehteid ja vaadake, mis juhtub!

2+3 # liitmine
12-8 # lahutamine
6*5 # korrutamine
90/10 # jagamine
(2+3)*5 # tehe sulgudega

10%%3 # modulo ehk jagatise jääk
10%/%3 # täisarvuline jagatis

1:10 # reastab kõik arvud 1st 10ni

# Kirjutage konsooli ükshaaval järgmised käsud ja vaadake, mis juhtub!

Sys.time()
Sys.timezone()
difftime(Sys.time(), '2023-09-01', units = 'days')

# Objektide loomine: objekt <- väärtus

nimi <- 'Mari'
mida_teeb <- 'töötab'
kus <- 'Tallinnas'
paste(nimi, mida_teeb, kus, sep = ' ') # kleebime need omavahel kokku

miks <- 'see on huvitav'
paste('Õpin R-i, sest', miks, sep = ' ') # kleebime need omavahel kokku

## 3. Tidyverse

#install.packages('tidyverse') # installi Tidyverse paketid 
library(tidyverse) # lae Tidyverse tuumikpaketid töökeskkonda

# 2. SISSEJUHATUS

### 2.1 Andmete importimine

library(readxl)
Superstore_clean <- read_excel("Superstore_clean.xlsx")
View(Superstore_clean)      

gapminder <- read_excel("gapminder.xlsx")
View(gapminder)

### 2.2 Andmetega tutvumine: põhilised funktsioonid

View(gapminder) # ava andmestik vahelehel

head(gapminder) # esimesed 6 rida
tail(gapminder) # viimased 6 rida

head(gapminder, 3) # esimesed 3 rida

names(gapminder) # veergude pealkirjad

str(gapminder) # struktuuri kirjeldus

summary(gapminder) # statistiline kokkuvõte

# glimpse() - mugav ülevaade
glimpse(gapminder)
 
gapminder$continent # kõik selle veeru väärtused
head(gapminder$continent, 10) # selle veeru esimesed 10 rida

# unique() - vektori unikaalsed väärtused 
unique(gapminder$continent)

### Ülesanne

# Leidke veergude `Country`, `Segment`, `Category` & `Sub_Category` unikaalsed väärtused.

unique(gapminder$...)


### 2.3 Summaarsed funktsioonid

# min() - miinimumväärtus 
min(gapminder$lifeExp) 

# max() - maksimumväärtus 
max(gapminder$lifeExp) 

# sum() - liida kokku 
sum(gapminder$lifeExp) 

# mean() - aritmeetiline keskmine 
mean(gapminder$lifeExp) 

# median() - mediaanväärtus 
median(gapminder$lifeExp) 

# sd() - standardhälve 
sd(gapminder$lifeExp) 

# round() - ümardamine
round(mean(gapminder$lifeExp))


### Ülesanne

# Leidke need väärtused veerule `pop`.

...(gapminder$pop)


### 2.4 Toru

# Toruta
round(mean(gapminder$gdpPercap))

# Toruga
gapminder$gdpPercap %>%
  mean() %>%
  round()


### Ülesanne

# Kirjutage toru abil kood, mis esmalt leiab kõrgeima oodatava eluea ja seejärel ümardab tulemuse.
  
gapminder$... %>%
  max() %>%
  round()


### 3. Andmetüübid ja -struktuurid

# andmeobjekti tüüp
class(gapminder)
 
# andmetüüp veerus
class(gapminder$country)
class(gapminder$continent)
class(gapminder$year)
class(gapminder$lifeExp)
class(gapminder$pop)
class(gapminder$gdpPercap)

# Kuidas ise andmeobjekte luua?
  
# Loome vektorid
kuupäev <- c("24.02.1918", "24.10.1870", "17.02.2006", "23.04.1343", "02.02.1920", "14.09.1524", "20.08.1991", "25.06.1775") 
sündmus <- c("Iseseisvumine", "Esimese raudteeliini avamine", "KUMU avamine", "Jüriöö ülestõus", "Tartu rahu", "Tallinna kirikute rüüstamine", "Taasiseseisvumine", "Tartu suurpõleng") 

# Loome andmeraami vektoritest
ee_sündmused <- tibble(kuupäev, sündmus) # loome vektoritest tibble andmeraami
ee_sündmused

# Mis on selle objekti tüüp?
class(ee_sündmused)


# 3. PRAKTILINE ANDMETÖÖTLUS I: dplyr

### 3.1.1 select()

# valime veerud
gapminder %>% 
  select(country, year, pop) 

# valime veerud country kuni lifeExp
gapminder %>% 
  select(country:lifeExp) 

# jätame ühe veeru kõrvale
gapminder %>%
  select(-gdpPercap)

# jätame mitu veergu kõrvale
gapminder %>%
  select(-c(pop, gdpPercap))

# Veergude valimine tunnuse järgi**

gapminder %>%
  select(starts_with('life'))

gapminder %>%
  select(ends_with('p'))

gapminder %>%
  select(contains('co'))


### 3.1.2 filter()

#### Loogilised operaatorid I

# kõik read, kus riik on Canada
gapminder %>%
  filter(country == 'Canada')

# valime kõik read, kus lifeExp on vähemalt 75
gapminder %>%
  filter(lifeExp >= 75)

# valime kõik read, kus ostumma on alla 60
gapminder %>%
  filter(lifeExp < 60)

#### Loogilised operaatorid II

# kõik read, kus riik on Canad
gapminder %>%
  filter(country == 'Canada')

# kõik read, kus riik on Canada ja aasta on 1992
gapminder %>%
  filter(country == 'Canada',
         year == 1992)

# kõik read, kus riik on Canada ja aasta ei ole 1992
gapminder %>%
  filter(country == 'Canada',
         year != 1992)

# Kõik read, kus riik on Canada või Argentina - operaatoriga |
gapminder %>%
  filter(country == 'Canada' | country == 'Argentina')

# Kõik read, kus riik on Canada või Argentina - kuulub hulka
gapminder %>%
  filter(country %in% c('Canada', 'Argentina'))

# Ei kuulu hulka
gapminder %>%
  filter(!continent %in% c('Africa', 'Asia'))


### Ülesanne

# Milline on olnud Saksamaa rahvaarv läbi aastate?

gapminder %>%
  select(..., ..., ...) %>%
  filter(... == ...)

# Millisel aastal ületas Saksamaa rahvaarv 8 miljoni piiri?

gapminder %>%
  select(..., ..., ...) %>%
  filter(... == ..., 
         ... > ...)

# Milline oli Albaania oodatav eluiga 1952. ja 2007. aastal?

gapminder %>%
  select(..., ..., ...) %>%
  filter(... == ..., 
         ... %in% c(..., ...))


### 3.1.3 mutate()

# Loome uue veeru - kas oodatav eluiga on kõrge või madal
gapminder %>% 
  mutate(oodatav_eluiga = if_else(lifeExp > 70, "kõrge", "madal"))

# Muudame olemasoleva veeru väärtust - lifeExp ümardatud
gapminder %>%
  mutate(lifeExp = round(lifeExp))

# Lisa uus veerg riigi keskmise rahvaarvuga - Norra näitel
gapminder %>%
  select(country, year, pop) %>%
  filter(country == 'Norway') %>%
  group_by(country) %>%
  mutate(keskmine_rahvaarv = mean(pop)) %>%
  ungroup()


### Ülesanne

# Lisage veerg, mis näitab, kas riigi rahvaarv ületab 10 miljonit.

gapminder %>%
  mutate(... = if_else(... > ..., ..., ...))


### 3.1.4 arrange()

# Euroopa riigid järjestatuna rahvaarvu järgi 2007.a - väiksemast suuremani
gapminder %>%
  filter(continent == 'Europe',
         year == 2007) %>%
  select(country, pop) %>%
  arrange(pop) %>%
  print(n = Inf)

# Euroopa riigid järjestatuna rahvaarvu järgi 2007.a - suuremast väiksemast
gapminder %>%
  filter(continent == 'Europe',
         year == 2007) %>%
  select(country, pop) %>%
  arrange(desc(pop)) %>%
  print(n = Inf)


### Ülesanne

# Reastage Euroopa riigid tähestikulises järjekorras.

gapminder %>%
  filter(... == ...) %>%
  select(...) %>%
  distinct() %>% 
  arrange() %>%
  print(n = Inf) 

# Leidke 10 kõige kõrgema SKP-ga Aasia riiki 2002. aastal.

gapminder %>%
  filter(... == ...,
         ... == ...) %>%
  select(..., ...) %>%
  arrange(desc(...)) %>%
  head(10)


### 3.1.5 summarize()

# Unikaalsete riikide arv
gapminder %>%
  summarize(riikide_arv = n_distinct(country))

# Unikaalsete riikide arv kontinentide kaupa
gapminder %>%
  group_by(continent) %>%
  summarize(riikide_arv = n_distinct(country), .groups = 'drop')


# Kõige kõrgema rahvaarvuga riigid 2007.a kontinentide kaupa - ainult riik
gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  arrange(desc(pop)) %>%
  summarise(kõige_kõrgem_rahvaarv = first(country), .groups = 'drop')

# Kõige kõrgema rahvaarvuga riigid 2007.a kontinentide kaupa - riik ja rahvaarv
gapminder %>%
  group_by(year, continent) %>%
  mutate(max_pop = max(pop)) %>% # sama aasta ja kontinendi max väärtus
  ungroup %>%
  filter(year == 2007,
         pop == max_pop) %>%
  select(country, pop)


### Ülesanne

# Leia kõige kõrgema ja madalama oodatava elueaga riigid igal aastal.

gapminder %>%
  group_by(year) %>%
  arrange(desc(lifeExp)) %>%
  summarise(esimene = first(country),
            viimane = last(country),
            .groups = 'drop')


## 4. PRAKTILINE ANDMETÖÖTLUS II: lubridate

### 4.1 Kuupäevade korrastamine

# Üritage jooksutada järgnevaid käske:

today()
now()

class(20180308) 
class('2021/03/june') 
class('Sept 20, 2021')

# R tunneb kuupäevad ära:
ymd(20180308) 
ydm('2021/03/june') 
mdy('Sept 20, 2021')

# Saame sellele kinnitust:
ymd(20180308) %>%
  class()


### Ülesanne

# Tuleme tagasi väikese andmestiku juurde, kus on mõningad sündmused Eesti ajaloost.

ee_sündmused

# Mida märkate seoses kuupäeva veeruga?
# Kuidas saame luua uue andmestiku ee_sündmused1, kus kuupäevad oleksid uues veerus uus_kuupäev standardsel YYY-MM-DD kujul?**

ee_sündmused1 <- ee_sündmused %>% 
  mutate(uus_kuupäev = ...(...))
ee_sündmused1

ee_sündmused1 <- ee_sündmused %>% 
  mutate(uus_kuupäev = dmy(kuupäev))
ee_sündmused1


### 4.2 Ajaliste komponentide eraldamine

# Praegune aasta
year(now()) 

# Kvartal
quarter(now())

# Kuu
month(now())
month(now(), label = TRUE, abbr = TRUE) 

# Nädal
week(now()) 

# Nädalapäev
wday(now(), week_start = 1)
wday(now(), week_start = 1, label = TRUE, abbr = FALSE) 

# Lisame uued veerud andmestikku ja salvestame uude andmestikku ee_sündmused2:

# Lisame veerud
ee_sündmused2 <- ee_sündmused1 %>%
  mutate(Aasta = year(uus_kuupäev),
         Kvartal = quarter(uus_kuupäev),
         Kuu = month(uus_kuupäev, label = TRUE),
         Nädal = week(uus_kuupäev),
         Nädalapäev = wday(uus_kuupäev, week_start = 1, label = TRUE))

ee_sündmused2

# Kuupäeva komponendi eraldamine
now() # praegune kuupäev ja kellaaeg
today() # tänane kuupäev
date(now()) # annab sama tulemuse mis today()


### 4.3 Kuupäevade ümardamine

# praegune kuupäev ja kellaaeg 
now()
# praegune kuupäev
today()

# Ümarda nädala esimese päevani
round_date(today(), 'week', week_start = 1)

# Ümarda lähima järgneva esmaspäevani 
floor_date(today(), 'week', week_start = 1)

# Ümarda lähima järgneva esmaspäevani
ceiling_date(today(), 'week', week_start = 1)


### Ülesanne

# Ümardage praegune aeg lähima täistunnini.

now() %>%
  round_date(...)

# Leidke käesoleva kuu esimene kuupäev.

floor_date(...)

# Leidke järgneva kvartali esimene kuupäev.

... %>%
  ...(...)


# Tuleme nüüd andmestiku `Superstore_clean` juurde, mis on varasemalt töölauale laetud.
# Võtke viis minutit, et andmestikuga põgusalt tutvuda:

glimpse(Superstore_clean)
summary(Superstore_clean)
View(Superstore_clean)


### Ülesanne

# Kahel esimesel real kordub sama tellimuse ID. Miks see nii on?

# Vihje: see kirjeldab andmestiku granulaarsust ehk detailsust rea tasandil - vastab küsimusele "mida tähistab üks rida?"

# Loome kaks uut andmestikku:

# Vähendatud andmestik df, mis kirjeldab iga tellimuse müügitulemusi
df <- Superstore_clean %>%
  mutate(Tellimuse_kuupäev = date(Order_Date),
         Tarne_kuupäev = date(Ship_Date),
         Kuu_aasta = floor_date(Tellimuse_kuupäev, 'month')) %>%
  group_by(Order_ID, Tellimuse_kuupäev, Tarne_kuupäev, Kuu_aasta, Segment) %>%
  summarise(Müük = sum(Sales),
            Kogus = sum(Quantity),
            Kasum = sum(Profit),
            .groups = 'drop') 

df

# Vähendatud andmestik tellimused, mis kirjeldab müügitulemusi aasta, kuu ja kliendisegmendi kaupa
tellimused <- df %>%
  group_by(Kuu_aasta, Segment) %>%
  summarise(Tellimuste_arv = n(),
            Müük = sum(Müük),
            Kogus = sum(Kogus),
            Kasum = sum(Kasum),
            .groups = 'drop') 

tellimused


### 4.4 Kahe kuupäeva vahelise aja arvutamine

# lubridate'iga
df %>%
  select(Order_ID, Tellimuse_kuupäev, Tarne_kuupäev) %>%
  mutate(
    interval = interval(Tellimuse_kuupäev, Tarne_kuupäev),
    duration = as.duration(interval),
    period = as.period(interval),
    difftime_days = make_difftime(interval, unit = 'days'),
    difftime_days_num = as.integer(difftime_days),
  ) 


### Ülesanne

# Leia keskmine tellimuse esitamisest kuni väljastamiseni kulunud aeg päevades kliendisegmentide lõikes.

df %>%
  mutate(
    interval = interval(..., ...),
    difftime_days = (make_difftime(..., unit = 'days')),
    difftime_days_num = as.integer(...)) %>%
  group_by(...) %>%
  summarise(Keskmine_aeg = mean(...))

# Arvuta tellimuse arv tarneni kulunud päevade kaupa.

df %>%
  mutate(
    interval = interval(..., ...),
    difftime_days = (make_difftime(..., unit = 'days'))) %>%
  group_by(...) %>%
  summarise(kokku = n())


## 5. ANDMETE VISUALISEERIMINE (ggplot2)

### 5.2 Hajuvusdiagramm

gapminder %>%
  filter(year == 2007) %>%
  ggplot(aes(lifeExp, gdpPercap)) +
  geom_point()

# Värvi täpid kontinendi järgi
gapminder %>%
  filter(year == 2007) %>%
  ggplot(aes(lifeExp, gdpPercap, color = continent)) +
  geom_point()

# Värvi täpid populatsiooni järgi
# options(scipen = 999) # lülita välja teaduslik notatsioon
gapminder %>%
  filter(year == 2007) %>%
  ggplot(aes(lifeExp, gdpPercap, color = pop)) +
  geom_point()

# Värvi kõik täpid ühte värvi
gapminder %>%
  filter(year == 2007) %>%
  ggplot(aes(lifeExp, gdpPercap)) +
  geom_point(color = 'darkgreen')


#### Ülesanne

# Loo andmestiku df põhjal hajuvusdiagramm, mis võrdleb 2017. aastal tehtud tellimuste müüdud koguseid ja müügisummasid. 
# Värvi täpid kliendisegmendi järgi.
  
df %>%
  filter(year(Kuu_aasta) == ...) %>%
  ggplot(aes(..., ..., color = ...)) +
  geom_point()


### 5.3 Tulpdiagramm

# Tellimuste arv segmentide kaupa (ridade loendamine)
df %>%
  ggplot(aes(Segment)) +
  geom_bar()

# Müük segmendite kaupa (segment ja müük)
df %>%
  ggplot(aes(Segment, Müük)) +
  geom_col()

# Kvalitatiivne värvipalett
# Kogumüük segmentide kaupa
df %>%
  ggplot(aes(Segment, Müük, fill = Segment)) +
  geom_col()

# Kvantitatiivne värvipalett
# 2017.a müük kuude kaupa
tellimused %>%
  filter(year(Kuu_aasta) == 2017) %>%
  group_by(Kuu_aasta) %>%
  summarise(Müük = sum(Müük), .groups = 'drop') %>%
  ggplot(aes(Kuu_aasta, Müük, fill = Müük)) +
  geom_col()


#### 5.3.2 Tulpade positsioon

# 2017.a müük kuude kaupa, värvi segmendite järgi
tellimused %>%
  filter(year(Kuu_aasta) == 2017) %>%
  ggplot(aes(Kuu_aasta, Müük, fill = Segment)) +
  geom_col()

# 2017.a müük kuude kaupa, värvi segmendite järgi
tellimused %>%
  filter(year(Kuu_aasta) == 2017) %>%
  ggplot(aes(Kuu_aasta, Müük, fill = Segment)) +
  geom_col(position = 'dodge')

# 2017.a müük kuude kaupa, värvi segmendite järgi
tellimused %>%
  filter(year(Kuu_aasta) == 2017) %>%
  ggplot(aes(Kuu_aasta, Müük, fill = Segment)) +
  geom_col(position = 'fill')


#### Ülesanne

# Loo tulpdiagramm, mis võrdleb kasumit aastate ja kliendisegmentide lõikes.
  
tellimused %>%
  group_by(..., ...) %>%
  summarise(Kasum = sum(...), .groups = 'drop') %>%
  ggplot(aes(..., ..., fill = ...)) +
  geom_col(position = ...)


### 5.4 Joondiagramm

# Ühe joonega
# Tellimuste arv kuude ja aastate kaupa
tellimused %>%
  group_by(Kuu_aasta) %>%
  summarise(Tellimuste_arv = sum(Tellimuste_arv), .groups = 'drop') %>%
  ggplot(aes(Kuu_aasta, Tellimuste_arv)) +
  geom_line()

# Kahe joonega
# Tellimuste arv kuude ja aastate kaupa, üks joon segmendi kohta
tellimused %>%
  ggplot(aes(Kuu_aasta, Tellimuste_arv, color = Segment)) +
  geom_line()


#### 5.4.1 Joondiagrammi kujundamine

# Värvi joon oranžiks ja tee paksemaks
tellimused %>%
  group_by(Kuu_aasta) %>%
  summarise(Tellimuste_arv = sum(Tellimuste_arv), .groups = 'drop') %>%
  ggplot(aes(Kuu_aasta, Tellimuste_arv)) +
  geom_line(color = 'darkorange', size = 1)


#### Ülesanne

# Loo joondiagramm, mis võrdleb 2017.a tellimuste arvu kuude ja segmentide lõikes.
  
tellimused %>%
  filter(year(Kuu_aasta) == ...) %>%
  ggplot(aes(..., ..., color = ...)) +
  geom_line()


### 5.5 Jooniste kujundamise lisavõimalused

#### 5.1.1 Telje väärtused


# Kuupäevade detailsus x-teljel**
 
# Näita x-teljel kõiki kuid
# Joondiagramm
tellimused %>%
  filter(year(Kuu_aasta) == 2017) %>%
  ggplot(aes(Kuu_aasta, Tellimuste_arv, color = Segment)) +
  geom_line() +
  # Näita x-telje väärtuseid kuu kaupa
  scale_x_date(
    date_breaks = "1 month",
    date_labels = "%b"
  )

# y-telje väärtused tuhandetes, miljonites, protsentides

# Installige pakett scales
# install.packages('scales')
# Laadige töölauale
library(scales)

# Näita x-telje kõiki kuid ja y-telge tuhandetes
# Tulpdiagramm
tellimused %>%
  filter(year(Kuu_aasta) == 2017) %>%
  group_by(Kuu_aasta) %>%
  summarise(Müük = sum(Müük), .groups = 'drop') %>%
  ggplot(aes(Kuu_aasta, Müük, fill = Müük)) +
  geom_col() +
  # Näita x-telje väärtuseid kuu kaupa
  scale_x_date(
    date_breaks = "1 month",
    date_labels = "%b"
  ) +
  # näita y-telje väärtuseid tuhandetes
  scale_y_continuous(
    labels = label_number(scale = 1/1000, suffix = "K")
  )

# 2017.a müük kuude kaupa, värvi segmendite järgi
# Näita y-telge protsentides
tellimused %>%
  filter(year(Kuu_aasta) == 2017) %>%
  ggplot(aes(Kuu_aasta, Müük, fill = Segment)) +
  geom_col(position = 'fill') +
  scale_y_continuous(labels = scales::percent)


#### 5.5.2 Sildid

# Tellimuste arv kuude ja aastate lõikes, üks joon segmendi kohta
# Joondiagramm
tellimused %>%
  filter(year(Kuu_aasta) == 2017) %>%
  ggplot(aes(Kuu_aasta, Tellimuste_arv, color = Segment)) +
  geom_line() +
  scale_x_date(
    date_breaks = "1 month",
    date_labels = "%b"
  ) +
  # Siltide lisamine/muutmine
  labs(title = 'Tellimuste arv kliendisegmentide lõikes',
       subtitle = '2017', 
       color = '',
       x = '', 
       y = '') 

# Tulpdiagramm
tellimused %>%
  filter(year(Kuu_aasta) == 2017) %>%
  group_by(Kuu_aasta) %>%
  summarise(Müük = sum(Müük), .groups = 'drop') %>%
  ggplot(aes(Kuu_aasta, Müük, fill = Müük)) +
  geom_col() +
  # Näita x-telje väärtuseid kuu kaupa
  scale_x_date(
    date_breaks = "1 month",
    date_labels = "%b"
  ) +
  # näita y-telje väärtuseid tuhandetes
  scale_y_continuous(
    labels = label_number(scale = 1/1000, suffix = "K")
  ) +
  # Siltide lisamine/muutmine 
  labs(title = 'Müük kuude lõikes',
       subtitle = '2017', 
       fill = '',
       x = '', 
       y = '') 


#### 5.5.3 Legendid

# Joondiagramm
tellimused %>%
  filter(year(Kuu_aasta) == 2017) %>%
  ggplot(aes(Kuu_aasta, Tellimuste_arv, color = Segment)) +
  geom_line() +
  scale_x_date(
    date_breaks = "1 month",
    date_labels = "%b"
  ) +
  # Siltide lisamine/muutmine 
  labs(title = 'Tellimuste arv kliendisegmentide lõikes',
       subtitle = '2017', 
       color = '',
       x = '', 
       y = '') +
  # Pane legend graafiku ülaossa
  theme(legend.position = 'top')

# Tulpdiagramm
tellimused %>%
  filter(year(Kuu_aasta) == 2017) %>%
  group_by(Kuu_aasta) %>%
  summarise(Müük = sum(Müük), .groups = 'drop') %>%
  ggplot(aes(Kuu_aasta, Müük, fill = Müük)) +
  # Peida legend tulpdiagrammi geomi sees
  geom_col(show.legend = FALSE) +
  # Näita x-telje väärtuseid kuu kaupa
  scale_x_date(
    date_breaks = "1 month",
    date_labels = "%b"
  ) +
  # näita y-telje väärtuseid tuhandetes
  scale_y_continuous(
    labels = label_number(scale = 1/1000, suffix = "K")
  ) +
  # Siltide lisamine/muutmine 
  labs(title = 'Müük kuude lõikes',
       subtitle = '2017', 
       fill = '',
       x = '', 
       y = '') 


#### 5.5.4 Värvipaletid

#install.packages(RColorBrewer) 
library(RColorBrewer) 
display.brewer.all() # näita pakette

# Joondiagramm
tellimused %>%
  filter(year(Kuu_aasta) == 2017) %>%
  ggplot(aes(Kuu_aasta, Tellimuste_arv, color = Segment)) +
  geom_line() +
  scale_x_date(
    date_breaks = "1 month",
    date_labels = "%b"
  ) +
  # Siltide lisamine/muutmine 
  labs(title = 'Tellimuste arv kliendisegmentide lõikes',
       subtitle = '2017', 
       color = '',
       x = '', 
       y = '') +
  # Pane legend graafiku ülaossa
  theme(legend.position = 'top') +
  # Värvipaleti muutmine 
  scale_color_brewer(palette = 'Dark2')

# Tulpdiagramm
tellimused %>%
  filter(year(Kuu_aasta) == 2017) %>%
  group_by(Kuu_aasta) %>%
  summarise(Müük = sum(Müük), .groups = 'drop') %>%
  ggplot(aes(Kuu_aasta, Müük, fill = Müük)) +
  # Peida legend tulpdiagrammi geomi sees
  geom_col(show.legend = FALSE) +
  # Näita x-telje väärtuseid kuu kaupa
  scale_x_date(
    date_breaks = "1 month",
    date_labels = "%b"
  ) +
  # näita y-telje väärtuseid tuhandetes
  scale_y_continuous(
    labels = label_number(scale = 1/1000, suffix = "K")
  ) +
  # Siltide lisamine/muutmine 
  labs(title = 'Müük kuude lõikes',
       subtitle = '2017', 
       fill = '',
       x = '', 
       y = '') + 
  # Värvipaleti muutmine 
  scale_fill_distiller(palette = 'Oranges', direction = 1)


#### 5.5.5 Kujundustemaatikad

# Tulpdiagramm
tellimused %>%
  filter(year(Kuu_aasta) == 2017) %>%
  group_by(Kuu_aasta) %>%
  summarise(Müük = sum(Müük), .groups = 'drop') %>%
  ggplot(aes(Kuu_aasta, Müük, fill = Müük)) +
  geom_col(show.legend = FALSE) +
  # Näita x-telje väärtuseid kuu kaupa
  scale_x_date(
    date_breaks = "1 month",
    date_labels = "%b"
  ) +
  # näita y-telje väärtuseid tuhandetes
  scale_y_continuous(
    labels = label_number(scale = 1/1000, suffix = "K")
  ) +
  # Sildid 
  labs(title = 'Müük kuude lõikes',
       subtitle = '2017', 
       fill = '',
       x = '', 
       y = '') + 
  # Värvipalett
  scale_fill_distiller(palette = 'Oranges', direction = 1) + 
  # Kujundustemaatika lisamine 
  theme_minimal()


# 6. TULEMUSTE SALVESTAMINE EXCELI FAILI

# Avage uus skript ning kopeerige sinna järgnev kood:

library(tidyverse)
library(readxl)
#install.packages('openxlsx') 
library(openxlsx) 

superstore_df <- read_excel("Superstore_clean.xlsx")

# müügi kokkuvõte kuu ja kliendisegmendi lõikes
müük <- superstore_df %>%
  group_by(Kuu = floor_date(date(Order_Date), 'month'),
           Segment) %>%
  summarise(Tellimuste_arv = n_distinct(Order_ID),
            Müük = sum(Sales),
            Keskmine_müügisumma = round(Müük / Tellimuste_arv), .groups = 'drop')

# top kliendid müügi järgi kuu ja kliendisegmendi lõikes
top_kliendid <- superstore_df %>%
  group_by(Kuu = floor_date(date(Order_Date), 'month'),
           Segment,
           Customer_Name) %>%
  summarise(Müük = sum(Sales), .groups = 'drop') %>%
  group_by(Kuu, Segment) %>%
  arrange(desc(Müük)) %>%
  summarise(Top_klient = first(Customer_Name), .groups = 'drop')

müük %>%
  left_join(top_kliendid, by = c('Kuu', 'Segment')) %>%
  write.xlsx('kuu_müük.xlsx', overwrite = TRUE) 

# Salvestage see skript endale meelepärase nimega.
# Nüüd on teil olemas skript, mis teeb ühe klikiga kõik ise ära!
  

# 7. PRAKTILINE ISESEISEV TÖÖ
  
# 1.  Valige üks kahest andmestikust (gapminder või Superstore_clean) ja sõnastage kaks uurimisküsimust, millele soovite vastust leida.
# 2.  Üks lahendus esitage kokkuvõtliku tabeli (või väärtuse) kujul ning teine lahendus esitage joonisena.
