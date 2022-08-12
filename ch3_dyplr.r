

library(tidyverse)
library(dplyr)
#install.packages("nycflights13")
library(nycflights13)   # install.packages("nycflights13")
flights <- nycflights13::flights

filter(flights, month ==1, day == 1)
#nov OR dec
filter(flights, month == 1 | month == 12)
filter(flights, month %in% c(1,12))
#flights not delayed on arrival or departure by more than

x <- NA
y <- NA
x == y
#[1] NA
is.na(x)
#[1] TRUE

#use dplyr to get a table fo coounts
flights %>% count(flights$carrier)
filter(flights, carrier == c('DL','US'))
#flights that departed on time but arrived late.
filter(flights,arr_delay > 120 & dep_delay ==0)
colnames(flights)
filter(flights,dep_time >0 & dep_time < 0600 )
filter(flights, between(dep_time, 0, 0600))

#find missing not non-missing values in a column
sum(is.na(flights$dep_time))
#[1] 8255
sum(!is.na(flights$dep_time))
#[1] 328521
#sort so all NA at start
arrange(flights,!is.na(dep_time),dep_time)
select(flights,year, month, day)
rename(flights,tail_num= tailnum)
#geto certain columns are the front
select(flights,time_hour,air_time,everything())
select(flights,contains("TIME"))
flights_sm = select(flights,
+ year:day, ends_with("delay"), distance, air_time)
#to add additional columns
mutate(flights_sm, gain = arr_delay - dep_delay, speed = distance/air_time* 60)
#transmutate

x <- 1:10
cumsum(x)
cummean(x)
#smins_since_mn
select(mutate(flights, dep_time, mins_since_mn = ( (dep_time %/% 100) * 60) + dep_time %% 100), h, everything())

#get the average delay on particularl days
by_day <- group_by(flights,year,month,day)
summarise(by_day,delay = mean(dep_delay,na.rm = TRUE))
#using pipe %>% to do various things, all in Tidy except ggplot use pipe!
#na.rm removes missing values prior to 
delays <- flights %>% group_by(dest) %>% summarise(count = n())
#and more complex e.g. removing Honololu airport as far away
delays <- flights %>% group_by(dest) %>% summarise(count = n(),
                                                   + dist = mean(distance, na.rm = TRUE),
                                                   + delay = mean(arr_delay, na.rm = TRUE)) %>%
  + filter (count > 20, dest != 'HNL')

not_cancelled <- flights %>% filter(!is.na(dep_delay),!is.na(arr_delay))

#tru and false...   true==1  false==0 if summed etc
not_cancelled %>% group_by(year,month,day) %>% summarize(n_early = sum(dep_time < 500)) 

#can gropu an ungroup multipe variables