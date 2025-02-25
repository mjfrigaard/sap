FROM rocker/shiny
RUN R -e "install.packages(c('bslib', 'cli', 'ggplot2', 'logger', 'pkgload', 'remotes', 'rlang', 'sass', 'shiny', 'shinythemes', 'stringr', 'tools', 'withr'))"
RUN mkdir /deploy
ADD . /deploy
WORKDIR /deploy
RUN R -e "remotes::install_local(upgrade='never')"
RUN rm -rf /deploy
EXPOSE 8180
CMD R -e "options('shiny.port'=8180,shiny.host='0.0.0.0');library(sap);sap::launch_app()"