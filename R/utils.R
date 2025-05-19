#' Create report directory if it doesn't exist
#'
#' @returns directory
#' 
#' @export
#'
create_template_dir <- function() {
  pkg_dir <- find.package("sap")
  rmd_dir <- file.path(pkg_dir, "inst", "rmd")
  if (!dir.exists(rmd_dir)) {
    dir.create(rmd_dir, recursive = TRUE, showWarnings = FALSE)
  }
  rmd_dir
}

#' Save report template to the proper location
#'
#' @param template_content output from `create_template_dir()`
#'
#' @returns message regarding template creation
#' 
#' @export
#'
save_template <- function(template_content) {
  rmd_dir <- create_template_dir()
  template_path <- file.path(rmd_dir, "report_template.Rmd")
  writeLines(template_content, template_path)
  message("Template saved to ", template_path)
}