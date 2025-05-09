mod_qmd_report_download_ui <- function(id) {
  ns <- NS(id)
  tagList(
    downloadButton(
      ns("download_report"),
      "Download HTML Report",
      class = "btn-primary btn-lg w-100",
      icon = icon("file-code")  
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
      ),
      # add option for interactive plots in HTML
      checkboxInput(
        ns("interactive_plots"),
        "Interactive Plots", 
        value = TRUE
      )
    )
  )
}

mod_qmd_report_download_server <- function(id, compare_values, count_values,
                                      dist_values, award_values) {
  moduleServer(id, function(input, output, session) {
    
    logr_msg("Initializing report download module", level = "INFO")
    
    # Create reactive report parameters
    report_params <- reactive({
      list(
        include_compare = input$include_compare,
        include_counts = input$include_counts,
        include_distribution = input$include_distribution,
        include_awards = input$include_awards,
        interactive_plots = input$interactive_plots,
        compare_values = if (input$include_compare) compare_values() else NULL,
        count_values = if (input$include_counts) count_values() else NULL,
        dist_values = if (input$include_distribution) dist_values() else NULL,
        award_values = if (input$include_awards) award_values() else NULL
      )
    })
    
    # Download handler
    output$download_report <- downloadHandler(
      filename = function() {
        paste0("movie-analysis-report-", format(Sys.time(), "%Y-%m-%d-%H%M%S"), ".html")
      },
      content = function(file) {
        params <- report_params()
        
        # Show a notification while the report is generating
        id <- showNotification(
          "Generating HTML report...", 
          duration = NULL, 
          closeButton = FALSE,
          type = "message"
        )
        on.exit(removeNotification(id), add = TRUE)
        
        logr_msg("Starting HTML report generation with Quarto", level = "INFO")
        
        # Check if Quarto is available
        if (!ensure_quarto()) {
          showNotification(
            "Quarto not found. Please install Quarto to generate HTML reports.", 
            type = "error",
            duration = 10
          )
          return()
        }
        
        # Create a temporary directory for report generation
        report_dir <- tempdir()
        qmd_path <- file.path(report_dir, "report.qmd")
        
        # Copy the Quarto template to the temporary directory
        file.copy(
          from = system.file("qmd", "report_template.qmd", package = "sap"),
          to = qmd_path,
          overwrite = TRUE
        )
        
        tryCatch({
          # Render with Quarto
          quarto::quarto_render(
            input = qmd_path,
            output_file = file,
            execute_params = params
          )
          
          logr_msg("HTML report generated successfully", level = "SUCCESS")
        }, error = function(e) {
          logr_msg(glue::glue("Error generating HTML report: {e$message}"), level = "ERROR")
          showNotification(
            "Error generating report. Please try again.", 
            type = "error"
          )
        })
      }
    )
  })
}