library(tidyverse)

#a bunch of reagining rotuines read_*
#readr using a heuristic to figure out coluimsn, reads forst 1000 rows


#read_csv("data/heights.csv")
#way of reading a file inline
read_csv("a,b,c
1,2,3
4,5,6")

read_csv("#comment to skip
a,b,c
1,2,3
4,5,6", comment = "#")

read_csv("1,2,3\n4,5,6", col_names = FALSE)
read_csv("1,2,3\n4,5,6", col_names = c("a","b","c"))
#tidyR reads are 10x quciker than baseR read.csv()

read_delim("1|2|3\n4|5|6", col_names = c("a","b","c"), delim = "|")

#reader builds on top of readr
str(parse_date(c("2020-01-01","2021-09-09")))
str(parse_logical(c("TRUE","FALSE","NA")))
str(parse_integer(c("2020","2021")))

str(parse_integer(c("2020","2021","."),na = "."))
parse_double("1.23")

parse_double("1,23",locale = locale(decimal_mark =','))

parse_number("it cost £1.23")  #ignores non numeric chars


x1 <- "el Ni\xf1o"
guess_encoding((charToRaw(x1)))

#factors
fruit <- c("apple","banana")
parse_factor(c("apple","banana","ban"),levels= fruit)

#parse_Date_time
parse_datetime("2010-10-01T2030")   # by defauly is IS0_8601
library(hms)
parse_time("01:10 am")
#for coping with US dates etc,
parse_date("12/13/14","%m/%d/%y")
parse_date("1 janvier 2015","%d %B %Y", locale = locale("fr"))
parse_date("1706","%Y")

#guessing:i if not recognised, isa vector of stringds
guess_parser("2015-01-01")
guess_parser(c("TRUE","FALSE"))
challenge <- read_csv(readr_example("challenge.csv"))
problems(challenge)
#suggestion is to work column by columns to resolvedd the col type.
#to force the coluymn types - and recommended that you always do, this as it build up documentation
read_csv(readr_example("challenge.csv"),col_types = cols(x= col_double(),y = col_date()))
tail(challenge)
#can 
challenge2 <- read_csv(readr_example("challenge.csv"),col_types = cols(.default = col_character()))
#then
type_convert(challenge2)
#N.B. set n_max to say 10,000 if a bg file to get most common problems first off.

write_csv(challenge,"challenge.csv")
write_csv(challenge2,"challenge2.csv")

library(feather) #feather useable outside  , install.packages("feather") #feather is fast binary and keeps columns stuff
write_feather(challenge,"challenge.feather")


#tidy_data

