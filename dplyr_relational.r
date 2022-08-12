library(tidyverse)
library(nycflights13)

#checking a primary key only occurs once.
count(tailnum) %>% filter(n>1)

#if table lacks  primary key, c reate on e.g. mnutate or rownum, cllaed  surrogate key
flights2 <- flights %>% mutate(rowid = row_number(),.before = 'year')


install.packages("Lahman")
library(Lahman)

#mutatong joinds
flights2 <- flights %>% select(year:day,hour,origin,dest,tailnum,carrier)
flights2 %>% inner_join(airlines, by = "carrier")
flights2 %>% left_join(airlines, by = "carrier")
flights2 %>% right_join(airlines, by = "carrier")
flights2 %>% full_join(airlines, by = "carrier")

flights2 %>% left_join(weather) # on all common
flights %>% left_join(planes, by = "tailnum") # nb. year is differnt meain in each
#n.b. year.x and year.y no present (where they were not equal)

flights %>% left_join(airports,c("dest" ="faa"))
#get ave destination delay
group_by(dest) %>% mutate(delay_mean=mean(arr_delay, na.rm=TRUE), .before = year)
flights %>% group_by(dest) %>% mutate(delay_mean=mean(arr_delay, na.rm=TRUE), .before = year) %>% left_join(airports,c("dest" = "faa"))

flights_delay <- flights %>% group_by(dest) %>% mutate(delay_mean=mean(arr_delay, na.rm=TRUE), .before = year) %>% left_join(airports,c("dest" = "faa")) 
flights_delay %>% ggplot(aes(lon,lat)) + borders("state") + geom_point(na.rm=TRUE) + coord_quickmap()
flights_delay %>% ggplot(aes(lon,lat)) + borders("state") + geom_point(aes(color = delay_mean), na.rm=TRUE) + coord_quickmap()

flights_delay_a <- flights %>% group_by(dest) %>% mutate(delay_mean=mean(arr_delay, na.rm=TRUE), .before = year)
flights_delay_a %>% left_join(planes, by = "tailnum") %>% mutate(plane_age = year.x - year.y, .before = delay_mean) %>% ggplot(aes(plane_age,delay_mean)) + geom_point(aes(color = delay_mean),na.rm = TRUE)

top_dest <- flights %>% count(dest,sort = TRUE) %>% head(10)
#semi_join - only matching rows that have a match - does not add columns   nb. anit_join is the inveersw
flights %>% semi_join(top_dest)
