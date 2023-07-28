#UI

library(shiny)
library(shinythemes)
library(shinyjs)
library(plotly)
library(leaflet)
library(crosstalk)
library(htmltools)
library(plotrix)
library(dplyr)

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
      #logo {
        max-width: 5%;
        height: auto;
        padding: 15px;
      }
      .question {
       font-size: 20px;
      }
      .conclude {
      font-size: 20px;
      }
      .sidebarPanel {
      padding: 200px;
      }
      .selectQ {
      font-size: 20px;
      }
      .shiny-input-container {
        color: #BE2F2F;
        
      }"))
    ),
    # Application title
    h1("An Analytical Investigation into Airbnb NYC"),
    h4(),
    h4("A project by Sindhu Swaroop, Niraj Sai Prasad, Reema Yadav & Aditya Tilak"),
    img(id = "logo", src='logo.png', align = "right"),
    h1(),
    actionButton(inputId = "do", label = "An Interesting Insight into our Dataset", onclick = "window.open(' https://nirajprasad12.shinyapps.io/insight/', '_blank')"),
    h1(),
    # Sidebar with a slider input for number of bins
    sidebarLayout(
       sidebarPanel(
            selectInput(
                inputId = "selectQuestion",
                label =  "Select Query Regarding AIRBNB",
                choices = c("Business Question 1",
                            "Business Question 2",
                            "Business Question 3",
                            "Business Question 4",
                            "Business Question 5",
                            "Business Question 6",
                            "Business Question 7",
                            "Business Question 8"),
                width = '15%',
                selectize = TRUE 
            ),
            h1(),
            uiOutput("obs1", class = "question"),
            width = 12
        ),

        # Show a plot of the generated distribution
       
        mainPanel(
          h1(),
            tabsetPanel(
                tabPanel("NYC Airbnb Map", leafletOutput("mymap")),
                tabPanel("Plot", plotOutput("distPlot")),
                tabPanel("Conclusion", uiOutput("distConclusion"), class = "conclude")
            ),
          width = 9
        )
    )
))
