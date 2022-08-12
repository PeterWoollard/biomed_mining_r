library(tidyverse)
iris
as_tibble(iris)
#2 main differences between tibbles and data frames: printing and subsetting
#tibble are jsut tidyR
#tribble = transposed tibble


#first 10 rows and all columns
nycflights13::flights %>%  print(n=10,width = Inf)
#pull out by column names
nycflights13::flights[["time_hour"]]
nycflights13::flights[c("time_hour","carrier")]

#as.data.frame(tibble)
