library(tidyverse)
install.packages("palmerpenguins")
library(palmerpenguins)

View(penguins)

# 1 GRAPH BASIC
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g), 
  #specify which variables to map to the x and y axes
  ) +
  geom_point() #create a scatterplot
  
# 2 Adding aesthetics and layers
## retas de RL e cor por espécie
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point() +
  geom_smooth(method = "lm") #draw the line of best fit based on a linear model

# uma única reta para todo o modelo, cada função geom é de nível local
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species)) +
  #muda a cor
  geom_smooth(method = "lm")


ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species, shape = species)) +
  #shape: muda o formato dos pontos
  geom_smooth(method = "lm")

# adicionando títulos e mudando paleta
install.packages("ggthemes")
library(ggthemes)
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()

# criando facetas para muitas variáveis
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)


