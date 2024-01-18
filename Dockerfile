FROM rocker/shiny
RUN mkdir /home/moviesAppDockerCiCd
ADD . /home/moviesAppDockerCiCd
WORKDIR /home/moviesAppDockerCiCd
RUN R -e 'install.packages(c("rlang", "stringr", "shiny", "ggplot2", "remotes", "rsconnect", "bslib"))'
RUN R -e 'remotes::install_local(upgrade="never")'
EXPOSE 8180
CMD Rscript deploy.R