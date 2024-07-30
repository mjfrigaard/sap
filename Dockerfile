FROM rocker/shiny
# RUN R -e 'install.packages("remotes")'
RUN R -e 'install.packages(c("rlang", "stringr", "shiny", "ggplot2", "remotes"))'
# RUN Rscript -e 'remotes::install_version("rlang",upgrade="never", version = "1.1.2")'
# RUN Rscript -e 'remotes::install_version("stringr",upgrade="never", version = "1.5.1")'
# RUN Rscript -e 'remotes::install_version("shiny",upgrade="never", version = "1.8.0")'
# RUN Rscript -e 'remotes::install_version("ggplot2",upgrade="never", version = "3.4.4")'
RUN mkdir /deploy
ADD . /deploy
WORKDIR /deploy
RUN R -e 'remotes::install_local(upgrade="never")'
RUN rm -rf /deploy
EXPOSE 8180
CMD R -e "options('shiny.port'=8180,shiny.host='0.0.0.0');library(shinyAppPkgs);shinyAppPkgs::launch_app()"
