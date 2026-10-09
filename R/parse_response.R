parse_earthquakes <- function(data) {

  features <- data$features

  if (length(features) == 0) {
    return(data.frame(
      id = character(),
      time = as.POSIXct(character(), tz = "UTC"),
      magnitude = numeric(),
      place = character(),
      longitude = numeric(),
      latitude = numeric(),
      depth = numeric(),
      tsunami = integer(),
      stringsAsFactors = FALSE
    ))
  }

  result <- lapply(features, function(feature) {

    data.frame(
      id = feature$id,
      time = as.POSIXct(
        feature$properties$time / 1000,
        origin = "1970-01-01",
        tz = "UTC"
      ),
      magnitude = feature$properties$mag,
      place = feature$properties$place,
      longitude = feature$geometry$coordinates[[1]],
      latitude = feature$geometry$coordinates[[2]],
      depth = feature$geometry$coordinates[[3]],
      tsunami = feature$properties$tsunami,
      stringsAsFactors = FALSE
    )
  })

  do.call(rbind, result)
}
