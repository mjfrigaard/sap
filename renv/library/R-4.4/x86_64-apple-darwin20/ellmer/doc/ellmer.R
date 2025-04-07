## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  eval = ellmer:::openai_key_exists(),
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ellmer)

## -----------------------------------------------------------------------------
chat <- chat_openai(model = "gpt-4o")
. <- chat$chat("Who created R?", echo = FALSE)
chat

token_usage()

