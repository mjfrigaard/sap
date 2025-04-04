#' Shiny UI
#'
#' Core UI of package.
#'
#' @param req The request object.
#'
#' @import shiny
#' @importFrom bslib bs_theme
#'
#' @keywords internal
ui <- function(req){
  tagList(
      bslib::page_fillable(
        list(assets()),
        title = "Movie Reviews (lap)",
        theme = lap_theme,
        bslib::layout_sidebar(
          sidebar = bslib::sidebar(
            varsUI("vars"),
            aesUI("aes")
          ),
          bslib::card(
            full_screen = TRUE,
          bslib::card_header(
            tags$h4(tags$em("Brought to you by ",
                tags$img(
                  src = "img/leprechaun-logo.png",
                  height = 100,
                  width = 100,
                  style = "margin:10px 10px"
                  )
                )
              )
            ),
            bslib::card_body(
              scatter_displayUI("plot")
            )
          )
        )
      )
  )
}

#' Assets
#'
#' Includes all assets.
#' This is a convenience function that wraps
#' [serveAssets] and allows easily adding additional
#' remote dependencies (e.g.: CDN) should there be any.
#'
#' @param ignore A vector of files to ignore.
#' This can be useful for scripts that should not be
#' placed in the `<head>` of the HTML.
#'
#' @importFrom shiny tags
#'
#' @keywords internal
assets <- function(ignore = NULL){
	list(
		serveAssets(ignore = ignore), # base assets (assets.R)
		tags$head(
			# Place any additional depdendencies here
			# e.g.: CDN
		)
	)
}
