# R ALGAJATE KOOLITUSPÄEVA TÖÖLEHT

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
  
now()

today()

Sys.timezone()

# Objektide loomine: `objekt <- väärtus

nimi <- 'Mari'
mida_teeb <- 'töötab'
kus <- 'Tallinnas'
paste(nimi, mida_teeb, kus, sep = ' ') # kleebime need omavahel kokku

miks <- 'see on huvitav'
paste('Õpin R-i, sest', miks, sep = ' ') # kleebime need omavahel kokku


# MIS ON TIDYVERSE?

install.packages('tidyverse') # installi Tidyverse paketid 
library(tidyverse) # lae Tidyverse tuumikpaketid töökeskkonda
library(lubridate) # lae lubridate


# ANDMETE IMPORTIMINE JA ESMANE ANALÜÜS

library(readxl)
Superstore_clean <- read_excel("Superstore_clean.xlsx")
View(Superstore_clean)                                                           

df <- Superstore_clean # loome uue nimega andmestiku df


# ANDMETEGA TUTVUMINE

## Põhilised funktsioonid

View(df) # ava andmestik vahelehel

head(df) # esimesed 6 rida
tail(df) # viimased 6 rida

head(df, 3) # esimesed 3 rida

names(df) # veergude pealkirjad

str(df) # struktuuri kirjeldus

summary(df) # statistiline kokkuvõte

glimpse(df) # glimpse() - mugav ülevaade
 
df$State # kõik selle veeru väärtused
head(df$State, 10) # selle veeru esimesed 10 rida
 
unique(df$State) # unique() - vektori unikaalsed väärtused 

## Ülesanne 
# Leidke veergude `Country`, `Segment`, `Category` & `Sub_Category` unikaalsed väärtused.
  
unique(df$...)


## Summaarsed funktsioonid

# min() - miinimumväärtus 
min(df$Sales) 

# max() - maksimumväärtus 
max(df$Sales) 

# sum() - liida kokku 
sum(df$Sales) 

# mean() - aritmeetiline keskmine 
mean(df$Sales) 

# median() - mediaanväärtus 
median(df$Sales) 

# sd() - standardhälve 
sd(df$Sales) 

# round() - ümardamine
round(mean(df$Sales))

## Ülesanne 2
# Leidke need väärtused veerule `Quantity`.
  
...(df$Quantity)


## Toru

# Toruta
round(mean(df$Sales))

# Toruga
df$Sales %>%
  mean() %>%
  round()

## Ülesanne 3

df$... %>%
  sum() %>%
  round()


## Andmetüübid ja -struktuurid

# Loome vektorid
kuupäev <- c("24.02.1918", "24.10.1870", "17.02.2006", "23.04.1343", "02.02.1920", "14.09.1524", "20.08.1991", "25.06.1775") 
sündmus <- c("Iseseisvumine", "Esimese raudteeliini avamine", "KUMU avamine", "Jüriöö ülestõus", "Tartu rahu", "Tallinna kirikute rüüstamine", "Taasiseseisvumine", "Tartu suurpõleng") 
 
# Loome andmeraami vektoritest
ee_sündmused <- tibble(kuupäev, sündmus) # loome vektoritest tibble andmeraami
ee_sündmused


# dplyri verbid

### select()

# valime ühe veeru 
df %>% 
  select(Order_Date) 

# valime mitu veergu
df %>% 
  select(Order_Date, Order_ID, Customer_Name, Segment, Category, Product_Name, Sales)

# valime veerud Order_ID kuni Customer_ID
df %>% 
  select(Order_ID:Customer_ID) 

# valime veerud Order_Date, Order_ID, Customer_Name, Segment, Category, Sub_Category, Product_Name, Sales, Quantity
# loome selle põhjal uue andmestiku df1
df1 <- df %>% 
  select(Order_Date, Order_ID, Customer_Name, Segment, Category, Sub_Category, Product_Name, Sales, Quantity)
df1
 
df %>%
  select(starts_with('Product'))

df %>%
  select(ends_with('ID'))

df %>%
  select(contains('g'))

# valime kõik veerud v.a. Segment 
df %>% 
  select(-Segment)

# valime kõik veerud v.a. Row_ID & Ship_Date
df %>%
  select(-c(Row_ID, Ship_Date))

