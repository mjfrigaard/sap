FROM rocker/shiny
RUN mkdir /home/shinyAppPkgsDockerCiCd
ADD . /home/shinyAppPkgsDockerCiCd
WORKDIR /home/shinyAppPkgsDockerCiCd
RUN R -e 'install.packages(c("bslib", "cli", "fst", "ggplot2", "ggplot2movies", "logger", "pkgload", "quarto", "ragg", "remotes", "rlang", "rsconnect", "sass", "shiny", "shinytest2", "shinythemes", "stringr", "thematic", "tidyr", "testthat", "tools", "waldo", "withr"))'
RUN R -e 'remotes::install_local(upgrade="never")'
EXPOSE 8180
CMD Rscript deploy.R