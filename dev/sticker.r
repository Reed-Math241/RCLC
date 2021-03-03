library(hexSticker)
library(ggpubr)
library(tidyverse)
library(showtext)
library(RCLC)

plot.new()

font_add_google("Noto Sans JP", "Noto")
font_add_google("Playfair Display", "Play")
showtext_auto()

books <- reed_checkouts %>%
        ggplot(aes(Loaned)) +
        geom_histogram(fill="#000000", bins = 15) +
        theme_void() +
        title("Reed College Library Checkout")


books

sticker(books,
        package="RCLC",
        p_family = "Play",
        s_x = 1,
        s_width = 1.5,
        s_height =0.5 , 
        p_size = 25,
        url = "https://github.com/Reed-Math241/pkgGrpn", 
        spotlight = FALSE,
        u_color = "white", u_size = 3,
        u_family = "Noto",
        h_fill="#A70E16", h_color="grey",
        filename="man/figures/logo.png")
