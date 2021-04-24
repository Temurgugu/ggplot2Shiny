rm(list=ls())    # clear the workspace

#=== Temur Gugushvii === 

library(shiny)
library(ggplot2)
library(tidyverse)



#Build visualization with help of ggplot2 package;
#Prepare Shiny structure; 
#Build interactive visualization in shiny using ggplot2 and plotly;
#Publish Shiny app using. 

#Prepare and import the data; 

tg_tourism <- read.csv("data/tourism_data.csv")

tg_tourism <- tg_tourism %>%
  dplyr::filter( type_en == "Same Day Trips"|
                type_en == "International Visitor Trips")


#Build visualization with help of ggplot2 package;

ggplot2::ggplot(tg_tourism, aes_string("year", "visits", group = "type_en", color = "Tourist"))+
  geom_line()+
  geom_point()+
  theme_minimal(base_family="Sylfaen")+
  scale_x_continuous(breaks=seq(1995, 2020, 1))+
  scale_y_continuous(breaks=seq(0, 10000000, 1000000), 
                     labels = scales::comma)




selectizeInput(inputId = "color", 
               label = "Select Type(grouped) of Visits:",
               choices = color)
