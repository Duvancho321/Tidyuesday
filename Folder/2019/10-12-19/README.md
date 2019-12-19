
<!-- README.md is generated from README.Rmd. Please edit that file -->

``` r
#Bibliotecas necesarias
library(tidytuesdayR)
library(tidyverse)
library(ggsci)
library(gganimate)
library(ggthemes)
```

``` r
#Lectura de Datos
tt <- tt_load(2019,50) 
tt_dat<- tt$diseases
save(tt_dat,file = "disease.Rdata")
```

``` r
load("disease.Rdata")

top_disease <- tt_dat %>% 
  ungroup() %>% 
  group_by(state) %>% 
  summarise(n = sum(count)) %>% 
  top_n(12)
top_disease <- c(top_disease$state)
```

``` r

my.colors <- colorRampPalette(c("grey23", "cyan3", "#007FFF", "navy", "violet", "darkviolet"), bias = 2.25)

g <- tt_dat %>% 
  mutate_if(is.character,as.factor) %>% 
  filter(state %in% top_disease) %>%
  mutate(rate = count *10000*52 / population / weeks_reporting ) %>% 
  ggplot(.,aes(x = year, y = reorder(disease,desc(disease)), fill = rate )) +
  geom_tile(color = "grey10", size =.2 ) +
  scale_fill_gradientn(colors = my.colors(30), na.value = 'grey10')+
  labs(title = "Disease Rate",
       x = "Year",
       y = "Disease",
       fill = "Rate",
       caption = "Vizualization by @DuvanNievesRui1 | Data: 'Replicating plots in R' • Simply Statistics") +
  facet_wrap(~state,scales = "free")+
  theme(panel.grid = element_blank(),
        axis.ticks.y = element_line(color = "grey76"),
        legend.position = "top",
        legend.background = element_rect(fill = "grey10"),
        legend.key.size = unit(1.5,"cm"),
        panel.background = element_rect(fill="grey10",color = "grey10"),
        plot.background = element_rect(fill="grey10"),
        strip.background = element_rect(fil="grey20"),
        panel.spacing = unit(2, "lines"),
        plot.title = element_text(size=28, color="grey76",hjust = .5),
        plot.subtitle  = element_text(size=20, color="grey76"),
        plot.caption = element_text(size = 14,color = "grey76", hjust = .99),
        axis.text = element_text(family = "Roboto Mono",
                                 size = 10,
                                 colour = "grey76"), 
        strip.text.x =element_text(family = "Roboto Mono",
                                   size = 14,
                                   colour = "grey76"), 
        axis.title =  element_text(family = "Roboto Mono",
                                   size = 20,
                                   colour = "white"),
        legend.text = element_text(family = "Roboto Mono",
                                   size = 10,
                                   colour = "grey76"),
        legend.title = element_text(family = "Roboto Mono",
                                   size = 14,
                                   colour = "grey76")) +
  transition_time(year)+
  shadow_mark()

animate(g, renderer = gifski_renderer(),height = 700, width =1400,fps = 10)
```

![](README_files/figure-gfm/unnamed-chunk-3-1.gif)<!-- -->
