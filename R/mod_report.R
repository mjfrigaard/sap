#' Report download UI
#'
#' @param id Module ID
#'
#' @return UI elements for downloading report
#'
#' @export
mod_report_ui <- function(id) {
  ns <- NS(id)
  tagList(
    downloadButton(ns("download_report"), "Download Report")
  )
}
#' Generate and download R Markdown report
#'
#' @param id Module ID
#' @param scatter_values Scatter plot reactive values
#' @param count_values Count data reactive values
#' @param dist_values Distribution reactive values
#' @param award_values Awards reactive values
#'
#' @return None
#'
#' @export
mod_report_server <- function(id, scatter_values, count_values, dist_values, award_values) {
  
  moduleServer(id, function(input, output, session) {
    
    logr_msg("Initializing report download module", level = "INFO")
    
    output$download_report <- downloadHandler(
      filename = function() {
        paste("report-", Sys.Date(), ".html", sep = "")
      },
      content = function(file) {
        # create temp dir for report generation
        tempDir <- tempdir()
        tempReport <- file.path(tempDir, "report.Rmd")

        # copy report template to temp dir
        file.copy(system.file("rmd", "report_template.Rmd", package = "sap"),
          tempReport,
          overwrite = TRUE
        )

        # set up params
        logr_msg("Creating params", level = "INFO")
        params <- list(
          compare_values = scatter_values(),
          count_values = count_values(),
          dist_values = dist_values(),
          award_values = award_values()
        )
        # remove the symbols
        logr_msg("Cleaning params", level = "INFO")
        clean_params <- desym(params)

        tryCatch({
            # render the report
            rmarkdown::render(
              input = tempReport, 
              output_file = file,
              params = clean_params,
              envir = new.env(parent = globalenv()),
              quiet = FALSE 
            )
          
            logr_msg("Report generated successfully", level = "SUCCESS")
            showNotification(
              "Report generated successfully!",
              type = "message",
              duration = 5)
          },
          
          error = function(e) {
            message("Error in rmarkdown::render(): ", e$message)
            
            showNotification(
              paste("Error generating report with rmarkdown::render():", e$message),
              type = "error",
              duration = 10)
            })
        }
    )
  })
}
