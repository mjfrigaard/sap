# Build the Linux installers (.AppImage and .deb). Run from the package root on Linux.
# Needs Node.js >= 22 and npm >= 11.5 (shinyelectron::install_nodejs()).
# The shinylive runtime needs the WebAssembly binary of sap from R-universe:
# install.packages("sap", repos = c("https://mjfrigaard.r-universe.dev", getOption("repos")))
library(shinyelectron)

sitrep_shinyelectron()

app_check("electron/app", platform = "linux")

# use absolute paths; this builds the .AppImage and the Electron project
export(
  appdir = file.path(getwd(), "electron/app"),
  destdir = file.path(getwd(), "electron/dist"),
  platform = "linux",
  overwrite = TRUE
)

# shinyelectron only targets AppImage on Linux, so add the .deb target
# (electron-builder requires a homepage and maintainer for .deb files)
electron_app <- file.path(getwd(), "electron/dist/electron-app")
pkg_json <- file.path(electron_app, "package.json")
pkg <- jsonlite::read_json(pkg_json)
pkg$homepage <- "https://github.com/mjfrigaard/sap"
pkg$build$linux$target <- list("AppImage", "deb")
pkg$build$linux$maintainer <- "Martin Frigaard <mjfrigaard@pm.me>"
jsonlite::write_json(pkg, pkg_json, auto_unbox = TRUE, pretty = TRUE)

# use the Node.js from install_nodejs(), not the system Node.js
node_bin <- utils::tail(Sys.glob(file.path(
  rappdirs::user_cache_dir("shinyelectron"), "assets/nodejs/*/linux-x64/bin"
)), 1)

withr::with_path(node_bin, withr::with_dir(
  electron_app,
  system2("npx", c("electron-builder", "--linux", "deb", "--publish", "never"))
))
