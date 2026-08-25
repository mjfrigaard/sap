local({
  # macOS fix: fstcore.so (used by the "ggp2" app) needs libomp's symbols
  # exposed in the flat namespace, but dyn.load()'s default RTLD_LOCAL
  # keeps them private. Preloading R's own libomp.dylib with local = FALSE
  # exposes them globally so fstcore loads correctly.
  if (Sys.info()[["sysname"]] == "Darwin") {
    libomp <- file.path(R.home("lib"), "libomp.dylib")
    if (file.exists(libomp) && !"libomp.dylib" %in% names(getLoadedDLLs())) {
      try(dyn.load(libomp, local = FALSE), silent = TRUE)
    }
  }
})
