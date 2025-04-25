#' Knit the current Rmd file with today's date in the filename
#'
#' @export
knit_with_date <- function() {
  library(rstudioapi)
  library(rmarkdown)
  library(tools)
  
  # Get the path of the currently open Rmd file
  rmd_path <- rstudioapi::getActiveDocumentContext()$path
  
  if (!nzchar(rmd_path) || !grepl("\\.Rmd$", rmd_path)) {
    stop("Please open an R Markdown (.Rmd) file in the editor.")
  }
  
  # Extract base name (without extension)
  base_name <- file_path_sans_ext(basename(rmd_path))
  
  # Get today's date as YYYYMMDD
  date_str <- format(Sys.Date(), "%Y%m%d")
  
  # Construct output filename
  output_file <- sprintf("%s_%s.html", base_name, date_str)
  
  # Knit the document
  render(
    input = rmd_path,
    output_file = output_file,
    output_dir = dirname(rmd_path),
    quiet = FALSE
  )
  
  message("Rendered to: ", file.path(dirname(rmd_path), output_file))
}
