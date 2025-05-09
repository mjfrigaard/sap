#' Download R Markdown Report (UI)
#'
#' @param id 
#'
#' @returns download button for report
#' 
#' @export
#'
mod_report_download_ui <- function(id) {
  ns <- NS(id)
  tagList(
    downloadButton(
      ns("download_report"),
      "Download Report",
      class = "btn-primary btn-lg w-100",
      icon = icon("file")
    ),
    tags$div(
      class = "pt-2",
      checkboxInput(
        ns("include_compare"), 
        "Include Compare", 
        value = TRUE
      ),
      checkboxInput(
        ns("include_counts"), 
        "Include Counts", 
        value = TRUE
      ),
      checkboxInput(
        ns("include_distribution"), 
        "Include Distribution", 
        value = TRUE
      ),
      checkboxInput(
        ns("include_awards"), 
        "Include Awards", 
        value = TRUE
      )
    )
  )
}

#' Download R Markdown Report (server)
#'
#' @param id 
#'
#' @returns download button for report
#' 
#' @export
#'
mod_report_download_server <- function(id, compare_values, count_values,
                                      dist_values, award_values) {
  
  moduleServer(id, function(input, output, session) {
    
    logr_msg("Initializing report download module", 
      level = "INFO")
    
    # create reactive report parameters
    report_params <- reactive({
      # Start with empty list
      params <- list()
      
      # Only include values if the checkbox is checked
      if (input$include_compare) {
        params$compare_values <- compare_values()
        logr_msg("Including compare values in report", level = "DEBUG")
      }
      
      if (input$include_counts) {
        params$count_values <- count_values()
        logr_msg("Including count values in report", level = "DEBUG")
      }
      
      if (input$include_distribution) {
        params$dist_values <- dist_values()
        logr_msg("Including distribution values in report", level = "DEBUG")
      }
      
      if (input$include_awards) {
        params$award_values <- award_values()
        logr_msg("Including award values in report", level = "DEBUG")
      }
      
      return(params)
    })
    
    # download handler
    output$download_report <- downloadHandler(
      filename = function() {
        paste0("movie-analysis-report-", format(Sys.Date(), "%Y-%m-%d"), ".html")
      },
      content = function(file) {
        params <- report_params()
        
        # show notification while report generates
        id <- showNotification(
          "Generating report...", 
          duration = NULL, 
          closeButton = FALSE,
          type = "message"
        )
        on.exit(removeNotification(id), add = TRUE)
        
        logr_msg("Starting report generation", 
          level = "INFO")
        
        # create temp dir for report generation
        report_dir <- tempdir()
        rmd_path <- file.path(report_dir, "report.Rmd")
        
        # copy report template to temp dir
        file.copy(
          from = system.file("rmd", "report_template.Rmd", package = "sap"),
          to = rmd_path,
          overwrite = TRUE
        )
        
        # Create a temporary debug file
        debug_file <- file.path(report_dir, "report_debug.txt")
        cat("Parameter structure:\n\n", file = debug_file)
        capture.output(str(params), file = debug_file, append = TRUE)
        
        # Setup the environment with the helper functions
        render_env <- new.env(parent = globalenv())
        render_env$get_column_name <- get_column_name
        render_env$create_compare_plot <- create_compare_plot
        
        tryCatch({
          # render the report
          rmarkdown::render(
            input = rmd_path,
            output_file = file,
            params = params,
            envir = render_env,
            quiet = FALSE  # Show output for debugging
          )
          
          logr_msg("Report generated successfully", 
            level = "SUCCESS")
          
        }, error = function(e) {
          
          error_msg <- e$message
          logr_msg(glue::glue("Error generating report: {error_msg}"),
            level = "ERROR")
          
          # Add debug info to the notification
          showNotification(
            HTML(paste0(
              "Error generating report: ", error_msg,
              "<br>Debug info saved to: ", debug_file
            )), 
            type = "error",
            duration = 30
          )
          
        })
      }
    )
  })
}