#' Get award recipients from the movies dataset
#'
#' This function filters the `movies` dataset based on the selected 
#' award type ("picture/director" or "actor/actress") and a specified
#' year.
#'
#' @param data A data frame containing the `movies` dataset.
#' @param award A character string, either `"picture/director"` or 
#'   `"actor/actress"`.
#' @param year Integer, the year a range is calculated from. If 
#'   `"picture/director"`, +/- 2 years. If `"actor/actress"`, +/- 1 year.
#'
#' @return A `tibble` with selected columns depending on the award type:
#'  * `award == "picture/director"`: returns `title`, `release_year`, `director`
#'  * `award == "actor/actress"`: returns `title`, `release_year`, `star`
#'
#' @export
#'
get_award_recipients <- function(data, award, year) {
  
  if (!award %in% c("picture/director", "actor/actress")) {
    stop("`award` must be either 'picture/director' or 'actor/actress'")
  }

  if (award == "picture/director") {
    start_year <- year - 2
    end_year <- year + 2
    dplyr::filter(
      data,
      .data$best_pic_win == "yes" | .data$best_dir_win == "yes"
    ) |>
      dplyr::filter(
        .data$thtr_rel_year >= start_year,
        .data$thtr_rel_year <= end_year
      ) |>
      dplyr::mutate(
        genre = paste0("(", .data$genre, ")")
      ) |> 
      tidyr::unite(
        col = 'dir_genre',
        c("director", "genre"),
        sep = "\n"
      ) |>
      dplyr::select(
        title = .data$title,
        release_year = .data$thtr_rel_year,
        director_genre = .data$dir_genre
      ) |>
      dplyr::arrange(.data$release_year)

  } else if (award == "actor/actress") {
    start_year <- year - 1
    end_year <- year + 1
    dplyr::filter(
      data,
      .data$best_actor_win == "yes" | .data$best_actress_win == "yes"
    ) |>
      dplyr::filter(
        .data$thtr_rel_year >= start_year,
        .data$thtr_rel_year <= end_year
      ) |>
      tidyr::unite(
        col = 'star',
        c("actor1", "actor2"),
        sep = " &\n"
      ) |>
      dplyr::select(
        title = .data$title,
        release_year = .data$thtr_rel_year,
        star = .data$star
      ) |>
      dplyr::arrange(.data$release_year)
  }
}
