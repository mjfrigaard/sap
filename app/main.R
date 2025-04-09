# app/main.R

# shiny functions
box::use(
  shiny[
    NS, span, tags, icon, moduleServer
  ],
  # bslib functions
  bslib[
    page_fillable, layout_sidebar, sidebar, 
    card, card_header, card_body, bs_theme
  ]
)

# import modules ----
box::use(
  ## load inputs module
  app / view / var_inputs,
  app / view / aes_inputs,
  ## load display module 
  app / view / display,
  ## load clicks module 
  app / view / clicks,
  ## load message module 
  app / view / message
)

#' rap ui
#' @export
ui <- function(id) {
  ns <- NS(id)
  page_fillable(
    # theme
    theme = bs_theme(
        bg = "#202123", 
        fg = "#B8BCC2",
        # accent colors (e.g., hyperlink, button, etc)
        primary = "#EA80FC", 
        secondary = "#48DAC6",
        # fonts
        base_font = c("Proxima Nova", "sans-serif"),
        code_font = c("Hack", "monospace"),
        heading_font = c("Optima", "sans-serif")
    ),
    layout_sidebar(
      sidebar = sidebar(
        # input modules 
        var_inputs$ui(ns("vals")),
        aes_inputs$ui(ns("aes"))
        ),
        card(
          full_screen = TRUE,
          card_header(
            tags$button(id = "help-button",
              icon("info"),
              # add 'onclick' after rhino::build_sass()
              # and rhino::build_js()
              onclick = "App.showHelp()"),
              
              
        ),
        card_body(
            span(
              # use clicks 
              clicks$ui(ns("clicks")),
              # use message 
              message$ui(ns("message")),
            ),
            display$ui(ns("disp"))
          )
        )
      )
    )
}

#' rap server
#' @export
server <- function(id) {
  
  moduleServer(id, function(input, output, session) {
    
    # collect variable inputs module server ----
    selected_vars <- var_inputs$server(id = "vals")
    # collect aesthetic inputs module server ----
    selected_aes <- aes_inputs$server(id = "aes")
    
    # pass to display module server ----
    display$server(
      id = "disp",
      var_inputs = selected_vars,
      aes_inputs = selected_aes
    )
  })
  
  moduleServer(id, function(input, output, session) {
    clicks$server("clicks")
    message$server("message")
  })
  
}
