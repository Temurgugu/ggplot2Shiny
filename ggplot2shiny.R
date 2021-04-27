rm(list=ls())    # clear the workspace

#=== Temur Gugushvii === 

library(shiny)
library(ggplot2)
library(tidyverse)

#Prepare and import the data; 

tg_tourism <- readr::read_csv("data/tourism_data.csv")

tg_tourism_filter <- tg_tourism %>%
                     dplyr::filter(type_en == "Same Day Trips"|
                                   type_en == "International Visitor Trips")


#Build visualization with help of ggplot2 package;

ggplot2::ggplot(tg_tourism_filter, aes_string("year", "visits", group = "type_en", color = "Tourist"))+
  geom_line()+
  geom_point()+
  scale_x_continuous(breaks=seq(1995, 2020, 1))+
  scale_y_continuous(breaks=seq(0, 10000000, 1000000), 
                     labels = scales::comma)




selectizeInput(inputId = "color", 
               label = "Select Type(grouped) of Visits:",
               choices = color)
