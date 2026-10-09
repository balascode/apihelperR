# apihelperR

[![R-CMD-check](https://github.com/balascode/apihelperR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/balascode/apihelperR/actions/workflows/R-CMD-check.yaml)

`apihelperR` is a small R package for retrieving and working with earthquake data from the USGS Earthquake API.

The package sends requests to the USGS API, reads the returned GeoJSON data, and converts it into a clean R `data.frame` that can be used for analysis, plots, and Shiny applications.

This package was developed as part of the **Advanced Programming in R (732A94)** course at Linköping University.

## Features

`apihelperR` can:

- retrieve earthquake data for a selected date range
- filter earthquakes by minimum magnitude
- limit the number of returned results
- return earthquake data as a clean R `data.frame`
- provide useful information such as time, magnitude, place, longitude, latitude, depth, and tsunami flag
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

The result is returned as an R `data.frame`.

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

The `time` column is converted into a readable R date-time value in UTC.

## Function arguments

The `get_earthquakes()` function uses four main arguments.

### `start_date`

The beginning of the search period.

```r
start_date = "2026-01-01"
```

### `end_date`

The end of the search period.

```r
end_date = "2026-01-02"
```

The start date cannot be later than the end date.

### `min_magnitude`

The minimum earthquake magnitude to include.

```r
min_magnitude = 4
```

The default value is `0`.

### `limit`

The maximum number of earthquake records to return.

```r
limit = 10
```

The default value is `1000`.

The package accepts values from 1 to 20000 for `limit`.

## Input validation

The package checks user input before sending a request to the API.

For example, this request is invalid:

```r
get_earthquakes(
  start_date = "2026-01-10",
  end_date = "2026-01-01"
)
```

The package returns an error because the start date is later than the end date.

The package also checks invalid dates, invalid magnitude values, and invalid result limits.

## How the package works

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
The response is converted into R objects
        |
        v
The nested response is parsed
        |
        v
A clean data.frame is returned
```

The package uses `httr2` to send HTTP requests.

The USGS API returns nested GeoJSON data. Internally, `apihelperR` extracts the useful values from the response and converts them into a simpler table.

## Testing

The package includes unit tests using `testthat`.

The tests check important behaviour such as:

- whether the function returns a `data.frame`
- whether the expected columns are present
- whether invalid date ranges produce an error
- whether invalid result limits produce an error

Run the tests with:

```r
devtools::test()
```

Run the full package check with:

```r
devtools::check()
```

## Vignette

The package includes a vignette with examples of how to use `apihelperR`.

List the available vignette with:

```r
vignette(package = "apihelperR")
```

Open it with:

```r
vignette("apihelperR", package = "apihelperR")
```

## Data source

The earthquake data comes from the **United States Geological Survey (USGS)**.

USGS Earthquake API documentation:

https://earthquake.usgs.gov/fdsnws/event/1/

USGS Earthquake Hazards Program:

https://earthquake.usgs.gov/

The package uses this endpoint:

```text
https://earthquake.usgs.gov/fdsnws/event/1/query
```

The USGS Earthquake API does not require an API key.

## Shiny application

A separate Shiny application is available for interactively exploring earthquake data using this package.

Shiny repository:

https://github.com/Hakaishinnn/apihelperR-shiny

The package handles API communication and data cleaning, while the Shiny application handles the user interface and visualisation.

```text
Shiny application
        |
        v
apihelperR
        |
        v
USGS Earthquake API
```

## Authors

**Venkata Balaji Anupoju**  
LiU ID: `venan324`  
GitHub: `balascode`

**Marwan Karim**  
LiU ID: `marka671`  
GitHub: `Hakaishinnn`

Developed for:

**732A94 - Advanced Programming in R**  
Linköping University

## License

This project is licensed under the MIT License.
