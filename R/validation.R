validate_earthquake_inputs <- function(start_date,
                                       end_date,
                                       min_magnitude,
                                       limit) {

  start <- as.Date(start_date)
  end <- as.Date(end_date)

  if (is.na(start)) {
    stop("start_date must be a valid date in YYYY-MM-DD format.")
  }

  if (is.na(end)) {
    stop("end_date must be a valid date in YYYY-MM-DD format.")
  }

  if (start > end) {
    stop("start_date cannot be after end_date.")
  }

  if (!is.numeric(min_magnitude) ||
      length(min_magnitude) != 1 ||
      is.na(min_magnitude)) {
    stop("min_magnitude must be a single numeric value.")
  }

  if (!is.numeric(limit) ||
      length(limit) != 1 ||
      is.na(limit) ||
      limit < 1 ||
      limit > 20000) {
    stop("limit must be between 1 and 20000.")
  }

  invisible(TRUE)
}