# valime kõik veerud v.a. Row_ID, Ship_Mode, Country, City, Postal_Code, Region, Customer_ID, Product_ID
# loome selle põhjal uue andmestiku df1
df2 <- df %>% 
  select(-c(Row_ID, Ship_Mode, Country, City, Postal_Code, Region, Customer_ID, Product_ID))
df2

### Ülesanne 
# Looge 3 uut andmestikku järgnevate veergudega:

# kliendid: kliendi ID, nimi, segment, osariik, linn, postiindeks, regioon

kliendid <- df %>%
  select(...) %>%
  distinct() 

# kliendid2: jätke andmestikust kliendid välja veerud postiindeks & regioon

kliendid2 <- kliendid %>%
  select(...)

# tooted: toote ID, kategooria, alamkategooria, nimi

tooted <- df %>%
  select(...) %>%
  distinct()


### filter()

#### Loogilised operaatorid I

# siin töötame edasi uue vähendatud andmestikuga df1

# valime kõik read, kus ostetud esemete kogus on vähemalt 10
df1 %>%
  filter(Quantity >= 10)

# valime kõik read, kus ostumma on alla 5.4
df1 %>%
  filter(Sales < 5.4)

# valime kõik read, kus klient on Claire Gute
df1 %>% 
  filter(Customer_Name == 'Claire Gute') 

# Leiame tooted, mida on ühe tellimusega ostetud vähemalt 10 tükki:

df1 %>%
  select(Product_Name, Quantity) %>%
  filter(Quantity >= 10) 

# Leiame kodukontori kliendid, kes on ostnud koopiamasinaid:

df1 %>%
  select(Customer_Name, Segment, Sub_Category) %>%
  filter(Segment == 'Home Office',
         Sub_Category == 'Copiers')

### Ülesanne 5
# Millised tellimused sisaldavad toodet "Surelock Post Binders"?

df1 %>%
  select(...) %>%
  filter(... == ...)

# Millised kliendid on ostnud mööblit ühe tellimusega vähemalt 4000 dollari eest?

df1 %>%
  select(...) %>%
  filter(... == ...,
         ... >= ...) 


#### Loogilised operaatorid II

# valime kõik read, kus segment on kodukontor (Home Office) ja alamkategooria on kunst (Art)
df1 %>%
  filter(Segment == 'Home Office',
         Sub_Category == 'Art')

# valime kõik read, kus kategooria on tehnoloogia (Technology) ja kogus on vähemalt 10
df1 %>%
  filter(Category == 'Technology' &
         Quantity >= 10)

# ostusumma on üle 1000 või segment on äriklient
df1 %>% 
  filter(Sales > 1000 | Segment == 'Corporate')

# kategooria on tehnoloogia, aga ilma telefonide alamkategooriata
df1 %>% 
  filter(Category == 'Technology', # valime selle
         Sub_Category != 'Phones') # aga mitte selle

# ostusumma ei ole üle 10
df1 %>% 
  filter(!Sales > 10)

# alamkategooriad toolid, kunst & koopiamasinad
df1 %>%
  filter(Sub_Category %in% c('Chairs', 'Art', 'Copiers')) # alamkategooria kuulub hulka 'Chairs', 'Art', 'Copiers'

# mitte need alamkategooriad
df1 %>%
  filter(!Sub_Category %in% c('Chairs', 'Art', 'Copiers')) # alamkategooria ei kuulu hulka 'Chairs', 'Art', 'Copiers'

### Ülesanne 6
# Millised kliendid on ostnud tooteid alamkategooriatest Labels või Furnishings?

df %>%
  select(... = ) %>%
  filter(... %in% c(...))

# Milliseid tooteid on korraga ostetud üle 10 ühiku või vähemalt 2000 dollari eest?

df1 %>%
  select(...) %>%
  filter(... | ...0)

# Milliseid raamaturiiuleid (Bookcases) on ostnud tavakliendid (Consumer) ühe tellimusega vähemalt 2000 dollari eest?

df1 %>%
  filter(... == ...,
         ... == ...,
         ... >= ...) %>%
  select(...)


### mutate()

# Loome uue veeru
df1 %>% 
  select(Order_ID, Product_Name, Sales, Quantity) %>%
  mutate(tyki_hind = Sales / Quantity) # ühe tüki hind

