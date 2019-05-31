#####
##' Sentiment analysis 
##' tidy text format
##' AFINN, bing et al. and nrc  Lexicons
##' positive and negative sentimets. 
##

####Get the packages we need

##install.packages("tibble")
##install.packages("dplyr")
##install.packages("tidytext")
library(tidytext)
library(tibble)
library(dplyr)

#this tibble frame is available from tidytext
sentiments

## afinn from -5 to +5 .. str
get_sentiments("afinn")

## bing binary 
get_sentiments("bing")


## nrc much much more .. 
get_sentiments("nrc") %>% 
  filter(sentiment == "negative" | sentiment == "positive")

##these are crowd sourced so pros and cons. Be sensitive to this
## consider usign domain specific lexicons
## these are also unigram lexs ..

## be considerate on the size of the chunk of the text considered. 