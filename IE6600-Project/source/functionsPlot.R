set_theme <- theme(panel.grid.major = element_blank(), 
                   panel.grid.minor = element_blank(),
                   panel.border = element_blank(), 
                   plot.background = element_rect(fill = "white"), 
                   panel.background = element_rect(fill = "white"),
                   legend.key = element_rect(fill = "white"),
                   axis.line = element_line(colour = "black"),
                   plot.title = element_text(hjust = .5, face="bold"),
                   legend.text = element_text(face="bold"),
                   legend.title = element_text(face="bold"),
                   axis.text.x = element_text(face="bold"),
                   axis.text.y = element_text(face="bold"),
                   axis.title.x = element_text(face="bold"),
                   axis.title.y = element_text(face="bold"))

library(plotly)
#devtools::install_github("rstudio/leaflet#346")
library(leaflet)
library(crosstalk)
library(htmltools)
#install.packages("plotrix")
library(plotrix)
library(dplyr)

df  <- read.csv("AB_NYC_2019.csv")
df <- df %>% filter(minimum_nights<=365)
df <- df %>% filter(price!=0)

#Plot 1
callPlot1 <- function() {
leaflet(df) %>%
  addTiles() %>%
  addMarkers(~longitude, ~latitude,labelOptions = labelOptions(noHide = F),clusterOptions = markerClusterOptions(),popup = paste0("<b> Name: </b>", df$name , "<br/><b> Host Name: </b>", df$host_name, "<br> <b> Price: </b>", df$price, "<br/><b> Room Type: </b>", df$room_type, "<br/><b> Property Type: </b>", df$property_type)) %>% 
  setView(-74.00, 40.71, zoom = 12) %>%
  addProviderTiles("CartoDB.Positron")
}

#Plot 2
callPlot2 <- function() {
Brooklyn = df %>% filter(neighbourhood_group == "Brooklyn") %>% summarize(n())
Manhattan = df %>% filter(neighbourhood_group == "Manhattan") %>% summarize(n())
Bronx = df %>% filter(neighbourhood_group == "Bronx") %>% summarize(n())
Queens = df %>% filter( neighbourhood_group == "Queens") %>% summarize(n())
Staten_Island = df %>% filter( neighbourhood_group == "Staten Island") %>% summarize(n())

Brooklyn = as.integer(Brooklyn)
Manhattan = as.integer(Manhattan)
Bronx = as.integer(Bronx)
Queens = as.integer(Queens)
Staten_Island = as.integer(Staten_Island)

count = c(Brooklyn,Manhattan,Bronx,Queens,Staten_Island)
labels_area = c('Brooklyn','Manhattan','Bronx','Queens','Staten_Island')
piepercent <- round(100*count/sum(count), 1)

fig = pie3D(count, labels = piepercent, explode=0.1, main = "Airbnb Distribution in NYC", col = hcl.colors(length(count), "Spectral"), labelcex=1, theta=1.1)
par(xpd=TRUE)
legend(1,1, labels_area, cex = 0.8, fill = hcl.colors(length(count), "Spectral"))
}



#Plot 3
callPlot3 <- function() {
  top10private <- df %>%
    subset(room_type == "Private room") %>% 
    arrange(desc(number_of_reviews)) %>%
    slice(1:10) %>%
    select(name, neighbourhood_group, neighbourhood, price, room_type)
  
  top10home <- df %>% 
    subset(room_type == "Entire home/apt") %>%
    arrange(desc(number_of_reviews)) %>% 
    slice(1:10) %>% 
    select(name, neighbourhood_group, neighbourhood, price, room_type)
  
  top10 <- rbind(top10private, top10home)
  
  ggplot(top10, aes(room_type, price))+
    geom_boxplot(aes(fill=room_type)) + 
    theme(axis.text.x = element_text(angle=65, vjust=0.6)) + 
    ylim(0,225)+
    labs(title="Prices of Top 10 most reviewed Airbnbs by Room Type", 
         x="Room Type",
         y="Prices per night", fill="Room Type")+
    theme(axis.text.x = element_text(angle=0))+
    scale_fill_brewer(palette = "Dark2")+
    set_theme
}

