library(tidyverse)
# 1 Data visualization ----
library(palmerpenguins)
### 1.2.5 Exercises -----

# 1. How many rows are in penguins? How many columns?
linhas <- dim(penguins)[1]
colunas <- dim(penguins)[2]
sprintf("Existem %1d linhas e %2d colunas no dataframe.",linhas, colunas)
rm(linhas,colunas)

# 2. What does the bill_depth_mm variable in the penguins data frame describe? 
# Read the help for ?penguins to find out.
?penguins
## R: a number denoting bill depth (millimeters)

# 3. Make a scatterplot of bill_depth_mm vs. bill_length_mm. 
# That is, make a scatterplot with bill_depth_mm on the y-axis and bill_length_mm on the x-axis. 
# Describe the relationship between these two variables.
ggplot(
  data = penguins,
  mapping = aes(x=bill_depth_mm, y=bill_length_mm, color=species)
)  +
  geom_point() +
  geom_smooth()
# R: há correlação positiva quando se analisa por espécie, mas não há padrão geral

# 4. What happens if you make a scatterplot of species vs. bill_depth_mm? 
# What might be a better choice of geom?
ggplot(
  data = penguins,
  mapping = aes(x=species, y=bill_depth_mm)
) + 
  geom_boxplot()
 
# 5. Why does the following give an error and how would you fix it?
# ggplot(data = penguins) + 
#   geom_point()
ggplot(data = penguins,
       mapping = aes(x=bill_depth_mm, y=bill_length_mm)) +
  geom_point()
# R: falta o x e y

# 6. What does the na.rm argument do in geom_point()? # R: remove os NA
# What is the default value of the argument? R: FALSE
# Create a scatterplot where you successfully use this argument set to TRUE.
ggplot(
  data = penguins,
  mapping = aes(x=bill_depth_mm, y=bill_length_mm, color=species)
)  +
  geom_point(na.rm = TRUE) 

# 7. Add the following caption to the plot you made in the previous exercise: 
# “Data come from the palmerpenguins package.” 
# Hint: Take a look at the documentation for labs().
ggplot(
  data = penguins,
  mapping = aes(x=bill_depth_mm, y=bill_length_mm, color=species)
)  +
  geom_point(na.rm = TRUE) + 
  geom_smooth() + 
  labs(caption = "Data come from the palmerpenguins package.")

# 8. Recreate the following visualization. What aesthetic should bill_depth_mm be mapped to? 
# And should it be mapped at the global level or at the geom level?
install.packages("png")
library(png)
img <- readPNG("C:/Users/NOVO/Desktop/R_base/objetivo.png")
grid::grid.raster(img)

ggplot(
  data = penguins,
  mapping = aes(x=flipper_length_mm, y=body_mass_g, color=bill_depth_mm)
) +
  geom_point() +
  geom_smooth() +
  labs()

# 9. Run this code in your head and predict what the output will look like. 
#Then, run the code in R and check your predictions.
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)

# 10. Will these two graphs look different? Why/why not?
# R: não parecem, mas na teoria são pela hierarquia dos comandos.
# O segundo define as coisas para nível global, então se haver mudanças de cor, por exemplo, será a nível global
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point() +
  geom_smooth()

ggplot() +
  geom_point(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
  geom_smooth(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  )

### 1.4.3 Exercises ----
# 1. Make a bar plot of species of penguins, where you assign species to the y aesthetic. 
# How is this plot different? R: dá uma sensação de "ranking"
ggplot(
  data = penguins,
  aes(y = fct_infreq(species))
) +
  geom_bar()

# 2. How are the following two plots different? Which aesthetic, color or fill, 
# is more useful for changing the color of bars?
ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")
# R: o primeiro define as bordas das barras, o segundo define a barra toda

# 3. What does the bins argument in geom_histogram() do?
?geom_histogram
# R: Number of bins. Overridden by binwidth. Defaults to 30 

# 4. Make a histogram of the carat variable in the diamonds dataset 
# that is availabe when you load the tidyverse package. Experiment with different binwidths. 
# What binwidth reveals the most interesting patterns?
View(diamonds)
ggplot(
  data = diamonds,
  aes(x = carat)
) +
  geom_histogram(binwidth = 0.07)

## 1.5.5 Exercises ----
# 1. The mpg data frame that is bundled with the ggplot2 package contains 234 observations 
# collected by the US Environmental Protection Agency on 38 car models.
# Which variables in mpg are categorical? Which variables are numerical?
# (Hint: Type ?mpg to read the documentation for the dataset.)
# How can you see this information when you run mpg?
View(mpg)
?mpg
colnames(mpg)
summary(mpg)
# R: 
# categorical
## manufacturer
## model
## year
## trans
## drv
## fl
## class  

# numerical
## displ
## cyl
## cty
## hwy

# 2. Make a scatterplot of hwy vs. displ using the mpg data frame. 
# Next, map a third, numerical variable to color, then size, then both color and size, then shape. 
# How do these aesthetics behave differently for categorical vs. numerical variables?
library(patchwork)
g1 <- ggplot(
  data = mpg,
  aes(x = hwy, y = displ, color=cyl)
) + 
  geom_point()

g2 <- ggplot(mpg,
       aes(x = hwy, y = displ, size=cyl)) +
  geom_point()

g3 <- ggplot(mpg,
             aes(x = hwy, y = displ, size=cyl, color=cyl)) +
  geom_point()

g4 <- ggplot(mpg,
             aes(x = hwy, y = displ, color=cyl, shape=drv)) +
  geom_point()
(g1+g2)/(g3+g4)

# 3. In the scatterplot of hwy vs. displ, what happens if you map a third variable to linewidth?
ggplot(
  data = mpg,
  aes(x = hwy, y = displ, linewidth = cty)
) +
  geom_point() 

# 4. What happens if you map the same variable to multiple aesthetics?
   
# 5. Make a scatterplot of bill_depth_mm vs. bill_length_mm and color the points by species. 
# What does adding coloring by species reveal about the relationship between these two variables? 
# What about faceting by species?

# 6. Why does the following yield two separate legends? How would you fix it to combine the two legends?
ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm, 
    color = species, shape = species
  )
) +
  geom_point() +
  labs(color = "Species")

