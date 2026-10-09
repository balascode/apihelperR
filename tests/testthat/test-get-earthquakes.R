test_that("get_earthquakes returns a data frame", {
  result <- get_earthquakes(
    start_date = "2026-01-01",
    end_date = "2026-01-02",
    min_magnitude = 4,
    limit = 5
  )

  expect_s3_class(result, "data.frame")
  expect_lte(nrow(result), 5)
})

test_that("get_earthquakes returns expected columns", {
  result <- get_earthquakes(
    start_date = "2026-01-01",
    end_date = "2026-01-02",
    min_magnitude = 4,
    limit = 5
  )

  expected_columns <- c(
    "id",
    "time",
    "magnitude",
    "place",
    "longitude",
    "latitude",
    "depth",
    "tsunami"
  )

  expect_true(all(expected_columns %in% names(result)))
})

test_that("invalid date order gives an error", {
  expect_error(
    get_earthquakes(
      start_date = "2026-01-10",
      end_date = "2026-01-01"
    ),
    "start_date cannot be after end_date"
  )
})

test_that("invalid start date gives an error", {
  expect_error(
    get_earthquakes(
      start_date = "not-a-date",
      end_date = "2026-01-02"
    ),
    "start_date must be a valid date"
  )
})

test_that("invalid end date gives an error", {
  expect_error(
    get_earthquakes(
      start_date = "2026-01-01",
      end_date = "not-a-date"
    ),
    "end_date must be a valid date"
  )
})

test_that("non-numeric magnitude gives an error", {
  expect_error(
    get_earthquakes(
      start_date = "2026-01-01",
      end_date = "2026-01-02",
      min_magnitude = "large"
    ),
    "min_magnitude must be a single numeric value"
  )
})

test_that("invalid lower limit gives an error", {
  expect_error(
    get_earthquakes(
      start_date = "2026-01-01",
      end_date = "2026-01-02",
      limit = 0
    ),
    "limit must be between 1 and 20000"
  )
})

test_that("limit above USGS maximum gives an error", {
  expect_error(
    get_earthquakes(
      start_date = "2026-01-01",
      end_date = "2026-01-02",
      limit = 20001
    ),
    "limit must be between 1 and 20000"
  )
})

test_that("empty API response returns expected columns", {
  result <- parse_earthquakes(
    list(features = list())
  )

  expected_columns <- c(
    "id",
    "time",
    "magnitude",
    "place",
    "longitude",
    "latitude",
    "depth",
    "tsunami"
  )

  expect_s3_class(result, "data.frame")
  expect_named(result, expected_columns)
  expect_equal(nrow(result), 0)
})
