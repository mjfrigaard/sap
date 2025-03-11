setAccountInfo(name = Sys.getenv("RSCONNECT_USER"),
               token = Sys.getenv("RSCONNECT_TOKEN"),
               secret = Sys.getenv("RSCONNECT_SECRET"))
deployApp(appDir = ".", 
  appName = "shinyAppPkgsDockerCiCd", 
  account = "mjfrigaard", 
    server = "shinyapps.io", 
    forceUpdate = TRUE)