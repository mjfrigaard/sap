# Build the macOS installer (.dmg). Run from the package root on a Mac.
# local_packages needs the development version of shinyelectron:
# pak::pak("coatless-rpkg/shinyelectron")
library(shinyelectron)

sitrep_shinyelectron()

# the .dmg builds only on macOS (bundled builds can't cross-build)
platform <- "mac"

app_check("electron/app", platform = platform)

# use absolute paths
export(
  appdir = file.path(getwd(), "electron/app"),
  destdir = file.path(getwd(), "electron/dist"),
  platform = platform,
  overwrite = TRUE,
  run_after = interactive()
)
