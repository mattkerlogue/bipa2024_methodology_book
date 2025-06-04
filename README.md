# Blavatnik Index of Public Administration 2024: Methodology documentation

<!-- badges: start -->
<!-- badges: end -->

This repository produces a replica of the
[methodology section](http://index.bsg.ox.ac.uk/methodology/) of the Blavatnik
Index of Public Administration website, the documentation on the website
remains the definitive source. This replica has been produced in Quarto with
the purpose of to integrating the documentation into a single
[PDF document](Blavatnik-Index-of-Public-Administration-2024--Methodology.pdf),
the documentation is also rendered as an HTML
[Quarto book](https://blavatnik-index.github.io/bipa2024_methodology_report/)
and an
[ePub version](Blavatnik-Index-of-Public-Administration-2024--Methodology.epub).

## Copyright, licensing and reuse

The Blavatnik Index of Public Administration is copyright of the Blavatnik School of Government, University of Oxford. The results of the Index, this report, any visualisations and articles associated with the Index produced by the Blavatnik School of Government are licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Any software and source code written by the Blavatnik School of Government to produce the Index and associated works is released under the MIT License, please see the appropriate repository for specific details of licensing.

When re-using the Index data or associated materials, please cite the work appropriately: Blavatnik Index of Public Administration 2024, Blavatnik School of Government, University of Oxford, https://index.bsg.ox.ac.uk

As per the terms of the CC BY 4.0 license, to the fullest extent possible as permitted by law, the Blavatnik School of Government presents this work ‘as is’, without warranty of any kind and accepting no liability arising from any use of the work.

The original source data used to compile the Blavatnik Index of Public Administration remains subject to licence terms of the original third-party authors, please consult the original materials for specific licence terms and conditions relating to each source.


## Workflow

This repo is written using [Quarto](https://quarto.org/) and
[R](https://r-project.org/) and produces PDF, HTML and ePub outputs.

To (re)build the book run `quarto render` from the terminal, `quarto::render()`
from within R. This will first run the pre-render script to check/download
required data, build the book and then run the post-render script to prepend
the PDF cover page to the document and copy the PDF/ePub versions into the
main folder.

The github repository has been set up to re-build the book when an update is
pushed to the repository using the Quarto
[publish action](https://quarto.org/docs/publishing/github-pages.html#github-action)
for GitHub Actions. R code is only executed locally using Quarto's freeze
functionality, R package depndencies are managed using
[renv](https://rstudio.github.io/renv/).

### Pre-render: data sources

In order to run this repo needs access to data from the other related Blavatnik
Index repositories (see above). Prior to rendering the book the script
`get_data.R` will be run which checks the contents of the `data` folder for the
relevant files needed to calculate output. If these files are not found they
are downloaded from the relevant repo.

- Metadata from the [`bipa2024_cartography`](https://github.com/blavatnik-index/bipa2024_cartography)
  repository:
    - `entity_codes.csv`: Reference dataset of identification codes and labels
      for countries and territories.
    - `entity_georegions.csv`: Reference dataset providing a lookup for country
      codes to geographic regions.
    - `entity_wb_classification23.csv`: The World Banks' 2023 income
      classification of countries and territories.
- Contextual data from the [`bipa2024_sourcedata`](https://github.com/blavatnik-index/bipa2024_sourcedata)
  repository:
    - `wb_wdi_2024.csv`: Contextual indicators (population, GDP, GDP per
      capita, etc) extracted from the World Bank's data API.
- Results and metadata from the [`bipa2024_index`](https://github.com/blavatnik-index/bipa2024_index)
  repository:
    - `bipa2024_all_data.csv`: The results of the Blavatnik Index of Public
      Administration 2024.
    - `bipa2024_dqc_full.rds`: The detailed output of the Blavatnik Index's
      data coverage assessment which determined the countries/territories
      included in the Index.
    - `bipa2024_sensitivity_results.csv`: A summary of the sensitivity tests
      run to assess the robustness of the Blavatnik Index's methodology.
    - `bipa2024_data_structure.csv`: The data structure of the Blavatnik Index.
    - `metrics_summary.csv`: Summary metadata for the metrics included in the
      Blavatnik Index of Public Administration 2024.
    - `source_summary.csv`: Summary information about the sources that the
      Bavatnik Index is calculated from.
    - `metrics_metadata.csv`: Detailed metadata relating to the metrics used
      to calculate the Blavatnik Index.

### Post-render: PDF and file management

The PDF rendered by quarto has a generic cover page, a custom coverpage is
prepended to the document using the `{qpdf}` package.

If running interactively/locally (i.e. not on Github) the post-render script
will also copy the PDF and ePub documents into the main repository (to make
them available in the main branch of the repository). To ensure this action
runs in terminal sessions please set an environment variable of
`QUARTO_BUILD_STATE=LOCAL`. The easiest way to do this is using a `.renviron`
file.