# 7. Create the two following stacked bar plots. 
# Which question can you answer with the first one? 
# Which question can you answer with the second one?
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")
ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")

## 1.6.1 Exercises ----
# 1. Run the following lines of code. Which of the two plots is saved as mpg-plot.png? Why?
ggplot(mpg, aes(x = class)) +
  geom_bar()
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave("mpg-plot.png")
# R: pq foi a última que foi rodada

# 2. What do you need to change in the code above to save the plot as a PDF instead of a PNG? How could you find out what types of image files would work in ggsave()?


# 3  Data transformation ----
library(nycflights13)
# install.packages("nycflights13")
View(flights)
## 3.2.5 Exercises ----
# 1. In a single pipeline for each condition, find all flights that meet the condition:
  # Had an arrival delay of two or more hours
  flights |> filter(arr_delay >= 120)
  # Flew to Houston (IAH or HOU)
  flights |> filter(dest %in% c('IAH','HOU'))
  # Were operated by United, American, or Delta
  flights |> filter(carrier %in%  c('UA', 'AA', 'DL'))
  # Departed in summer (July, August, and September)
  flights |> filter(month %in% c(7:9))
  # Arrived more than two hours late, but didn’t leave late
  flights |> filter(arr_delay >= 120 & dep_delay <= 0)
  # Were delayed by at least an hour, but made up over 30 minutes in flight
  flights |> filter(dep_delay >= 60 & (dep_delay - arr_delay) > 30) |> view()

# 2. Sort flights to find the flights with longest departure delays. Find the flights that left earliest in the morning.
flights |> arrange(dep_delay) |> view()
View(arrange(flights, dep_time))

# 3. Sort flights to find the fastest flights. (Hint: Try including a math calculation inside of your function.)
flights |> 
  mutate(velocidade = distance/air_time) |>
  arrange(desc(velocidade)) |>
  view()

# 4. Was there a flight on every day of 2013?
unique(flights['year'])
flights |>
  distinct(year,day,month) |>
  nrow()
# R: sim, todos os dias (365 dias) de 2013 houveram voos

# 5. Which flights traveled the farthest distance? Which traveled the least distance?
flights |>
  arrange(distance) |>
  view()
# R: voo 1632 com 17 miles
flights |>
  arrange(desc(distance)) |>
  view()
# R: voo 51 com 4983 miles

# 6. Does it matter what order you used filter() and arrange() if you’re using both? Why/why not? Think about the results and how much work the functions would have to do.
x <- flights |> 
  filter(arr_delay >= 120) |>
  arrange(arr_delay) 

y <- flights |> 
  arrange(arr_delay) |>
  filter(arr_delay >= 120) 
x==y
# R: aparantemente não muda

## 3.3.5 Exercises ---- 
# 1. Compare dep_time, sched_dep_time, and dep_delay. How would you expect those three numbers to be related?
departures <- flights |>
  select('dep_time', 'sched_dep_time', 'dep_delay')
summary(departures)
departures <- departures |>
  mutate(dep_delay_test = dep_time - sched_dep_time) |>
  mutate(test = dep_delay_test - dep_delay)
departures
# R: esperava que o dep_delay fosse igual a (dep_time - sched_dep_time), porém em alguns voos eles diferem
