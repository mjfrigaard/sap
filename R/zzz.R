#' Package Startup Behavior (sap)
#' 
#' The [`.onAttach()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/ns-hooks.html) 
#' function is automatically executed when the `sap` package is attached using `library()` or
#' `require()`. 
#'
#' @param libname *a character string giving the library directory where the package defining the namespace was found.*
#' @param pkgname *a character string giving the name of the package.*
#' 
#' @keywords internal
#' 
#' @export
#' 
#.onAttach <- function(libname, pkgname) {
  # pkg_startup_msg(libname, pkgname)
#}

