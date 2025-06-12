# usethis package ----
if (interactive()) {
  require(usethis, quietly = TRUE)
}
# pak package ----
if (interactive()) {
  require(pak, quietly = TRUE)
}
# ellmer llm package ----
if (interactive()) {
  require(ellmer, quietly = TRUE)
}
options(
  ## gander config ----
  .gander_chat = ellmer::chat_anthropic(),
  # printing configs ----
  width = 50L,
  pillar.width = 50L,
  width = 80,
  str = utils::strOptions(strict.width = 'cut'),
# repos configs ----
    repos = c(pm = "https://packagemanager.posit.co/cran/latest",
            CRAN = "https://cloud.r-project.org")
)
### clean_vignettes ----
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
if (interactive()) {
  clean_vignettes()
}
