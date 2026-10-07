#' Get earthquake data from the USGS API
#'
#' Downloads earthquake information from the USGS Earthquake API
#' for a specified date range and minimum magnitude.
#'
#' @param start_date Start date in "YYYY-MM-DD" format.
#' @param end_date End date in "YYYY-MM-DD" format.
#' @param min_magnitude Minimum earthquake magnitude. Default is 0.
#' @param limit Maximum number of earthquakes to return. Default is 1000.
#'
#' @return A data.frame containing earthquake information including
#'   time, magnitude, location, longitude, latitude, depth and tsunami flag.
#'
#' @examples
#' \dontrun{
#' earthquakes <- get_earthquakes(
#'   start_date = "2026-01-01",
#'   end_date = "2026-01-02",
#'   min_magnitude = 4,
#'   limit = 10
#' )
#'
#' head(earthquakes)
#' }
#'
#' @export
get_earthquakes <- function(start_date,
                            end_date,
                            min_magnitude = 0,
                            limit = 1000) {

  validate_earthquake_inputs(
    start_date,
    end_date,
    min_magnitude,
    limit
  )

  req <- httr2::request(
    "https://earthquake.usgs.gov/fdsnws/event/1/query"
  )

  req <- httr2::req_url_query(
    req,
    format = "geojson",
    starttime = start_date,
    endtime = end_date,
    minmagnitude = min_magnitude,
    limit = limit
  )

  response <- httr2::req_perform(req)

  data <- httr2::resp_body_json(response)

  parse_earthquakes(data)
}
