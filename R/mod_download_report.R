#' Download Report Module UI
#'
#' @param id Module namespace
#' @return Shiny UI element
mod_download_report_ui <- function(id) {
  ns <- NS(id)
  card(
    card_body(
      strong("Download Report"),
      p("Generate an HTML report containing the current visualization and data table."),
      downloadButton(
        ns("download_report"),
        "Download HTML Report",
        class = "btn-primary"
      )
    )
  )
}

#' Download Report Module Server
#'
#' @param id Module namespace
#' @param plot_data List containing plot object
#' @param table_data Reactive filtered data
#' @param inputs List of reactive inputs from inputs module
#' @return None
mod_download_report_server <- function(id, plot_data, table_data, inputs) {
  moduleServer(id, function(input, output, session) {
    
    output$download_report <- downloadHandler(
      filename = function() {
        paste0("movies_report_", Sys.Date(), ".html")
      },
      content = function(file) {
        # Create a temporary directory for rendering
        temp_dir <- tempdir()
        
        # Get the path to the R Markdown template
        rmd_path <- system.file("rmd", "report.Rmd", package = ".")
        
        # If running in development, use relative path
        if (rmd_path == "" || !file.exists(rmd_path)) {
          rmd_path <- "inst/rmd/report.Rmd"
        }
        
        # Copy the RMD file to temp directory to avoid path issues
        temp_rmd <- file.path(temp_dir, "temp_report.Rmd")
        file.copy(rmd_path, temp_rmd, overwrite = TRUE)
        
        # Prepare data for the report
        params <- list(
          plot_obj = plot_data$plot(),
          x_var = inputs$x_var(),
          y_var = inputs$y_var(),
          data = table_data(),
          generated_on = Sys.time()
        )
        
        # Render the R Markdown report to temporary HTML file
        temp_html <- file.path(temp_dir, "temp_report.html")
        
        rmarkdown::render(
          input = temp_rmd,
          output_file = temp_html,
          output_format = rmarkdown::html_document(
            theme = "flatly",
            toc = TRUE,
            toc_float = TRUE
          ),
          params = params,
          envir = new.env(parent = globalenv()),
          quiet = TRUE
        )
        
        # Copy the rendered HTML to the final file location
        file.copy(temp_html, file, overwrite = TRUE)
        
        # Clean up temporary files
        unlink(c(temp_rmd, temp_html))
      },
      contentType = "text/html"
    )
  })
}