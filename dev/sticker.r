library(hexSticker)
library(UCSCXenaTools)
library(ggpubr)
library(tidyverse)
library(showtext)
library(ggimage)

font_add_google("Noto Sans JP", "Noto")

font_add_google("Playfair Display", "Play")




books <- reed_checkouts %>%
          #mutate(Loaned = as.Date(Loaned,"%y-%m-%d")) %>%
          group_by(Loaned) %>%
          summarise(count = n()) %>%
          ggplot(aes(Loaned, count)) +
          geom_col(fill="#000000") +
          theme_void() +
          title("Reed College Library Checkout")

books



sticker(books,
        package="RCLC",
        p_family = "play",
        s_x = 1,
        s_width = 1.5,
        s_height =0.5 , 
        p_size = 13,
        url = "https://github.com/Reed-Math241/pkgGrpn", 
        spotlight = FALSE,
        u_color = "white", u_size = 1,
        u_family = "noto",
        h_fill="#A70E16", h_color="grey",
        filename="man/figures/logo.png")
