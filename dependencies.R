# This file allows packrat (used by rsconnect during deployment) to pick up dependencies.
library(rhino)
library(ggplot2)
library(shiny)
library(extrafont)
library(showtext)
library(ragg)
library(curl)

# load fonts
extrafont::loadfonts()
sysfonts::font_add("Arial", "/Library/Fonts/Arial.ttf")
showtext::showtext_auto()

