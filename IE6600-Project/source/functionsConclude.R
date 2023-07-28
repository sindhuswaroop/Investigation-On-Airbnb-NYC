callConclude1 <- function(){
  tags$ul(
    tags$li("New York City has a total of 48870 Airbnb listings as per our dataset."),
    tags$li("Using the above interactive map, we can see the location of each Airbnb in the city.")
  )
}

callConclude2 <- function(){
  tags$ul(
    tags$li("44.3% of all listings are located in Manhattan and 41.1% Airbnbs are situated in Brooklyn. Over 85% of Airbnbs are stationed in Manhattan and Brooklyn combined. So if a customer were to look for a place to stay in NYC, his/her best bet would be Manhattan or Brooklyn."),
    tags$li("Staten Island has the least number of Airbnbs (0.8%) i.e 373, in New York City."),
    tags$li("Queens, Bronx and Staten Island house less than 15% of listings. This is probably due to these neighborhoods not being well-connected to Manhattan, as compared to Brooklyn from where Manhattan is easily accessible through public transit.")
  )
}

callConclude3 <- function(){
  tags$ul(
    tags$li("We plotted a boxplot of Room Type vs. Prices per night, for the top 10 most reviewed listings in the dataset to visualize the median, maximum and minimum prices of each room type."),
    tags$li("The Room Type - Entire home/apt has a median price of 160, a minimum price of 49 and a maximum price of 575 which is an outlier (not shown in graph). The outlier is `TriBeCa 2500 Sq Ft w/ Priv Elevator` and the high price is probably due to the huge area and the presence of a private elevator. The variability of prices of Entire home/apt is high."),
    tags$li("The Room Type - Private Room has a median price of 49, a minimum price of 46 and a maximum price of 99 which is an outlier. The variability of prices of Private rooms is extremely low."),
    tags$li("The minimum price of an entire home is equal to the median price of a private room.")
  )
}

callConclude4 <- function(){
  tags$ul(
    tags$li("From the plot above, it is clear that the number of reviews over the years follows a positive trend. This indicates that more and more people have started reviewing their experiences at Airbnb."),
    tags$li("The number of reviews increased from 2011 to 2019 drastically. 2019 had the most number of reviews and 2011, the least."),
    tags$li("Staten Island and Bronx listings barely have any reviews owing to low number of Airbnbs in these two regions for NYC."),
    tags$li("In 2019, most number of reviews were gathered from the Queens region. 2018 saw highest number of reviews for Manhattan listings and in 2017, Brooklyn Airbnbs were most reviewed."),
    tags$li("Until 2016, number of reviews for a listing never crossed 200. On the contrary, maximum reviews gained in 2019 was over 600.")
  )
}

callConclude5 <- function(){
  tags$ul(
    tags$li("From the above line graph, we can see a decreasing trend for minimum number of nights vs. price."),
    tags$li("The price is usually higher for listings with fewer minimum nights of stay."),
    tags$li("Most listings have minimum nights less than 100 days, which is convenient for tourists."),
    tags$li("As the minimum stay increases from ~120 days to ~365 days, the price reduces. This works in favor of those customers who have longer stays planned at NYC. ")
  )
}

callConclude6 <- function(){
  tags$ul(
    tags$li("We divided the price range into 3 categories - Low (Rent<100), Medium (100<Rent<200) & High (Rent>200)."),
    tags$li("From the graph above, we can see that 22000 listings have a price of less than 100$. Most listings belong to the Low price category. Owners would profit more by pricing their listings in the lower range as it attracts more customers, which is probably why the Low price category has so many listings."),
    tags$li("18000 listings fall in the Medium price range, with a price range of 100 - 200$."),
    tags$li("Only a few Airbnbs (8000) cost more than 200$.")
  )
}

callConclude7 <- function(){
  tags$ul(
    tags$li("Manhattan, the biggest town in NYC has 32 neighborhoods, the most popular in the Airbnb aspect being Harlem, and the least popular being Marble Hill. "),
    tags$li("In most neighborhoods, we can see from the graph that travellers gravitate towards entire homes/apartments rather than renting out private rooms. This was an interesting result as at first glance, we would think private rooms, being the cheaper option, would be the go-to choice of travellers. From the Rentals policy in NYC, it should be noted that unhosted rentals for less than 30 days in buildings with multiple dwellings are illegal in the city. So families will rent out entire apartments and even individual travellers would prefer privacy rather than living with the host, and tend to rent out smaller apartments."),
    tags$li("However, there are a couple of neighborhoods like Harlem, Hell's Kitchen and Washington Heights which have more number of reviews for private rooms than entire homes. These listings are probably either >30-day listings or not in multiple-dwelling units (or they might be illegal listings!).")
  )
}

callConclude8 <- function(){
  tags$ul(
    tags$li("From the above graph, we can see that 7 of the 10 most expensive localities belong to the Manhattan neighborhood group."),
    tags$li("Brooklyn is home to 2 of the 10 most pricy listings and one of the listings is located in Queens."),
    tags$li("Bay Ridge and Forest Hills have an almost equal average rent, as do West Village and Astoria."),
    tags$li("Tribeca has the highest average rent, of above 600$."),
    tags$li("Travellers planning budget trips would do good to stay clear of these localities!")
  )
}
