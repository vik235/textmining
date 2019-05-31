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
##install.packages("ggplot2")
library(tidytext)
library(tibble)
library(dplyr)
library(stringr)
library(janeaustenr)
library(tidyr)
library(ggplot2)

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

bing_sent <- get_sentiments("bing")


## get the sentiments using Bing lex for Emma book and plot it 
 chunks_sentiment_bing <- 
   tidy_emma_book %>% 
  inner_join(get_sentiments("bing")) %>% 
   mutate(chunk = linenumber %/% 80 ) %>%
   count(sentiment , chunk) %>% 
   spread(sentiment , n) %>% 
  mutate(sentiment = positive - negative , ispos = ((positive - negative)>0 ))
 #%>% 
#  count(chunk, ispos)
 ggplot(chunks_sentiment_bing , aes(chunk , sentiment)) + 
   geom_col()
 
 ## get the sentiments using Bing lex for All Jane Austen book and plot it 
 
 jane_austen_chunks_sentiment <- tidy_books %>% 
   inner_join(get_sentiments("bing")) %>% 
   #mutate(chunk = linenumber %/% 80 ) %>%
   count(book, chunk = linenumber %/% 80, sentiment ) %>% 
   spread(sentiment , n) %>% 
   mutate(sentiment = positive - negative , ispos = ((positive - negative)>0 ))
 
 
 ggplot(jane_austen_chunks_sentiment , aes(chunk, sentiment, fill = book)) + 
  geom_col() + 
   facet_wrap(~book, ncol = 2)
 