# Muudame olemasoleva veeru väärtust
df1 %>%
  select(Order_ID, Product_Name, Sales, Quantity) %>%
  mutate(Sales = round(Sales))

# Lisame veeru tellimuse kogusummaga ja müüdud ühikute arvuga
df1 %>%
  group_by(Order_ID) %>%
  mutate(Tellimuse_summa = sum(Sales),
         Myydud_yhikud = sum(Quantity)) %>%
  ungroup()

### Ülesanne 7
# Muutke veergu Sales, et summad oleksid ümardatud täisarvuni.

df1 %>%
  mutate(... = round(...))

# Leidke tehnoloogiatooted, mille ühe tüki hind on üle 1000 dollari.

df1 %>%
  mutate(... = ...) %>%
  filter(... == ...,
         ... > ...) %>%
  select(...) %>%
  distinct()


### arrange()

# Tõusvas järjekorras - arvulised väärtused
df %>% 
  select(Product_Name, Quantity, Sales) %>%
  arrange(Sales)

# Langevas järjekorras - arvulised väärtused
df %>% 
  select(Product_Name, Quantity, Sales) %>%
  arrange(desc(Sales))
 
# Tõusvas järjekorras - tekstilised väärtused
df %>% 
  select(Sub_Category) %>%
  distinct() %>%
  arrange(Sub_Category)

# Langevas järjekorras - tekstilised väärtused
df %>% 
  select(Sub_Category) %>%
  distinct() %>%
  arrange(desc(Sub_Category))
 
# Mida see kood teeb?
df %>% 
  select(Category, Sub_Category) %>%
  distinct() %>%
  group_by(Category) %>%
  arrange(Category, Sub_Category) %>%
  ungroup()

### Ülesanne 8
# Reastage tellimused kliendi järgi tähestikulises järjekorras.

df1 %>%
  select(...) %>%
  distinct() %>%
  arrange(...)

# Leidke 10 seadet (Appliances), mida on ühe tellimusega kõige enam müüdud.

df1 %>%
  filter(... == ...) %>%
  select(...) %>%
  arrange(desc(...)) %>%
  head(10)


### summarize()

# Unikaalsete klientide arv
df1 %>%
  summarize(n_distinct(Customer_Name))

# Unikaalsete tellimuste arv
df1 %>%
  summarize(n_distinct(Order_ID))

# Ostude kogusumma
df1 %>%
  summarize(sum(Sales))

# Kõige suurem ostusumma
df1 %>%
  summarise(max(Sales))
 
# koos group_by() funktsiooniga 

# Mitu korda on igat toodet müüdud?
df1 %>%
  group_by(Product_Name) %>%
  summarise(sum(Quantity))

# Leidke tellimuste arv alamkategooriate kaupa
df1 %>%
  group_by(Sub_Category) %>%
  summarise(Tellimuste_arv = n_distinct(Order_ID))

# Tellimuste arv, kogusumma, müüdud ühikute arv ja keskmine tellimuse summa segmentide kaupa
df1 %>%
  group_by(Segment) %>%
  summarise(Tellimuste_arv = n_distinct(Order_ID),
            Tellimuste_summa = sum(Sales),
            Myydud_yhikud = sum(Quantity),
            Keskmine_tellimus = Tellimuste_summa / Tellimuste_arv)

### Ülesanne 9
# Milline on kõige suurema ostusummaga toode?

df1 %>%
  select(...) %>%
  filter(... == max(...))

# Leidke unikaalsete toodete arv kategooriate ja alamkategooriate kaupa.

df1 %>%
  group_by(...) %>%
  summarise(... = n_distinct(...))

# Leidke kõikide tootekategooriate täielik müügisumma ja müüdud ühikute arv. Järjestage tulemused summa järgi suuremast väiksemani.

df1 %>%
  group_by(...) %>%
  summarise(... = sum(...),
            ... = sum(...)) %>%
  arrange(desc(...))

# Millised ärikliendid on esitanud vähemalt 10 tellimust?

df1 %>%
  filter(... == ...) %>%
  group_by(... = ) %>%
  summarise(... = n_distinct(...)) %>%
  filter(... >= ...)


# lubridate

# Kuupäev ja kellaaeg
today() # praegune kuupäev 
now() # praegune kuupäev ja kellaaeg 
    
