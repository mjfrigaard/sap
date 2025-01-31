#' Package Startup Behavior (sap)
#' 
#' The [`.onAttach()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/ns-hooks.html) 
#' function is automatically executed when the `sap` package is attached using `library()` or
#' `require()`. This function generates a structured and styled startup 
#' message that includes:
#' 
#' - The package name and version.
#' - The current Git branch, if applicable.
#' - Dependencies listed in the package's `DESCRIPTION` file.
#' - The library path from which the package was loaded.
#'
#' @param libname *a character string giving the library directory where the package defining the namespace was found.*
#' @param pkgname *a character string giving the name of the package.*
#' 
#' @details
#' The function checks if the current working directory is part of a Git repository using 
#' `git rev-parse --is-inside-work-tree`. If a Git repository is detected, it retrieves the 
#' active branch name with `git rev-parse --abbrev-ref HEAD`. Errors during this process 
#' are handled gracefully.
#' Package dependencies, including `Imports`, `Suggests`, and `Depends`, are read from the 
#' `DESCRIPTION` file and formatted into a user-friendly list.
#' The function uses the [cli](https://cli.r-lib.org/) package to create a well-structured 
#' and styled startup message, enhancing the user experience with concise, informative output.
#'
#' @section **Startup Message Components**:
#' - **Package Name and Version**: Displays the name and version of the `sap` package.
#' - **Current Branch**: Displays the current Git branch or indicates the absence of a Git repository.
#' - **Dependencies**: Lists the `Imports`, `Suggests`, and `Depends` fields from the `DESCRIPTION` file.
#' - **Library Path**: Shows the path from which the package was loaded.
#'
#' @seealso
#' - [cli](https://cli.r-lib.org/): For creating styled messages.
#' - [git](https://git-scm.com/): For understanding Git commands used in this function.
#'
#' 
#' @keywords internal
#' 
#' @export
#' 
.onAttach <- function(libname, pkgname) {
  
  branch <- if (isTRUE(system("git rev-parse --is-inside-work-tree", intern = TRUE) == "true")) {
    tryCatch({
      system("git rev-parse --abbrev-ref HEAD", intern = TRUE)
    }, error = function(e) "unknown")
  } else {
    "not a Git repository"
  }


  version <- utils::packageVersion(pkgname)


  description <- utils::packageDescription(pkgname)
  imports <- description$Imports
  suggests <- description$Suggests
  depends <- description$Depends


  parse_dependencies <- function(dep_string) {
    if (is.null(dep_string)) return("None")
    deps <- strsplit(dep_string, ",\\s*")[[1]]
    paste(deps, collapse = ", ")
  }

  imports <- parse_dependencies(imports)
  suggests <- parse_dependencies(suggests)
  depends <- parse_dependencies(depends)

  
  cli::cli_inform("{.strong Welcome to the {.pkg {pkgname}} package (version {version}) {cli::symbol$smiley}!}", class = "packageStartupMessage")
  
  cli::cli_inform("{.strong Current branch:}", class = "packageStartupMessage")
  cli::cli_inform("{.emph {cli::symbol$pointer} {branch}}", class = "packageStartupMessage")

  cli::cli_inform("{.strong Dependencies:}", class = "packageStartupMessage")
  cli::cli_inform("{.emph {cli::symbol$pointer} Imports: {imports}}", class = "packageStartupMessage")
  cli::cli_inform("{.emph {cli::symbol$pointer} Suggests: {suggests}}", class = "packageStartupMessage")
  cli::cli_inform("{.emph {cli::symbol$pointer} Depends: {depends}}", class = "packageStartupMessage")

  cli::cli_inform("{.strong Loaded from:}", class = "packageStartupMessage")
  cli::cli_inform("{.emph {cli::symbol$pointer} {libname}}", class = "packageStartupMessage")

}
