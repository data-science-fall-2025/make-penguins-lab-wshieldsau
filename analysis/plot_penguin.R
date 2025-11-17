##############
## Synopsis: Make a pairs plot of the famous penguins dataset
## Author: David Gerard
##############

library(tidyverse)
library(GGally)
library(palmerpenguins)
data("penguins")

my_density <- function(data, mapping, ...) {
  ggplot(data, mapping) +
    geom_density()
}

penguins %>%
  rename(`Bill Length (mm)` = bill_length_mm,
         `Bill Depth (mm)` = bill_depth_mm,
         `Flipper Length (mm)` = flipper_length_mm,
         `Body Mass (g)` = body_mass_g) %>%
ggpairs(columns = c("Bill Length (mm)", "Bill Depth (mm)",
                    "Flipper Length (mm)", "Body Mass (g)"),
        upper = NULL,
        diag = list(continuous = my_density),
        mapping = aes(color = species)
) +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  scale_color_manual(values = c("red", "green", "blue")) ->
  pl

png(file = "./output/penguin_pairs.png",
    width = 700,
    height = 700,
    family = "Times")
pl
dev.off()
