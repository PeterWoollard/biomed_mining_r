library(tidyverse)

#make it all tidy ie. varaibles are columns, observations rows and values in cells.
#ypical provlems:
# one variable might be spread across multiple columns
# one observations miight be scattered across multple rows


# all source from https://github.com/hadley/r4ds



#GATHERING problem hwere some column names are values of a varaible # makes the table narrower and longer
table4a <- read_csv("country,1999,2000
Afghanistan,745,266
Brazil,37737,804888
China,212258,213766")

tidy4a <-  table4a %>%
  gather("1999","2000",key = "year", value = "cases")

#population
table4b <- read_csv("country,1999,2000
Afghanistan,19987071,20595360
Brazil,172006362,174504898
China,1272915272,1280428583")

tidy4b <- table4b %>%
  gather("1999","2000",key = "year", value = "population")
left_join(tidy4a,tidy4b)


#SPREADING problem where an observation is scattered across muliple rows  # makes the table wider
table2 <- read_csv("country,year,type,count
Afghanistan,1999,cases,745
Afghanistan,1999,population,19987071
Afghanistan,2000,cases,72666
Afghanistan,2000,population,20595360
Brazil,1999,cases,37737
Brazil,1999,population,174504898")
pread(table2,key = type, value =count)


stocks <- tibble(
  year = c(2015,2015,2016,2016),
  half = c(1,2,1,2),
  return = c(1.88,0.59,0.92,0.17)
)

spread1 <- stocks %>% spread(year,return)
spread1 %>% gather("year", "return", `2015`:`2016`)



table3 <- read_csv("country,year,rate
Afghanistan,1999,745/19987071
Afghanistan,2000,2666/20595360")
table3 %>% separate(rate, into = c("cases","population"), sep = "/")
#amnd to force a change on col types
table3 %>% separate(rate, into = c("cases","population"), sep = "/",convert = TRUE)
#separate at positio=2
table3b <- table3 %>% separate(year, into = c("century","year"), sep = 2,convert = TRUE)

#combine two columns into
unite(year,century,year,sep ='')


#Extract a character column into multiple columns using regular expression groups
#complete()  - takes a set of columns and finad all unique combination and puts in NA for missing
#fill()   takea set of coumns and fills in the missing values from the most recent non-missing values

who1 %>% count(spkey)

#TB WHo
#https://www.who.int/teams/global-tuberculosis-programme/data#csv_files
tidyr::who
who1 <- who %>% 
  gather(
    new_sp_m014:newrel_f65, key = 'spkey', 
    value = "cases",
    na.rm = TRUE
  )

#get counts of observations for all the keys
who1 %>% count(spkey)

#fix some columnna names 
who2 <- who1 %>% 
  mutate(spkey = stringr::str_replace(spkey,"newrel","new_rel"))

who2 %>% 
  separate(spkey,c("new","type","sexage"),sep="_")
#lets driope 3 redundant coluimns
who2 %>% 
  +   separate(spkey,c("new","type","sexage"),sep="_") %>% select(-new,-iso2,-iso3)
#split seq and age
who5 <- who2 %>% separate(spkey,c("new","type","sexage"),sep="_") %>% select(-new,-iso2,-iso3) %>% separate(sexage,c("sex","age"),sep = 1)
#N.B. normal to do as I did abnd build up complex pipe 

group_by(country,year,sex) %>% summarise(total_cases= sum(cases))
gplot(data = who5summary) + geom_point(mapping = aes(x = country, y = total_cases))
ggplot(data = who5summary) + geom_point(mapping = aes(x = country, y = total_cases))