# R tunneb kuupäevad ära:
ymd(20180308) 
ydm('2021/03/june') 
mdy('Sep 20, 2021')

ee_sündmused

ee_sündmused1 <- ee_sündmused %>% 
  mutate(uus_kuupäev = dmy(kuupäev))

ee_sündmused1

## Ajaliste komponentide eraldamine
              
# Praegune aasta 
year(now()) 
              
# Lisame veeru sündmuse aastaga
ee_sündmused1 %>%
  mutate(Aasta = year(uus_kuupäev))

# Praegune kvartal 
quarter(now()) 
              
# Lisame veeru sündmuse aastaga
ee_sündmused1 %>%
mutate(Kvartal = quarter(uus_kuupäev))

# Kuu 
month(now()) 
month(now(), label = TRUE, abbr = TRUE) 
              
# Lisame veeru sündmuse kuuga
ee_sündmused1 %>%mutate(Kuu = month(uus_kuupäev, label = TRUE, abbr = FALSE))

# Nädal 
week(now()) 
              
# Lisame veeru sündmuse nädalaga
ee_sündmused1 %>%
  mutate(Nädal = week(uus_kuupäev))

# Nädalapäev 
wday(now()) 
wday(now(), label = TRUE, abbr = FALSE) 
              
# Lisame veeru sündmuse nädalapäevaga
ee_sündmused1 %>%
  mutate(Nädalapäev = wday(uus_kuupäev, label = TRUE, abbr = TRUE))

# Kuupäeva komponendi eraldamine
date(now()) # annab sama tulemuse mis today()

tellimused <- df %>%
  select(Order_ID, Order_Date, Ship_Date, Segment, Category, Sub_Category, Product_ID, Sales, Quantity, Profit, Discount) 
              
tellimused

tellimused1 <- tellimused %>%
  mutate(Tellimuse_kuupäev = date(Order_Date),
         Tarne_kuupäev = date(Ship_Date),
         Aasta = year(Order_Date),
         Kuu = month(Order_Date, label = TRUE)) %>%
  select(-c(Order_Date, Ship_Date))
              
tellimused1

## Ülesanne 10
# Kasutades andmestikku `tellimused`:
# Leidke 2016. aasta müügi kogusummad kuude lõikes.

tellimused %>%
  mutate(Aasta = ...,
         Kuu = ... = ) %>%
  filter(... == ...) %>%
  group_by(...) %>%
  summarise(... = sum(...))

# Leidke kõigi aastate müügi kogusummad tootekategooriate kaupa.
                
tellimused %>%
  mutate(... = ...) %>%
  group_by(..., ...) %>%
  summarise(... = sum(...))

## Kuupäevade ümardamine
              
# Ümarda nädala esimese päevani
round_date(today(), 'week', week_start = 1)
              
# Ümarda lähima eelneva esmaspäevani - nädala esimene päev
floor_date(today(), 'week', week_start = 1)
              
# Ümarda lähima järgneva esmaspäevani
ceiling_date(today(), 'week', week_start = 1)

## Ülesanne 11
# Ümardage praegune kellaaeg lähima täistunnini**

... %>%
  round_date(...)

# Ümardage praegune kuupäev järgmise lähima kuuni.**
                
... %>%
  ceiling_date(...)
              

## Kahe kuupäeva vahelise aja arvutamine
              
# Kui kaua kulus tellimuse esitamisest tellimuse väljastamiseni?
tellimused2 <- tellimused1 %>%
  mutate(Tarne_aeg = Tarne_kuupäev - Tellimuse_kuupäev, # kahe kuupäeva vaheline aeg sõnades
         Tarne_aeg_päevades = as.integer(Tarne_kuupäev - Tellimuse_kuupäev), # päevade arv
         Tarne_aeg_nädalates = as.integer(difftime(Tarne_kuupäev, Tellimuse_kuupäev, unit="weeks"))) # nädalate arv

tellimused2

## Ülesanne 12
# Kasutades andmestikku `tellimused`: Leidke tellimused, mille täitmiseni kulus 7 või rohkem päeva.**

tellimused %>%
  mutate(Aeg_tellimuse_täitmiseni = ...) %>%
  filter(... >= ...)

# ANDMETE VISUALISEERIMINE (ggplot2)

