# post rendering script to merge custom front cover to generated PDF file

copy_with_message <- function(from, to, msg = NULL, overwrite = TRUE) {
  copy_result <- file.copy(from, to, overwrite)
  if (!is.null(msg) && copy_result) {
    message(msg)
  }
  if (!copy_result) {
    stop("copy of ", basename(from), "failed")
  }
}

# copy PDF ----------------------------------------------------------------
copy_with_message(
  "_book/Blavatnik-Index-of-Public-Administration-2024--Methodology.pdf",
  "Blavatnik-Index-of-Public-Administration-2024--Methodology_raw.pdf",
  msg = "Copied raw output"
)

# temp file for combined output -------------------------------------------

tmp_file <- qpdf::pdf_combine(
  c(
    "images/bipa2024_methodology_cover.pdf",
    "_book/Blavatnik-Index-of-Public-Administration-2024--Methodology.pdf"
  ),
  tempfile(fileext = ".pdf")
)
if (file.exists(tmp_file)) {
  message("Merged PDF created")
}

# replace site file -------------------------------------------------------
copy_with_message(
  tmp_file,
  "_book/Blavatnik-Index-of-Public-Administration-2024--Methodology.pdf",
  msg = "PDF copied to site folder"
)

# copy pdf/epub to main repo ----------------------------------------------
# using in-built quarto GH pages render deployment leaves files only
# accessible via that branch, on local
copy_out <- FALSE
if (Sys.getenv("QUARTO_BUILD_STATE") == "LOCAL") {
  copy_out <- TRUE
} else if (interactive()) {
  usr <- readline(
    "Do you want to copy the PDF/epub into the project's base folder? [y/n]: "
  )
  if (tolower(usr) == "y" || tolower(usr) == "yes") {
    copy_out <- TRUE
  }
}

if (copy_out) {
  copy_with_message(
    tmp_file,
    "Blavatnik-Index-of-Public-Administration-2024--Methodology.pdf",
    msg = "PDF copied to base directory"
  )
  copy_with_message(
    "_book/Blavatnik-Index-of-Public-Administration-2024--Methodology.epub",
    "Blavatnik-Index-of-Public-Administration-2024--Methodology.epub",
    msg = "ePub copied to base directory"
  )
}
