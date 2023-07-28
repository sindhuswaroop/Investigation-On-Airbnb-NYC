

#Plot 1
callPlot1 <- function(neighbourhoodGroup, shape1) {
  library(wordcloud2)
  df  <- read.csv("AB_NYC_2019.csv")
  data(stop_words)
  
  df_Manhattan <- df %>% 
    subset(neighbourhood_group == neighbourhoodGroup) %>% 
    unnest_tokens(word, name) %>% 
    anti_join(stop_words) %>% 
    count(word) 
  
return(wordcloud2(df_Manhattan, shape = shape1, shuffle = TRUE))
  
}