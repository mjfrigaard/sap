#' Text logo
#' 
#' @param size header size ("h1", "h2", "h3", "h4", "h5", "h6")
#'
#' @return HTML text logo
#' 
#' @export
#'
#' @examples
#' text_logo()
text_logo <- function(size = 'h3') {
  if (any(size %in% c("h1", "h2", "h3", "h4", "h5", "h6"))) {
  HTML(
    paste0(
    "<div>\n", 
      paste0("  <", size, ">", collapse = ""), "\n",
      "    <code>√\\/--‹(•_•)›--√\\/</code>\n", 
      paste0("  <", size, "/>", collapse = ""), "\n",
    "</div>\n"
      )
    )
  } else {
    rlang::abort(paste(size, "isnt supported", sep = " "))
  }
}

#' Super text logo
#' 
#' @param size header size ("h1", "h2", "h3", "h4", "h5", "h6")
#'
#' @return HTML text logo
#' 
#' @export
#'
#' @examples
#' super_text_logo()
super_text_logo <- function() {
  HTML(
    paste0(
    "<pre>\n", 
       "
                                              8\"\"\"\"8                
           eeeeeee eeeee ee   e e  eeee eeeee 8    8 eeeee eeeee    
           8  8  8 8  88 88   8 8  8    8   \" 8eeee8 8   8 8   8    
           8e 8  8 8   8 88  e8 8e 8eee 8eeee 88   8 8eee8 8eee8    
           88 8  8 8   8  8  8  88 88      88 88   8 88    88       
           88 8  8 8eee8  8ee8  88 88ee 8ee88 88   8 88    88       
      ",
  "</pre>\n"
      )
    )
}