#Plot 4
callPlot4 <- function() {
  df$last_review <- as.Date(df$last_review)
  df$year <- format(as.Date(df$last_review, format="%d/%m/%Y"),"%Y") 
  df <- subset(df, year != 'NA') 
  ggplot(df, aes(x = year, y = number_of_reviews, color=neighbourhood_group))+ 
    geom_point()+ 
    geom_abline()+
    theme(axis.text.x = element_text(angle = 45, hjust = 1))+ 
    labs(title="Number of Reviews Over Time", x="Year", y="Number of reviews", color = "Neighborhood") +
    scale_color_brewer(palette = "Dark2")+
    set_theme
}

#Plot 5
callPlot5 <- function() {
  ggplot(df, aes(x=minimum_nights, y=price)) +
    geom_line(color="tomato1")+
    labs(x="Minimum Nights" , y="Price", title = "Minimum Stay vs. Price")+
    set_theme
}

#Plot 6
callPlot6 <- function() {
  df <- df %>% 
    mutate(rent_category = 
             case_when(
               price>=0 & price<100 ~ "Low",
               price>=100 & price<200 ~ "Medium",
               price>200 ~ "High")
    )
  df %>% 
    group_by(rent_category) %>% 
    summarise(total= n()) %>% 
    drop_na(rent_category) %>% 
    ggplot(aes(x = reorder(`rent_category`, -total),  y = total, fill = rent_category)) +
    geom_bar(stat = "identity", width = 0.6)+
    labs(x="Price Category" , y="Number of Listings", title = "Number of Listings in Each Category", fill = "Price Category")+
    scale_fill_brewer(palette = "Dark2")+
    set_theme
}

#Plot 7
callPlot7 <- function() {
  dfp <- df %>% 
    subset(room_type == "Private room" & neighbourhood_group == "Manhattan") %>% 
    mutate(number_of_reviews=-1*number_of_reviews) %>% 
    group_by(neighbourhood, room_type) %>% 
    summarize(num=sum(number_of_reviews))
  
  dfh <- df %>% 
    subset(room_type == "Entire home/apt" & neighbourhood_group == "Manhattan") %>%
    group_by(neighbourhood, room_type) %>% 
    summarize(num=sum(number_of_reviews))
  
  dff <- rbind(dfp, dfh)
  
  dff$neighbourhood <- factor(dff$neighbourhood, levels=c("Harlem", "Hell's Kitchen", "East Harlem", "East Village", "Upper West Side", "Washington Heights", "Upper East Side", "Lower East Side", "Chelsea", "Midtown", "Chinatown", "Morningside Heights", "Inwood", "West Village", "Theater District", "SoHo", "Gramercy", "Financial District", "Greenwich Village", "Kips Bay", "Nolita", "Two Bridges", "Murray Hill", "Roosevelt Island", "Little Italy", "Tribeca", "NoHo", "Battery Park City", "Flatiron District", "Civic Center", "Stuyvesant Town", "Marble Hill"))
  
  brks <- seq(-40000, 40000, 5000)
  lbls <- as.character(c(seq(40000, 0, -5000), seq(5000, 40000, 5000)))
  
  ggplot(dff, aes(x = neighbourhood, y = num, fill = room_type)) +
    geom_bar(stat = "identity", width = 0.9) +
    scale_y_continuous(breaks = brks, labels=lbls) +
    coord_flip() + 
    labs(title="Number of Reviews in Manhattan Neighborhoods", x="", y="", fill="Room Type") +
    theme(axis.text.x = element_text(hjust=1, angle=30)) +
    scale_fill_brewer(palette = "Dark2") +
    set_theme
}

#Plot 8
callPlot8 <- function() {
  df_monthly <- df %>% filter(minimum_nights>=30)
  df_monthly %>% 
    group_by(neighbourhood) %>% 
    summarise(avg_price=mean(price)) %>% 
    arrange(desc(avg_price)) %>% 
    head(10) %>% 
    ggplot(aes(x = reorder(`neighbourhood`, -avg_price), y = avg_price, fill = neighbourhood)) +
    geom_bar(stat = "identity", width = 0.6)+
    labs(x="Locality" , y="Average Price", fill = "Locality", title = "Average Prices of Top 10 Most Expensive Localities")+
    scale_fill_brewer(palette = "Spectral")+
    theme(axis.text.x = element_text(hjust=1, angle=30))+
    set_theme 
}

