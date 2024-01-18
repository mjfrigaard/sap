FROM rocker/shiny
RUN mkdir /home/movies-app-docker-cicd
ADD . /home/movies-app-docker-cicd
WORKDIR /home/movies-app-docker-cicd
RUN R -e 'install.packages(c("rlang", "stringr", "shiny", "ggplot2", "remotes", "rsconnect", "bslib"))'
RUN R -e 'remotes::install_local(upgrade="never")'
EXPOSE 8180
CMD Rscript deploy.R