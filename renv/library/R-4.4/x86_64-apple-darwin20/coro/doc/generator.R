## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

options(cli.unicode = FALSE)

## -----------------------------------------------------------------------------
library(coro)

iterator <- as_iterator(1:3)

# Call the iterator to retrieve new values
iterator()

iterator()

## -----------------------------------------------------------------------------
# This is the last value
iterator()

# This is the exhaustion sentinel
iterator()

## -----------------------------------------------------------------------------
generate_abc <- generator(function() {
  for (x in letters[1:3]) {
    yield(x)
  }
})

## -----------------------------------------------------------------------------
# Create the iterator
abc <- generate_abc()

# Use the iterator by invoking it
abc()

abc()

## -----------------------------------------------------------------------------
# Last value
abc()

# Exhaustion sentinel
abc()

abc()

## -----------------------------------------------------------------------------
generate_natural_numbers <- generator(function(from = 1L) {
  x <- from
  repeat {
    yield(x)
    x <- x + 1L
  }
})

natural_numbers <- generate_natural_numbers(from = 10L)

# The iterator generates new numbers forever
natural_numbers()

natural_numbers()

## -----------------------------------------------------------------------------
abc <- generate_abc()

while (!is_exhausted(x <- abc())) {
  print(x)
}

## -----------------------------------------------------------------------------
abc <- generate_abc()

loop(for (x in abc) {
  print(x)
})

## -----------------------------------------------------------------------------
abc <- generate_abc()

collect(abc)

## -----------------------------------------------------------------------------
for (x in 1:3) {
  print(natural_numbers())
}

collect(natural_numbers, n = 3)

## -----------------------------------------------------------------------------
library(magrittr)

adapt_toupper <- generator(function(i) {
  for (x in i) {
    yield(toupper(x))
  }
})

ABC <- generate_abc() %>% adapt_toupper()

ABC()

ABC()

## -----------------------------------------------------------------------------
ABC()

ABC()

## -----------------------------------------------------------------------------
abc <- generate_abc()
ABC <- gen(for (x in abc) yield(toupper(x)))

collect(ABC)

## -----------------------------------------------------------------------------
adapt_map <- generator(function(.i, .fn, ...) {
  for (x in .i) {
    yield(.fn(x, ...))
  }
})

ABC <- generate_abc() %>% adapt_map(toupper)

ABC()

