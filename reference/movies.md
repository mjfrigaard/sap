# IMDB movies data

Movie review data. Note: these data come from the [Building Web
Applications with shiny
course](https://rstudio-education.github.io/shiny-course/).

## Usage

``` r
movies
```

## Format

A data frame with 651 rows and 34 variables:

- title:

  movie title

- title_type:

  type, fct (Documentary, Feature Film, TV Movie)

- genre:

  movie genre, fct (Action & Adventure, Animation, etc.

- runtime:

  movie length in minutes, num, avg = 106, sd = 19.4

- mpaa_rating:

  movie rating, fct (G, NC-17, PG, PG-13, R, Unrated)

- studio:

  name of studio, chr

- thtr_rel_date:

  Theatre release date, POSIXct, min = 1970-05-19 21:00:00, max =
  2014-12-24 21:00:00

- thtr_rel_year:

  Theatre release year, num, min = 1970, max = 2014

- thtr_rel_month:

  Theatre release month, num, min = 1, max =12

- thtr_rel_day:

  Theatre release day, num, min = 1, max =31

- dvd_rel_date:

  DVD release date, POSIXct, min = 1991-03-27 21:00:00, max = 2015-03-02
  21:00:00

- dvd_rel_year:

  DVD release year, num, min = 1991, max = 2015

- dvd_rel_month:

  DVD release month, num, min = 1, max = 12

- dvd_rel_day:

  DVD release day, num, min = 1, max = 31

- imdb_rating:

  Internet movie database rating, avg = 6.49, sd = 1.08

- imdb_num_votes:

  Internet movie database votes, avg = 57533, sd = 112124

- critics_rating:

  Rotten tomatoes rating, fct (Certified Fresh, Fresh, Rotten)

- critics_score:

  Rotten tomatoes score, avg = 57.7, sd = 28.4

- audience_rating:

  Audience rating, fct (Spilled, Upright)

- audience_score:

  Audience score, avg = 62.4, sd = 20.2

- best_pic_nom:

  Best picture nomination, fct (no, yes)

- best_pic_win:

  Best picture win, fct (no, yes)

- best_actor_win:

  Best actor win, fct (no, yes)

- best_actress_win:

  Best actress win, fct (no, yes)

- best_dir_win:

  Best director win, fct (no, yes)

- top200_box:

  Top 20 box-office, fct (no, yes)

- director:

  Name of director, chr

- actor1:

  Name of leading actor, chr

- actor2:

  Name of supporting actor, chr

- actor3:

  Name of \#3 actor, chr

- actor4:

  Name of \#4 actor, chr

- actor5:

  Name of \#5 actor, chr

- imdb_url:

  IMDB URL

- rt_url:

  Rotten tomatoes URL

## Details

Read more about acquiring these data in the ['Web Scraping and
programming' section of Data science in a
box](https://datasciencebox.org/02-exploring-data#web-scraping-and-programming)
