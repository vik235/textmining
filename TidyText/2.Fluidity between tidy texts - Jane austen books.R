##' unnest_tokens : A simple tokenizer that transforms the tokens into
##' tidy text format
## 

##Get the packages we need
##install.packages("janeaustenr")
##install.packages("tibble")
##install.packages("dplyr")
##install.packages("tidytext")
library(tidytext)
library(tibble)
library(dplyr)
library(janeaustenr)
library(stringr)
library(ggplot2)

original_books <- austen_books() %>%
  group_by(book) %>%
  mutate(linenumber = row_number(),
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]",
                                                 ignore_case = TRUE)))) %>%
  ungroup()


tidy_books <-
    original_books %>% unnest_tokens(word, text)


tidy_books <- tidy_books %>% anti_join(stop_words)
tidy_books %>% count(word , sort = TRUE)


tidy_books %>%
  count(word, sort = TRUE) %>%
  filter(n > 600) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()