# Lihtne hajuvusdiagramm
ggplot(tellimused1, aes(x = Sales, y = Profit)) + 
  geom_point() 

# Tooted, mis tõid kasumit
tellimused1 %>% 
  filter(Profit > 0) %>%
  ggplot(aes(Profit, Sales)) + 
  geom_point()

### Hajuvusdiagrammi kujundamine

# Värvi täpid tootekategooria järgi
tellimused1 %>% 
  filter(Profit > 0) %>%
  ggplot(aes(Profit, Sales, color = Category)) + 
  geom_point()

# Värvi täpid müügisumma järgi
tellimused1 %>% 
  filter(Profit > 0) %>%
  ggplot(aes(Profit, Sales, color = Sales)) + 
  geom_point()

# Värvi kõik täpid punaseks
tellimused1 %>% 
  filter(Profit > 0) %>%
  ggplot(aes(Profit, Sales)) + 
  geom_point(color = 'red')

### Ülesanne 13
# Loo hajuvusdiagramm, mis võrdleb müügisummat ja kasumit ning värvi täpid nädalapäeva järgi.
  
tellimused1 %>% 
  ggplot(aes(..., ..., color = ...)) + 
  ...()



## Tulpdiagramm

# Müüdud tooteartiklid kategooriate kaupa
tellimused1 %>% 
  ggplot(aes(Category)) + 
  geom_bar() 

# Müüdud tooteühikute arv tootekategooriate kaupa
tellimused1 %>% 
  ggplot(aes(Category, Quantity)) + 
  geom_col()

### Tulpdiagrammi kujundamine

# Müüdud toodete arv tootekategooriate kaupa
# Värv tootekategooria järgi
tellimused1 %>% 
  ggplot(aes(Category, Quantity, fill = Category)) + 
  geom_col()

# Müüdud toodete arv aastate kaupa
# Värv tootekategooria järgi
tellimused1 %>% 
  ggplot(aes(Aasta, Quantity, fill = Category)) + 
  geom_col()

# Müüdud toodete arv kategooriate kaupa
# Värv aasta järgi - aasta esitame faktorina!
tellimused1 %>% 
  ggplot(aes(Category, Quantity, fill = as.factor(Aasta))) + 
  geom_col()

#### Tulpade positsioon

# Müüdud toodete arv aastate kaupa
# Värv tootekategooria järgi
tellimused1 %>% 
  group_by(Aasta, Category) %>%
  summarise(Quantity = sum(Quantity)) %>%
  ggplot(aes(Aasta, Quantity, fill = Category)) + 
  geom_col() # vaikimisi: position = 'stack'
 
# Müüdud toodete arv aastate kaupa
# Värv tootekategooria järgi
tellimused1 %>% 
  group_by(Aasta, Category) %>%
  summarise(Quantity = sum(Quantity)) %>%
  ggplot(aes(Aasta, Quantity, fill = Category)) + 
  geom_col(position = 'dodge') # grupid üksteise kõrvale
 
# Müüdud toodete arv aastate kaupa
# Värv tootekategooria järgi
tellimused1 %>% 
  group_by(Aasta, Category) %>%
  summarise(Quantity = sum(Quantity)) %>%
  ggplot(aes(Aasta, Quantity, fill = Category)) + 
  geom_col(position = 'fill') # protsendiline jaotus

#### Telgede ümberpööramine

# x ja y teljed vahetavad kohad
tellimused1 %>% 
  ggplot(aes(Sub_Category, Quantity, fill = Category)) + 
  geom_col() +
  coord_flip()

#### Väärtuste järjestamine

# alamkategooriad müüdud ühikute järgi suuremast väiksemani - kvantitatiivne värviskaala
tellimused1 %>% 
  group_by(Category, Sub_Category) %>%
  summarise(Quantity = sum(Quantity)) %>%
  ggplot(aes(fct_reorder(Sub_Category, Quantity, .fun = sum, .desc = FALSE), Quantity, fill = Quantity)) + 
  geom_col() +
  coord_flip()

# alamkategooriad müüdud ühikute järgi suuremast väiksemani - kvalitatiivne värviskaala
tellimused1 %>% 
  group_by(Category, Sub_Category) %>%
  summarise(Quantity = sum(Quantity)) %>%
  ggplot(aes(fct_reorder(Sub_Category, Quantity, .fun = sum, .desc = FALSE), Quantity, fill = Category)) + 
  geom_col() +
  coord_flip()

