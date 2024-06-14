// Custom JavaScript functions for the Shiny application

// Function to initialize tooltips
$(document).ready(function() {
  $('[data-toggle="tooltip"]').tooltip();
  
  // Example custom event handler
  $('#scatter_inputs').on('change', function() {
    console.log('Scatter plot inputs changed.');
    // Add any additional custom behavior here
  });
  
  // Function to highlight a row in the table on click
  $('#year_table').on('click', 'tr', function() {
    $(this).toggleClass('highlight');
  });
  
  // Any additional custom JavaScript code
});

// Function to dynamically update the plot title based on input
Shiny.addCustomMessageHandler('updatePlotTitle', function(message) {
  $('#scatter .plot-title').text(message);
});
