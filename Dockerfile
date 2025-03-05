FROM rocker/shiny
RUN mkdir /home/shinyAppPkgsDockerCiCd
ADD . /home/shinyAppPkgsDockerCiCd
WORKDIR /home/shinyAppPkgsDockerCiCd
RUN R -e 'install.packages(c("bslib", "cli", "ggplot2", "logger", "pkgload", "quarto", "remotes", "rlang", "sass", "shiny", "shinythemes", "stringr", "tools", "withr"))'
RUN R -e 'remotes::install_local(upgrade="never")'
EXPOSE 8180
CMD Rscript deploy.R