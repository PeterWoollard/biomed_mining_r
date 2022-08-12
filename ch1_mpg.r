

library(tidyverse)
data = ggplot2::mpg
head(data)
ggplot(data = ggplot2::mpg) + geom_point(mapping = aes(x = displ, y = hwy))
#https://www.maths.usyd.edu.au/u/UG/SM/STAT3022/r/current/Misc/data-visualization-2.1.pdf
#http://web.mit.edu/hackl/www/lab/turkshop/slides/r-cheatsheet.pdf

# ?mpg
nrow(mtcars)  #count of number of riawa
ggplot(data = ggplot2::mpg) + geom_point(mapping = aes(x = cyl, y = hwy))
ggplot(data = ggplot2::mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class))
ggplot(data = ggplot2::mpg) + geom_point(mapping = aes(x = displ, y = hwy, shape = class) , colour = "blue")

ggplot(data = ggplot2::mpg) + geom_point(mapping = aes(x = displ, y = hwy), colour = "blue")
ggplot(data = ggplot2::mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = cyl, shape = cyl))
#map variables to multiple
ggplot(data = ggplot2::mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = cyl, shape = class, size = class))
ggplot(data = ggplot2::mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5, stroke =5))

#get a count of a categoryggplot(data) + geom_point(mapping = aes(x = displ, y = hwy), position="jitter")
data %>% count(class)

#facet wraps:
ggplot(data = ggplot2::mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_wrap(~ class, nrow =3)
#and with 3 variables at once
ggplot(data = ggplot2::mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_wrap(drv ~ cyl)

#and as a grdi
ggplot(data = ggplot2::mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(drv ~ cyl)
#and all vatiables
ggplot(data = ggplot2::mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(. ~ cyl)


#smoothing data and seeing different elements on same chart
ggplot(data = ggplot2::mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))
#can u aes to get local e.g. colouring for geom_point 
ggplot(data = ggplot2::mpg, mapping = aes(x = displ, y = hwy)) + geom_point(mapping = aes(color=class)) + geom_smooth()
ggplot(data, mapping = aes(x = displ, y = hwy, color = class)) + geom_boxplot()
#without the Std err
ggplot(data, mapping = aes(x = displ, y = hwy, color = drv)) + geom_point() + geom_smooth(se = FALSE)

ggplot(data, mapping = aes(x = displ, y = hwy, group = drv, colour = drv)) + geom_point() + geom_smooth(se = FALSE)
ggplot(data, mapping = aes(x = displ, y = hwy)) + geom_point(aes(color=drv)) + geom_smooth(se = FALSE)

#to plot all points
ggplot(data) + geom_point(mapping = aes(x = displ, y = hwy), position="jitter")