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
##install.packages("stringr")
##install.packages("janeaustenr")
library(tidytext)
library(tibble)
library(dplyr)
library(stringr)
library(janeaustenr)

##  use austen books and convert them into tidy format 

tidy_books <- austen_books()   %>%
  group_by(book) %>%
  mutate(linenumber = row_number() , 
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", 
                                                 ignore_case = TRUE)))) %>%
  ungroup() %>%
  unnest_tokens(word, text)



nrc_joy <- get_sentiments("nrc") %>% filter(sentiment == "joy")
tidy_emma_book <- tidy_books %>% filter(book == "Emma")

emma_joy_sentiment_unigrams <- tidy_emma_book %>% 
  inner_join(nrc_joy) %>% 
  count(word , sort = TRUE) %>%
  filter(n > 50)
