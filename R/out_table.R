out_table <- function(x, width = NULL) {
  if (!inherits(x, "gt_tbl")) {
    x |> gt::gt()
  }

  if (knitr::is_latex_output()) {
    x <- x |>
      gt::as_latex() |>
      gsub(
        pattern = "fontsize\\{12.0pt\\}\\{14.4pt\\}",
        replacement = "fontsize{8.0pt}{11pt}",
        x = _,
        perl = TRUE
      )
    return(x)
  }

  x <- x |>
    gt::opt_row_striping(row_striping = FALSE) |>
    gt::opt_table_font(
      font = c("Open Sans", "sans-serif"),
      size = gt::px(13)
    ) |>
    gt::tab_stub_indent(rows = tidyselect::everything(), indent = 0)

  if (!is.null(width) && is.numeric(width)) {
    x <- x |> gt::tab_options(table.width = gt::px(width))
  }

  # x <- gt::as_raw_html(x)

  return(x)
}

render_bullets <- function(x, col) {
  if (knitr::is_html_output() || interactive()) {
    x <- x |> gt::fmt_markdown(columns = {{ col }})
  } else {
    x <- x
  }
  return(x)
}
