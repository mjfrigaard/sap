# Build the macOS installer (.dmg). Run from the package root on a Mac.
# local_packages needs the development version of shinyelectron:
# pak::pak("coatless-rpkg/shinyelectron")
library(shinyelectron)

sitrep_shinyelectron()

# the .dmg builds only on macOS (bundled builds can't cross-build)
platform <- "mac"

app_check("electron/app", platform = platform)

# use absolute paths, and an empty user profile so the bundled R
# doesn't run ~/.Rprofile while it installs packages
withr::with_envvar(
  c(R_PROFILE_USER = tempfile(fileext = ".R")),
  export(
    appdir = file.path(getwd(), "electron/app"),
    destdir = file.path(getwd(), "electron/dist"),
    platform = platform,
    overwrite = TRUE,
    run_after = interactive()
  )
)
