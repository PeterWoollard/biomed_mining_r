

library(tidyverse)
data = ggplot2::diamonds
head(data)

ggplot(data) + geom_bar(mapping= aes(x = cut))

#doing as a PROPortion
ggplot(data) + stat_count(mapping= aes(x = cut, y = ..prop.., group =1))
ggplot(data) + stat_summary(mapping= aes(x = cut, y = depth),fun.ymin = min, fun.ymax = max, fun.y = median)
ggplot(data) + stat_count(mapping= aes(x = cut, fill = cut))

ggplot(data) + stat_count(mapping= aes(x = cut, fill = clarity))
#to see as proportions (i.e. clarity fraction across all the typos)
ggplot(data) + stat_count(mapping= aes(x = cut, fill = clarity), position = "fill")
#to stop overlapping
ggplot(data) + stat_count(mapping= aes(x = cut, fill = clarity), position = "dodge")
