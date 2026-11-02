# Build the desktop app. Run from the package root.
# local_packages needs the development version of shinyelectron:
# pak::pak("coatless-rpkg/shinyelectron")
library(shinyelectron)

sitrep_shinyelectron()

# build only for the current platform (bundled builds can't cross-build)
platform <- switch(Sys.info()[["sysname"]], Darwin = "mac", Windows = "win")

app_check("electron/app", platform = platform)

# use absolute paths
export(
  appdir = file.path(getwd(), "electron/app"),
  destdir = file.path(getwd(), "electron/dist"),
  platform = platform,
  overwrite = TRUE,
  run_after = interactive()
)
