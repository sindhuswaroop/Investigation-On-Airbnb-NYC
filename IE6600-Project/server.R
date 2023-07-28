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

source("source/functionsPlot.R") #Plot funtions sourced from another file
source("source/functionsConclude.R") #Conclusion sourced from another file


# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    values <- reactiveValues(tbl = NULL)
    
    observeEvent(
        input$selectQuestion, {
            if (!NA %in% match(input$selectQuestion, c("Business Question 1",
                                                       "Business Question 2",
                                                       "Business Question 3",
                                                       "Business Question 4",
                                                       "Business Question 5",
                                                       "Business Question 6",
                                                       "Business Question 7",
                                                       "Business Question 8"))) {
                values$tbl <- as.data.frame(input$selectQuestion)
            }
        })

    output$obs1 <- renderUI({
        
        if(values$tbl == "Business Question 1"){
            p("When examining the dataset, we came across almost 49000 listings. Visualizing these listings on a map would be much easier for customers and Airbnb hosts alike. Plot Airbnbs by city/latitude/longitude to determine where Airbnbs are concentrated in New York City.")
        }
        else if(values$tbl == "Business Question 2"){
            p("New York City comprises of 5 major neighborhoods. It would be beneficial for travellers to know how the Airbnbs are spread out  across the city. Plot a pie chart to visualize the distribution of Airbnbs among different areas by percentage.")
        }
        else if(values$tbl == "Business Question 3"){
            p("Different room types should be priced differently, but it would be advantageous to know how divergent the prices are. For the top 10 Airbnbs with most reviews in the dataset, what is the median, minimum and maximum price per night for each of the room types? Plot a boxplot for visualization.")
        }
        else if(values$tbl == "Business Question 4"){
            p("Airbnb was founded in 2008, and grew popular in 2011. As of today, it is one of the most preferred lodging rentals all over the world. In light of this, what is the trend of number of reviews over the years 2011 to 2019? Plot a scatterplot to envision this.")
        }
        else if(values$tbl == "Business Question 5"){
            p("Each Airbnb listing has a minimum length of stay, which requires customers to book the room for a minimum number of nights. On these lines, is there a relationship between price per night and minimum length of stay? Plot a line graph to visualize the trend.")
        }
        else if(values$tbl == "Business Question 6"){
            p("Pricing of Airbnb listings varies from 10$ to 10000$. To enhance the usability of this data by owners, pricing information should be more accurately depicted. This way, they will know what price range is most common and how much to price their next listings. Divide the prices into three categories and plot a bar chart to visualize the number of listings in each price range.")
        }
        else if(values$tbl == "Business Question 7"){
            p("Airbnb hosts can list anything from a private room to the entire home/apartment. Do travelers gravitate towards a specific room type? Plot a funnel chart for number of reviews in different neighborhoods in NYC's most popular town - Manhattan.")
        }
        else if(values$tbl == "Business Question 8"){
            p("Looking at New York City as a whole with all the neighborhoods included, what are the top 10 localities with the most expensive  listings? Plot a bar graph to visualize this.")
        }
    })
    
    output$mymap <- renderLeaflet({
        
        callPlot1()
    })
    
    output$distPlot <- renderPlot({
        if(values$tbl == "Business Question 2")
        { callPlot2() }
        else if(values$tbl == "Business Question 3")
        { callPlot3() }
        else if(values$tbl == "Business Question 4")
        { callPlot4() }
        else if(values$tbl == "Business Question 5")
        { callPlot5() }
        else if(values$tbl == "Business Question 6")
        { callPlot6() }
        else if(values$tbl == "Business Question 7")
        { callPlot7() }
        else if(values$tbl == "Business Question 8")
        { callPlot8() }
    })
    
    output$distConclusion <- renderUI({
        if(values$tbl == "Business Question 1")
        { callConclude1() }
        else if(values$tbl == "Business Question 2")
        { callConclude2() }
        else if(values$tbl == "Business Question 3")
        { callConclude3() }
        else if(values$tbl == "Business Question 4")
        { callConclude4() }
        else if(values$tbl == "Business Question 5")
        { callConclude5() }
        else if(values$tbl == "Business Question 6")
        { callConclude6() }
        else if(values$tbl == "Business Question 7")
        { callConclude7() }
        else if(values$tbl == "Business Question 8")
        { callConclude8() }
    })
    

})
