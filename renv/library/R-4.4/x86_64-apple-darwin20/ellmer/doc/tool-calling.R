## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = ellmer:::openai_key_exists()
)

## ----setup--------------------------------------------------------------------
library(ellmer)

## ----eval=FALSE---------------------------------------------------------------
# chat <- chat_openai(model = "gpt-4o")
# chat$chat("How long ago exactly was the moment Neil Armstrong touched down on the moon?")
# #> Neil Armstrong touched down on the moon on July 20, 1969, at 20:17 UTC. To determine how long ago that
# #> was from the current year of 2023, we can calculate the difference in years, months, and days.
# #>
# #> From July 20, 1969, to July 20, 2023, is exactly 54 years. If today's date is after July 20, 2023, you
# #> would add the additional time since then. If it is before, you would consider slightly less than 54
# #> years.
# #>
# #> As of right now, can you confirm the current date so we can calculate the precise duration?

## -----------------------------------------------------------------------------
#' Gets the current time in the given time zone.
#'
#' @param tz The time zone to get the current time in.
#' @return The current time in the given time zone.
get_current_time <- function(tz = "UTC") {
  format(Sys.time(), tz = tz, usetz = TRUE)
}

## ----eval=FALSE---------------------------------------------------------------
# get_current_time()
# #> [1] "2024-09-18 17:47:14 UTC"

## -----------------------------------------------------------------------------
chat <- chat_openai(model = "gpt-4o")

chat$register_tool(tool(
  get_current_time,
  "Gets the current time in the given time zone.",
  tz = type_string(
    "The time zone to get the current time in. Defaults to `\"UTC\"`.",
    required = FALSE
  )
))

## ----eval=FALSE---------------------------------------------------------------
# chat$chat("How long ago exactly was the moment Neil Armstrong touched down on the moon?")
# #> Neil Armstrong touched down on the moon on July 20, 1969, at 20:17 UTC.
# #>
# #> To calculate the time elapsed from that moment until the current time (September 18, 2024, 17:47:19
# #> UTC), we need to break it down.
# #>
# #> 1. From July 20, 1969, 20:17 UTC to July 20, 2024, 20:17 UTC is exactly 55 years.
# #> 2. From July 20, 2024, 20:17 UTC to September 18, 2024, 17:47:19 UTC, we need to further break down:
# #>
# #>    - From July 20, 2024, 20:17 UTC to September 18, 2024, 17:47:19 UTC, which is:
# #>      - 1 full month (August)
# #>      - 30 – 20 = 10 days of July
# #>      - 18 days of September until 17:47:19 UTC
# #>
# #> So, in detail:
# #>    - 55 years
# #>    - 1 month
# #>    - 28 days
# #>    - From July 20, 2024, 20:17 UTC to July 20, 2024, 17:47:19 UTC: 23 hours, 30 minutes, and 19 seconds
# #>
# #> Time Total:
# #> - 55 years
# #> - 1 month
# #> - 28 days
# #> - 23 hours
# #> - 30 minutes
# #> - 19 seconds
# #>
# #> This is the exact time that has elapsed since Neil Armstrong's historic touchdown on the moon.

