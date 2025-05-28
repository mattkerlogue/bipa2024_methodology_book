clean_bib <- function(path) {
  bib_raw <- readLines(path)
  bib_base <- tibble::tibble(
    raw_text = bib_raw
  )
  bib_proc <- bib_base |>
    dplyr::mutate(
      empty = raw_text == "",
      rcrd_start = grepl("^@([A-z]+?)\\{(.*),", raw_text, perl = TRUE),
      rcrd_end = raw_text == "}",
      key = dplyr::if_else(
        rcrd_start,
        gsub("^@([A-z]+?)\\{(.*),", "\\2", raw_text),
        NA_character_
      ),
      field = dplyr::case_when(
        rcrd_start ~ "rcrd_type",
        grepl("^\\t+?\\S+\\s?=\\s?\\{?", raw_text, perl = TRUE) ~
          gsub("^\\t(\\S+)\\s.*", "\\1", raw_text, perl = TRUE),
        TRUE ~ NA_character_
      ),
      value = dplyr::case_when(
        rcrd_start ~ gsub("^@([A-z]+?)\\{(.*?),", "\\1", raw_text),
        empty ~ NA_character_,
        rcrd_end ~ NA_character_,
        !is.na(field) ~
          gsub(
            "^\\t+?\\S+\\s?=\\s?\\{?(.*?)\\}?,?$",
            "\\1",
            raw_text,
            perl = TRUE
          ),
        TRUE ~ raw_text
      ),
      value = gsub("\\},$", "", value),
      value = gsub("[\\{\\}]", "", value),
      value = stringr::str_squish(value),
      spacer = dplyr::if_else(grepl("^[A-z]$", value), "", " ")
    ) |>
    dplyr::filter(!empty & !rcrd_end) |>
    tidyr::fill(key, field) |>
    dplyr::summarise(
      value = paste0(value, spacer, collapse = ""),
      .by = c(key, field)
    ) |>
    dplyr::mutate(value = stringr::str_squish(value)) |>
    tidyr::pivot_wider(names_from = field, values_from = value)
}
