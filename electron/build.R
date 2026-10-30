# Build the desktop app. Run from the package root.
library(shinyelectron)

sitrep_shinyelectron()

app_check("electron/app")

export(
  appdir = "electron/app",
  destdir = "electron/dist",
  overwrite = TRUE,
  run_after = interactive()
)
