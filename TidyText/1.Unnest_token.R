##' unnest_tokens : A simple tokenizer that transforms the tokens into
##' tidy text format
## 

##Get the packages we need
##install.packages("tibble")
##install.packages("dplyr")
##install.packages("tidytext")
library(tidytext)
library(tibble)
library(dplyr)
Sys.getenv("R_LIBS_USER")

##Some text vector to work with

text <- c("Because I could not stop for Death -",
          "He kindly stopped for me -",
          "The Carriage held but just Ourselves -",
          "and Immortality")


##tibble to a dataframe 
text_df <- tibble(line = 1:4, text)

#pipe the tibble to unnest to tokenize and get a tibble out

text_df %>% 
  unnest_tokens(word, text, token = "words")