#### Ülesanne 14
# Loo tulpdiagramm, mis võrdleb 2015.a müügitulemusi kuude ja tootekategooriate kaupa.
  
tellimused1 %>% 
  filter(... == ...) %>%
  ggplot(aes(..., ..., fill = ...)) + 
  geom_col(position = ...)


## Joondiagramm

# Loome uue andmestiku tellimused3: tellimuste arv kuude ja segmendi kaupa
tellimused3 <- df %>%
  group_by(Kuu = date(floor_date(Order_Date, 'month', week_start = 1)),
           Segment) %>%
  summarise(Tellimuste_arv = n_distinct(Order_ID),
            Klientide_arv = n_distinct(Customer_Name),
            Myyk = sum(Sales),
            Kasum = sum(Profit),
            Soodustused = sum(Discount))

tellimused3
 
# Ühe joonega: tellimuste arv kuude kaupa
tellimused3 %>%
  group_by(Kuu) %>%
  summarise(Tellimuste_arv = sum(Tellimuste_arv)) %>% 
  ggplot(aes(Kuu, Tellimuste_arv)) +
  geom_line() +
  geom_smooth() # trendijoone lisamine
 
# Mitme joonega: tellimuste arv kuude kaupa segmentide lõikes
tellimused3 %>%
  ggplot(aes(Kuu, Tellimuste_arv, group = Segment)) +
  geom_line()

### Joondiagrammi kujundamine
 
# roheline joon
tellimused3 %>%
  filter(Kuu >= '2017-01-01') %>%
  group_by(Kuu) %>%
  summarise(Tellimuste_arv = sum(Tellimuste_arv)) %>% 
  ggplot(aes(Kuu, Tellimuste_arv)) +
  geom_line(color = 'green')

# joon segmendi järgi
tellimused3 %>%
  filter(Kuu >= '2017-01-01') %>%
  ggplot(aes(Kuu, Tellimuste_arv, color = Segment)) +
  geom_line()

# joonte värv, tüüp, läbipaistvus ja paksus
tellimused3 %>%
  filter(Kuu >= '2017-01-01') %>%
  ggplot(aes(Kuu, Tellimuste_arv, color = Segment, linetype = Segment)) +
  geom_line(alpha = 0.6, size = 2)


#### Ülesanne 15
# Loo joondiagramm, mis võrdleb 2017.a klientide arvu kuude ja segmentide kaupa.
  
tellimused3 %>%
  filter(... >= ...) %>%
  ggplot(aes(..., ..., ... = ...)) +
  geom_line()


## Lisakihid

### Sildid

# Alamkategooriad müüdud ühikute järgi suuremast väiksemani
tellimused1 %>% 
  group_by(Category, Sub_Category) %>%
  summarise(Quantity = sum(Quantity)) %>%
  ggplot(aes(fct_reorder(Sub_Category, Quantity, .fun = sum, .desc = FALSE), Quantity, fill = Quantity)) + 
  geom_col() +
  coord_flip() +
  # Sildid 
  labs(title = 'Müüdud ühikute arv erinevates tootekategooriates',
       subtitle = '', 
       fill = '',
       x = '', 
       y = '') 

### Legendid

# Müüdud toodete arv tootekategooriate kaupa
# Värv tootekategooria järgi
tellimused1 %>% 
  ggplot(aes(Category, Quantity, fill = Category)) + 
  geom_col() + 
  # Sildid 
  labs(title = 'Müüdud ühikute arv erinevates tootekategooriates',
       subtitle = '', 
       x = '', 
       y = '') +
  # Peida legend 
  theme(legend.position = 'none')
 
# alamkategooriad müüdud ühikute järgi suuremast väiksemani - kvalitatiivne värviskaala
tellimused1 %>% 
  group_by(Category, Sub_Category) %>%
  summarise(Quantity = sum(Quantity)) %>%
  ggplot(aes(fct_reorder(Sub_Category, Quantity, .fun = sum, .desc = FALSE), Quantity, fill = Category)) + 
  geom_col() +
  coord_flip() +
  # Sildid 
  labs(title = 'Müüdud ühikute arv erinevates tootekategooriates',
       subtitle = '', 
       fill = '',
       x = '', 
       y = '') +
  # Legend joonise alla 
  theme(legend.position = 'bottom') 

