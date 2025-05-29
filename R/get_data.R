data_urls <- c(
  file.path(
    "https://github.com/blavatnik-index/bipa2024_index/raw/refs/heads/main",
    "data_out",
    "bipa2024_dqc_full.rds"
  ),
  file.path(
    "https://github.com/blavatnik-index/bipa2024_index/raw/refs/heads/main",
    "data_out",
    "bipa2024_all_data.csv"
  ),
  file.path(
    "https://github.com/blavatnik-index/bipa2024_cartography/raw/refs/heads/main",
    "entity_codes",
    "entity_codes.csv"
  ),
  file.path(
    "https://github.com/blavatnik-index/bipa2024_cartography/raw/refs/heads/main",
    "entity_codes",
    "entity_georegions.csv"
  ),
  file.path(
    "https://github.com/blavatnik-index/bipa2024_cartography/raw/refs/heads/main",
    "entity_codes",
    "entity_wb_classification23.csv"
  ),
  file.path(
    "https://github.com/blavatnik-index/bipa2024_sourcedata/raw/refs/heads/main",
    "data_context",
    "wb_wdi_2024.csv"
  ),
  file.path(
    "https://github.com/blavatnik-index/bipa2024_index/raw/refs/heads/main",
    "data_ref",
    "metrics_metadata.csv"
  ),
  file.path(
    "https://github.com/blavatnik-index/bipa2024_index/raw/refs/heads/main",
    "data_out",
    "bipa2024_sensitivity_results.csv"
  ),
  file.path(
    "https://github.com/blavatnik-index/bipa2024_index/raw/refs/heads/main",
    "data_ref",
    "source_summary.csv"
  ),
  file.path(
    "https://github.com/blavatnik-index/bipa2024_index/raw/refs/heads/main",
    "data_ref",
    "metrics_summary.csv"
  ),
  file.path(
    "https://github.com/blavatnik-index/bipa2024_index/raw/refs/heads/main",
    "data_out",
    "bipa2024_data_structure.csv"
  )
)

if (!dir.exists("data")) {
  dir.create("data")
  cli::cli_alert_info("`data` folder did not exist and has been created")
}

for (url in data_urls) {
  local_file <- file.path("data", basename(url))
  if (!file.exists(local_file)) {
    download.file(url, local_file, quiet = TRUE)
    cli::cli_alert_success(
      "Downloaded {.file {basename(local_file)}} to `data` folder"
    )
  }
}
