if (interactive()) {
  require(usethis, quietly = TRUE)
}

clean_vignettes <- function(pth = "vignettes/") {
  # all HTML files/folders ending with "_files"
  files_to_delete <- list.files(
    path = pth, 
    pattern = "\\.html$|_files$", 
    full.names = TRUE
  )
  # print the delete message
  for (file in files_to_delete) {
    file_name <- basename(file)
    directory <- dirname(file)
    message(sprintf("deleting '%s' from '%s'", file_name, directory))
  }
  # delete 
  unlink(files_to_delete, recursive = TRUE)
  # return
  return(invisible())
  
}
# run 
clean_vignettes()