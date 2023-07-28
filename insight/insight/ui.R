#UI

library(shiny)
library(shinythemes)
library(shinyjs)
library(wordcloud2)
library(tidytext)

# Define UI for application that draws a histogram

shinyUI(fluidPage(
    theme = shinytheme("sandstone"), 
    tags$head(
        # Note the wrapping of the string in HTML()
        tags$style(HTML("
      @import url('https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap');
      body {
        background-color: white;
        color: #BE2F2F;
      }
      h4 {
        font-family: 'Yusei Magic', sans-serif;
      }
      .sidebarPanel {
      padding: 200px;
      },
      .shiny-input-container {
        color: #BE2F2F;
       }
     "))
    ),
    # Application title
    h1("Insight into our Dataset"),
    h2("Business Question 9"),
    h3("Our dataset consists of unique names for each listing. We drew a Word Cloud in order to visualize the words that appear most frequently in listing names of a particular neighborhood group. These words could be useful to people in searching for an Airbnb on search engines."),
    
    # Sidebar with a slider input for number of bins
    fluidRow(
        column(6,
            radioButtons(
                inputId = "selectn",
                label =  "Select Neighbourhood",
                choices = c("Manhattan", "Brooklyn", "Bronx", "Queens", "Staten Island")
            )
          ),
          column(6,
              radioButtons(
                inputId = "selects",
                label =  "Select Shape of Wordcloud",
                choices = c("circle", "triangle", "triangle-forward", "diamond", "pentagon")
          )),
          column(12, align = "center",
                 tabsetPanel(
                   tabPanel("Plot", wordcloud2Output("distPlot")),
                   tabPanel("Conclusion", uiOutput("distConclusion"), align = "left")
                 ))
        )
))
