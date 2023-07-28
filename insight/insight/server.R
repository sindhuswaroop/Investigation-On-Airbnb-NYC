# Server

library(shiny)
library(ggplot2)
library(tidyr)
library(dplyr)
library(maps)
library(mapproj)
library(knitr)
library(shinythemes)
library(rsconnect)
library(wordcloud2)

source("source/functionsConclude.R")
source("source/functionsPlot.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    values <- reactiveValues(ng = NULL,
                             sh = NULL)
    
    observeEvent(
        input$selectn, {
            if (!NA %in% match(input$selectn, c("Manhattan", "Brooklyn", "Bronx", "Queens", "Staten Island"))) {
                values$ng <- input$selectn
            }
        })
    
    observeEvent(
        input$selects, {
            if (!NA %in% match(input$selects, c("circle", "triangle", "triangle-forward", "diamond", "pentagon"))) {
                values$sh <- input$selects
            }
        })
    output$obs1 <- renderUI({
        p(values$sh)
    })
    
    output$distPlot <- renderWordcloud2({
        callPlot1(values$ng, values$sh)
        
    })
    
    output$distConclusion <- renderUI({
        callConclude1()
    })
    
    
})
