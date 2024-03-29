library(tidyverse)
install.packages("palmerpenguins")
library(palmerpenguins)

View(penguins)
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g), 
  #specify which variables to map to the x and y axes
  ) +
  geom_point()
  
