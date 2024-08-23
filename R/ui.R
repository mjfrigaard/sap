#' Shiny UI
#'
#' Core UI of package.
#'
#' @param req The request object.
#'
#'
#' @keywords internal
ui <- function(req) {
  fluidPage(
    theme = bslib::bs_theme(version = 5),
    assets(),
    h1("lap"),
    ## New code -->
        sidebarLayout(
          sidebarPanel(
            var_inputUI("vars")
          ),
          mainPanel(
          # new image
          tags$img(
            src = "img/leprechaun.jpg",
            height="25%",
            width="25%"),
          plot_displayUI("plot")
          )
        )
    ## New code <--
  )
}

#' Assets
#'
#' Includes all assets.
#' This is a convenience function that wraps
#' [serveAssets] and allows easily adding additional
#' remote dependencies (e.g.: CDN) should there be any.
#'
#'
#' @keywords internal
assets <- function(){
	list(
		serveAssets(), # base assets (assets.R)
		tags$head(
			# Place any additional dependencies here
			# e.g.: CDN
		)
	)
}
