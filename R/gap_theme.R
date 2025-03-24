#' thematic golem theme
#'
#' @returns bslib theme
#'
#' @export
#'
gap_theme <- bslib::bs_theme(
  bg = "white",
  fg = "black",
  accent = "#F28E2B",
  bootswatch = "united", # optional (choose a bootstrap theme)
  primary = "#482878",
  secondary = "#F28E2B",
  success = "#59A14F",
  info = "#4E79A7",
  warning = "#F28E2B",
  danger = "#E15759",
  base_font = bslib::font_google("Ubuntu"),
  heading_font = bslib::font_google("Raleway")
)
