#' thematic leprechaun theme
#'
#' @returns bslib theme
#'
#' @export
#'
lap_theme <- bslib::bs_theme(
  bg = "#ffffff",
  fg = "#1a1a1a",
  primary = "#3C9D5D",   # green primary
  secondary = "#CCCCCC",
  success = "#3C9D5D",
  info = "#17A2B8",
  warning = "#F0AD4E",
  danger = "#D9534F",
  accent = "#6C757D",
  base_font = bslib::font_google("Ubuntu"),
  heading_font = bslib::font_google("Raleway")
)
