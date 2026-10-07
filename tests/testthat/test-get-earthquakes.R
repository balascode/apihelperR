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

test_that("invalid limit gives an error", {
  expect_error(
    get_earthquakes(
      start_date = "2026-01-01",
      end_date = "2026-01-02",
      limit = 0
    ),
    "limit must be between 1 and 20000"
  )
})
