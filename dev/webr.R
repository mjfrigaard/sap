# Export the shinylive app in inst/webr/ to a static site in _site/
# sap must be installed from R-universe first:
# install.packages("sap", repos = c("https://mjfrigaard.r-universe.dev", getOption("repos")))
shinylive::export(appdir = "inst/webr", destdir = "_site")

# Preview the static site locally
httpuv::runStaticServer("_site")