### Värvipaletid

#install.packages(RColorBrewer) 
library(RColorBrewer) 
display.brewer.all()

# alamkategooriad müüdud ühikute järgi suuremast väiksemani - kvantitatiivne värviskaala
tellimused1 %>% 
  group_by(Category, Sub_Category) %>%
  summarise(Quantity = sum(Quantity)) %>%
  ggplot(aes(fct_reorder(Sub_Category, Quantity, .fun = sum, .desc = FALSE), Quantity, fill = Quantity)) + 
  geom_col() +
  coord_flip() +
  # Sildid 
  labs(title = 'Müüdud ühikute arv erinevates tootekategooriates',
       subtitle = '', 
       fill = '',
       x = ' ', 
       y = ' ') + 
  # Värvipalett
  scale_fill_distiller(palette = 'Oranges', direction = 1)

# alamkategooriad müüdud ühikute järgi suuremast väiksemani - kvalitatiivne värviskaala
tellimused1 %>% 
  group_by(Category, Sub_Category) %>%
  summarise(Quantity = sum(Quantity)) %>%
  ggplot(aes(fct_reorder(Sub_Category, Quantity, .fun = sum, .desc = FALSE), Quantity, fill = Category)) + 
  geom_col() +
  coord_flip() +
  # Sildid 
  labs(title = 'Müüdud ühikute arv erinevates tootekategooriates',
       subtitle = '', 
       fill = '',
       x = '', 
       y = '') + 
  theme(legend.position = 'bottom') +
  # Värvipaleti muutmine 
  scale_fill_brewer(palette = 'Accent')

### Kujundustemaatikad

# alamkategooriad müüdud ühikute järgi suuremast väiksemani - kvalitatiivne värviskaala
tellimused1 %>% 
  group_by(Category, Sub_Category) %>%
  summarise(Quantity = sum(Quantity)) %>%
  ggplot(aes(fct_reorder(Sub_Category, Quantity, .fun = sum, .desc = FALSE), Quantity, fill = Category)) + 
  geom_col() +
  coord_flip() +
  # Sildid 
  labs(title = 'Müüdud ühikute arv erinevates tootekategooriates',
       subtitle = '', 
       fill = '',
       x = '', 
       y = '') + 
  theme(legend.position = 'bottom') +
  # Värvipaleti muutmine 
  scale_fill_brewer(palette = 'Accent') + 
  # Kujundustemaatika lisamine 
  theme_minimal()

### Ülesanne 16
# Valige joonis ülesandest 13, 14 või 15 ja kujundage see oma soovi järgi: värvipalett, sildid, legend, temaatika**
  
... +
  # Värvipalett
  scale_..._brewer(palette = ...) +
  # Sildid 
  labs(title = ...,
       x = ..., 
       y = ...) +
  # Legend
  theme(legend.position = ...) +
  # Temaatika
  theme_...()


# ANDMED RSTUDIOST VÄLJA

## Exceli faili salvestamine

## Ülesanne 17
# Avage uus skript ning kopeerige sinna järgnev kood:

# Lae paketid
library(tidyverse)
library(lubridate)

# Loe andmed sisse
library(readxl)
andmestik <- read_excel("Superstore_clean.xlsx")

# Arvutame müügitulemused iga kuu ja kliendisegm kaupa 
andmestik1 <- andmestik %>%
  mutate(Kuu = date(floor_date(Order_Date, 'month'))) %>%
  group_by(Kuu, Segment) %>%
  summarise(Kogumyyk = sum(Sales), 
            Myydud_yhikud = sum(Quantity),
            Unikaalsed_tooted = n_distinct(Product_ID),
            Tellimuste_arv = n_distinct(Order_ID),
            Tellimuse_keskmine_summa = round(Kogumyyk / Tellimuste_arv, 2))

# Salvesta tulemus exceli faili
#install.packages('openxlsx') 
library(openxlsx) 
write.xlsx(andmestik1, 'andmestik1.xlsx', overwrite = TRUE) 

# Lõpetuseks
hinnang <- '...'
paste('Tänane õppepäev oli', hinnang, sep = ' ')
