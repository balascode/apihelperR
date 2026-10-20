parse_earthquakes <- function(data) {

  features <- data$features

  if (length(features) == 0) {

    return(
      data.frame(
        id = character(),
        time = as.POSIXct(
          character(),
          tz = "UTC"
        ),
        magnitude = numeric(),
        place = character(),
        longitude = numeric(),
        latitude = numeric(),
        depth = numeric(),
        tsunami = integer(),
        stringsAsFactors = FALSE
      )
    )
  }

  ids <- vapply(
    features,
    function(feature) {
      as.character(feature$id)
    },
    character(1)
  )

  times <- vapply(
    features,
    function(feature) {
      as.numeric(feature$properties$time)
    },
    numeric(1)
  )

  magnitudes <- vapply(
    features,
    function(feature) {
      if (is.null(feature$properties$mag)) {
        NA_real_
      } else {
        as.numeric(feature$properties$mag)
      }
    },
    numeric(1)
  )

  places <- vapply(
    features,
    function(feature) {
      if (is.null(feature$properties$place)) {
        NA_character_
      } else {
        as.character(feature$properties$place)
      }
    },
    character(1)
  )

  longitudes <- vapply(
    features,
    function(feature) {
      as.numeric(
        feature$geometry$coordinates[[1]]
      )
    },
    numeric(1)
  )

  latitudes <- vapply(
    features,
    function(feature) {
      as.numeric(
        feature$geometry$coordinates[[2]]
      )
    },
    numeric(1)
  )

  depths <- vapply(
    features,
    function(feature) {
      as.numeric(
        feature$geometry$coordinates[[3]]
      )
    },
    numeric(1)
  )

  tsunamis <- vapply(
    features,
    function(feature) {
      if (is.null(feature$properties$tsunami)) {
        NA_integer_
      } else {
        as.integer(feature$properties$tsunami)
      }
    },
    integer(1)
  )

  data.frame(
    id = ids,
    time = as.POSIXct(
      times / 1000,
      origin = "1970-01-01",
      tz = "UTC"
    ),
    magnitude = magnitudes,
    place = places,
    longitude = longitudes,
    latitude = latitudes,
    depth = depths,
    tsunami = tsunamis,
    stringsAsFactors = FALSE
  )
}
