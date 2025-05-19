#' Download report module (UI)
#'
#' @param id module id
#'
#' @return module UI
#'
#' @export
mod_report_download_ui <- function(id) {
  ns <- NS(id)
  tagList(
    downloadButton(
      ns("download_report"),
      "Download Report",
      class = "btn-primary btn-lg w-100",
      icon = icon("file-export")
    )
  )
}

#' Download report module (Server)
#'
#' @param id module id
#' @param compare_values reactive values from compare tab
#' @param count_values reactive values from counts tab
#' @param dist_values reactive values from distribution tab
#' @param award_values reactive values from awards tab
#'
#' @return downloaded report
#'
#' @export
mod_report_download_server <- function(id, compare_values, count_values,
                                       dist_values, award_values) {
                                       
  moduleServer(id, function(input, output, session) {
  
    logr_msg("Initializing report download module", level = "INFO")

      # Download handler
      output$download_report <- downloadHandler(
        filename = function() {
          paste0("movie-analysis-report-", format(Sys.time(), "%Y-%m-%d-%H%M%S"), ".html")
        },
        content = function(file) {
          # create params list ----
          params <- list()
          ## compare values ----
          cv <- compare_values()
          # extract variable names without symbols or expressions
          x_name <- extract_var_name(var_expr = cv$x)
          x_name <- name_case(x = gsub(".*\\$", "", as.character(cv$x)), case = "lower")
          y_name <- name_case(x = gsub(".*\\$", "", as.character(cv$y)), case = "lower")
          color_name <- name_case(x = gsub(".*\\$", "", as.character(cv$color)), case = "lower")
          # add to list
          params$compare_values <- list(
            x = x_name,
            y = y_name,
            color = color_name,
            # convert to proper format
            alpha = as.numeric(cv$alpha),
            size = as.numeric(cv$size),
            title = as.character(cv$title)
          )
          logr_msg(glue::glue("Compare vars: x={x_name}, y={y_name}, color={color_name}"),
            level = "INFO"
          )

          ## count values ----
          cv <- count_values()
          # extract variable name without symbols or expressions
          chr_name <- name_case(x = gsub(".*\\$", "", as.character(cv$chr_var)), case = "lower")
          # add to list
          params$count_values <- list(
            chr_var = chr_name,
            start_year = as.integer(cv$start_year),
            end_year = as.integer(cv$end_year)
          )
          logr_msg(glue::glue("Counts vars: {chr_name}, years: {cv$start_year}-{cv$end_year}"),
            level = "INFO"
          )

          ## dist values ----
          dv <- dist_values()
          chr_name <- name_case(x = gsub(".*\\$", "", as.character(dv$chr_var)), case = "lower")
          num_name <- name_case(x = gsub(".*\\$", "", as.character(dv$num_var)), case = "lower")
          # add to list
          params$dist_values <- list(
            chr_var = chr_name,
            num_var = num_name,
            alpha = as.numeric(dv$alpha),
            size = as.numeric(dv$size)
          )
          logr_msg(glue::glue("Distribution vars: {chr_name}, {num_name}"),
            level = "INFO"
          )

          ## award values ----
          av <- award_values()
          # add to list
          params$award_values <- list(
            award = av$award,
            year = as.integer(av$year)
          )
          logr_msg(glue::glue("Awards: {av$award}, year: {av$year}"),
            level = "INFO"
          )
          logr_msg("Starting report generation with params:", level = "INFO")

          # Create a temporary directory for report generation
          report_dir <- tempdir()
          rmd_path <- file.path(report_dir, "report.Rmd")

          # Copy the report template to the temporary directory
          template_path <- system.file("rmd", "report_template.Rmd", package = "sap")

          file.copy(
            from = template_path,
            to = rmd_path,
            overwrite = TRUE
          )

          tryCatch({
              # Render the report
              rmarkdown::render(
                input = rmd_path,
                output_file = file,
                output_format = "html_document",
                clean = TRUE,
                runtime = "static",
                params = params,
                envir = new.env(parent = globalenv()),
                quiet = FALSE # Change to TRUE in production
              )

              logr_msg("Report generated successfully", level = "SUCCESS")
              
              showNotification(
                "Report generated successfully!",
                type = "message",
                duration = 5
              )
              
            },
            error = function(e) {
              message("Error in rmarkdown::render(): ", e$message)
              showNotification(
                paste("Error generating report with rmarkdown::render():", e$message),
                type = "error",
                duration = 10
              )
              
            })
        })
  })
}