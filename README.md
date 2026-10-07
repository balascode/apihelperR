# apihelperR

[![R-CMD-check](https://github.com/balascode/apihelperR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/balascode/apihelperR/actions/workflows/R-CMD-check.yaml)

`apihelperR` is a small R package for working with earthquake data from the USGS Earthquake API.
`apihelperR` is a small R package for working with earthquake data from the USGS Earthquake API.

The package sends a request to the API, reads the returned GeoJSON data, and converts it into a clean R `data.frame` that is easier to use for analysis, plots, and Shiny applications.

This package was developed as part of the **Advanced Programming in R (732A94)** course at Linköping University.

## Features

`apihelperR` can:

- retrieve earthquake data for a selected date range
- filter earthquakes by minimum magnitude
- limit the number of returned results
- return the data as a clean R `data.frame`
- provide useful fields such as time, magnitude, place, longitude, latitude, depth, and tsunami flag
- validate user input before sending a request to the API

## Installation

You can install the package directly from GitHub.

First, install the `remotes` package if you do not already have it:

```r
install.packages("remotes")
```

Then install `apihelperR`:

```r
remotes::install_github("balascode/apihelperR")
```

Load the package with:

```r
library(apihelperR)
```

## Basic usage

The main function in the package is `get_earthquakes()`.

Example:

```r
library(apihelperR)

quakes <- get_earthquakes(
  start_date = "2026-01-01",
  end_date = "2026-01-02",
  min_magnitude = 4,
  limit = 10
)

quakes
```

This example asks the USGS API for up to 10 earthquakes that occurred between `2026-01-01` and `2026-01-02` with a magnitude of at least 4.

The result is returned as a regular R `data.frame`.

## Returned data

The returned data contains the following columns:

| Column | Description |
|---|---|
| `id` | Unique earthquake ID from USGS |
| `time` | Time when the earthquake occurred |
| `magnitude` | Earthquake magnitude |
| `place` | Description of the earthquake location |
| `longitude` | Longitude of the earthquake |
| `latitude` | Latitude of the earthquake |
| `depth` | Depth of the earthquake in kilometres |
| `tsunami` | Tsunami flag provided by USGS |

The `time` column is converted to a readable R date-time value in UTC.

## Function arguments

The `get_earthquakes()` function uses four main arguments.

### `start_date`

The start of the search period.

Example:

```r
start_date = "2026-01-01"
```

### `end_date`

The end of the search period.

Example:

```r
end_date = "2026-01-02"
```

The start date cannot be later than the end date.

### `min_magnitude`

The minimum earthquake magnitude to include.

Example:

```r
min_magnitude = 4
```

The default value is `0`.

### `limit`

The maximum number of earthquake records to return.

Example:

```r
limit = 10
```

The default value is `1000`.

## Input validation

The package checks the input before sending a request to the API.

For example, this call is not valid:

```r
get_earthquakes(
  start_date = "2026-01-10",
  end_date = "2026-01-01"
)
```

The package will return an error because the start date is later than the end date.

The package also checks invalid dates, invalid magnitude values, and invalid limits.

## How the package works

The package follows a simple flow:

```text
User calls get_earthquakes()
        |
        v
Input is validated
        |
        v
An HTTP request is created
        |
        v
The request is sent to the USGS API
        |
        v
USGS returns GeoJSON data
        |
        v
The response is converted to R objects
        |
        v
The package creates a clean data.frame
```

The package uses `httr2` to send HTTP requests.

The USGS API returns nested GeoJSON data. Internally, `apihelperR` extracts the useful fields and converts them into a simpler table.

## Testing

The package includes unit tests using `testthat`.

The tests check important behaviour such as:

- whether the function returns a `data.frame`
- whether the expected columns are present
- whether invalid date ranges return an error
- whether invalid limits return an error

During development, the tests can be run with:

```r
devtools::test()
```

The full package can be checked with:

```r
devtools::check()
```

## Data source

The earthquake data comes from the **United States Geological Survey (USGS)**.

USGS Earthquake API documentation:

https://earthquake.usgs.gov/fdsnws/event/1/

USGS Earthquake Hazards Program:

https://earthquake.usgs.gov/

The package uses this API endpoint:

```text
https://earthquake.usgs.gov/fdsnws/event/1/query
```

The USGS Earthquake API does not require an API key.

## Example workflow

```r
library(apihelperR)

quakes <- get_earthquakes(
  start_date = "2026-01-01",
  end_date = "2026-01-02",
  min_magnitude = 4,
  limit = 10
)

head(quakes)
summary(quakes$magnitude)
```

The latitude and longitude columns can also be used later in maps or Shiny applications.

## Shiny application

A separate Shiny application is being developed using this package.

The package handles the API request and data cleaning, while the Shiny application handles the user interface and visualisation.

The overall structure is:

```text
Shiny application
        |
        v
apihelperR
        |
        v
USGS Earthquake API
```

This keeps the package reusable outside the Shiny application.

## Authors

**Venkata Balaji Anupoju**  
LiU ID: `venan324`  
GitHub: `balascode`

**Marwan Karim**  
LiU ID: `marka671`

Developed for:

**732A94 - Advanced Programming in R**  
Linköping University

## License

This project was created for educational purposes as part of a university course.
