
#libraries

library(shiny)
library(ggplot2)
library(plotly)
library(tidyverse)


#import data

tg_tourism <- readr::read_csv("data/tourism_data.csv")

#variable

color <- c("type_en", "Tourist")


# Define UI 
ui <- fluidPage(

# Application title
titlePanel("ggplot2Shiny Workshop"),

# Sidebar with control
sidebarLayout(
    sidebarPanel(
            selectizeInput(inputId = "visits_type", 
                           label = "Select Type of Visits:",
                           choices = unique(tg_tourism$type_en),
                           selected = c("International Traveller Trips", "Same Day Trips"),
                           multiple = T),
            
            selectizeInput(inputId = "color", 
                           label = "Select Type(grouped) of Visits:",
                           choices = color),
            
            sliderInput(inputId = "year_filter",
                        label = "Filter Year",
                        min = 1995,
                        max = 2020,
                        value = c(1995, 2017),
                        sep = ""),
            
            
        ),

# Show a plot ggplot and  plotly
mainPanel(
 tabsetPanel(
     tabPanel("ggplot2",
              plotOutput("tourism_ggplot")
            ),
            
    tabPanel("plotly", 
             plotlyOutput("tourism_plotly")
            )
))))

# Define server 
server <- function(input, output) {

tg_tourism_filter <- reactive({
        minyear <- input$year_filter[1]
        maxyear <- input$year_filter[2]
        
        tg_tourism %>%
            dplyr::filter(year >= minyear, year <= maxyear) %>%
            dplyr::filter(type_en %in% input$visits_type)
                       })

#ggplot

output$tourism_ggplot  <- renderPlot({
    
    ggplot2::ggplot(tg_tourism_filter(), aes_string("year", "visits", group = "type_en", color = input$color))+
        geom_line()+
        geom_point()+
        theme_minimal(base_family="Sylfaen")+
        scale_x_continuous(breaks=seq(1995, 2020, 1))+
        scale_y_continuous(breaks=seq(0, 10000000, 1000000), 
                           labels = scales::comma)
    
}) 


#plotly 

output$tourism_plotly  <- renderPlotly({
    
tourism_digram <- ggplot2::ggplot(tg_tourism_filter(), aes_string("year", "visits", group = "type_en", color = input$color))+
                  geom_line()+
                  geom_point()+
                  theme_minimal(base_family="Sylfaen")+
                  scale_x_continuous(breaks=seq(1995, 2020, 1))+
                  scale_y_continuous(breaks=seq(0, 10000000, 1000000), 
                                     labels = scales::comma)
    
    plotly::ggplotly(tourism_digram)
    
}) 



    
}

# Run the application 
shinyApp(ui = ui, server = server)
