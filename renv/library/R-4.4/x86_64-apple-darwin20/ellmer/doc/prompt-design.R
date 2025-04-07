## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = ellmer:::openai_key_exists() && ellmer:::anthropic_key_exists(),
  cache = TRUE
)
options(ellmer_seed = 1337)

# Manually ratchet claude variability way down to hopefully make generated
# code better match my prose.
chat_claude <- function(...) {
  ellmer::chat_claude(..., api_args = list(temperature = 0))
}

## ----setup--------------------------------------------------------------------
library(ellmer)

## -----------------------------------------------------------------------------
question <- "
  How can I compute the mean and median of variables a, b, c, and so on,
  all the way up to z, grouped by age and sex.
"

## -----------------------------------------------------------------------------
chat <- chat_claude()
chat$chat(question)

## -----------------------------------------------------------------------------
chat <- chat_claude(system_prompt = "
  You are an expert R programmer who prefers the tidyverse.
")
chat$chat(question)

## -----------------------------------------------------------------------------
chat <- chat_claude(system_prompt = "
  You are an expert R programmer who prefers the tidyverse.
  Just give me the code. I don't want any explanation or sample data.
")
chat$chat(question)

## -----------------------------------------------------------------------------
chat <- chat_claude(system_prompt = "
  You are an expert R programmer who prefers data.table.
  Just give me the code. I don't want any explanation or sample data.
")
chat$chat(question)

chat <- chat_claude(system_prompt = "
  You are an expert R programmer who prefers base R.
  Just give me the code. I don't want any explanation or sample data.
")
chat$chat(question)

## -----------------------------------------------------------------------------
chat <- chat_claude(system_prompt = "
  You are an expert R programmer who prefers the tidyverse.
  Just give me the code. I don't want any explanation or sample data.

  Follow the tidyverse style guide:
  * Spread long function calls across multiple lines.
  * Where needed, always indent function calls with two spaces.
  * Only name arguments that are less commonly used.
  * Always use double quotes for strings.
  * Use the base pipe, `|>`, not the magrittr pipe `%>%`.
")
chat$chat(question)

## -----------------------------------------------------------------------------
chat <- chat_claude(system_prompt = "
  You are an expert R teacher.
  I am a new R user who wants to improve my programming skills.
  Help me understand the code you produce by explaining each function call with
  a brief comment. For more complicated calls, add documentation to each
  argument. Just give me the code. I don't want any explanation or sample data.
")
chat$chat(question)

## -----------------------------------------------------------------------------
chat <- chat_claude(system_prompt = "
  You are an expert R programmer.
  Just give me the code; no explanation in text.
  Use the `.by` argument rather than `group_by()`.
  dplyr 1.1.0 introduced per-operation grouping with the `.by` argument.
  e.g., instead of:

  transactions |>
    group_by(company, year) |>
    mutate(total = sum(revenue))

  write this:
  transactions |>
    mutate(
      total = sum(revenue),
      .by = c(company, year)
    )
")
chat$chat(question)

## -----------------------------------------------------------------------------
ingredients <- "
  ¾ cup (150g) dark brown sugar
  2 large eggs
  ¾ cup (165g) sour cream
  ½ cup (113g) unsalted butter, melted
  1 teaspoon vanilla extract
  ¾ teaspoon kosher salt
  ⅓ cup (80ml) neutral oil
  1½ cups (190g) all-purpose flour
  150g plus 1½ teaspoons sugar
"

## -----------------------------------------------------------------------------
instruct_json <- "
  You're an expert baker who also loves JSON. I am going to give you a list of
  ingredients and your job is to return nicely structured JSON. Just return the
  JSON and no other commentary.
"

chat <- chat_openai(instruct_json)
chat$chat(ingredients)

## -----------------------------------------------------------------------------
instruct_weight <- r"(
  Here are some examples of the sort of output I'm looking for:

  ¾ cup (150g) dark brown sugar
  {"name": "dark brown sugar", "quantity": 150, "unit": "g"}

  ⅓ cup (80ml) neutral oil
  {"name": "neutral oil", "quantity": 80, "unit": "ml"}

  2 t ground cinnamon
  {"name": "ground cinnamon", "quantity": 2, "unit": "teaspoon"}
)"

chat <- chat_openai(c(instruct_json, instruct_weight))
chat$chat(ingredients)

## -----------------------------------------------------------------------------
instruct_weight <- r"(
  * If an ingredient has both weight and volume, extract only the weight:

  ¾ cup (150g) dark brown sugar
  [
    {"name": "dark brown sugar", "quantity": 150, "unit": "g"}
  ]

* If an ingredient only lists a volume, extract that.

  2 t ground cinnamon
  ⅓ cup (80ml) neutral oil
  [
    {"name": "ground cinnamon", "quantity": 2, "unit": "teaspoon"},
    {"name": "neutral oil", "quantity": 80, "unit": "ml"}
  ]
)"

## -----------------------------------------------------------------------------
instruct_unit <- r"(
* If the unit uses a fraction, convert it to a decimal.

  ⅓ cup sugar
  ½ teaspoon salt
  [
    {"name": "dark brown sugar", "quantity": 0.33, "unit": "cup"},
    {"name": "salt", "quantity": 0.5, "unit": "teaspoon"}
  ]

* Quantities are always numbers

  pinch of kosher salt
  [
    {"name": "kosher salt", "quantity": 1, "unit": "pinch"}
  ]

* Some ingredients don't have a unit.
  2 eggs
  1 lime
  1 apple
  [
    {"name": "egg", "quantity": 2},
    {"name": "lime", "quantity": 1},
    {"name", "apple", "quantity": 1}
  ]
)"

## -----------------------------------------------------------------------------
type_ingredient <- type_object(
  name = type_string("Ingredient name"),
  quantity = type_number(),
  unit = type_string("Unit of measurement")
)

type_ingredients <- type_array(items = type_ingredient)

chat <- chat_openai(c(instruct_json, instruct_weight))
data <- chat$extract_data(ingredients, type = type_object(ingredients = type_ingredients))
do.call(rbind, lapply(data$ingredients, as.data.frame))

## -----------------------------------------------------------------------------
instruct_weight_input <- r"(
  * If an ingredient has both weight and volume, extract only the weight:

    ¾ cup (150g) dark brown sugar
    [
      {"name": "dark brown sugar", "quantity": 150, "unit": "g", "input": "¾ cup (150g) dark brown sugar"}
    ]

  * If an ingredient only lists a volume, extract that.

    2 t ground cinnamon
    ⅓ cup (80ml) neutral oil
    [
      {"name": "ground cinnamon", "quantity": 2, "unit": "teaspoon", "input": "2 t ground cinnamon"},
      {"name": "neutral oil", "quantity": 80, "unit": "ml", "input": "⅓ cup (80ml) neutral oil"}
    ]
)"

## -----------------------------------------------------------------------------
recipe <- r"(
  In a large bowl, cream together one cup of softened unsalted butter and a
  quarter cup of white sugar until smooth. Beat in an egg and 1 teaspoon of
  vanilla extract. Gradually stir in 2 cups of all-purpose flour until the
  dough forms. Finally, fold in 1 cup of semisweet chocolate chips. Drop
  spoonfuls of dough onto an ungreased baking sheet and bake at 350°F (175°C)
  for 10-12 minutes, or until the edges are lightly browned. Let the cookies
  cool on the baking sheet for a few minutes before transferring to a wire
  rack to cool completely. Enjoy!
)"

## -----------------------------------------------------------------------------
chat <- chat_openai(c(instruct_json, instruct_weight_input))
chat$chat(recipe)

## -----------------------------------------------------------------------------
knitr::kable(token_usage())

