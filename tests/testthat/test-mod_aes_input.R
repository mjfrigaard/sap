
test_that("mod_aes_input_ui creates UI elements correctly", {
  ui <- mod_aes_input_ui("test")
  expect_true("shiny.tag.list" %in% class(ui))
  expect_length(ui, 5)  
})