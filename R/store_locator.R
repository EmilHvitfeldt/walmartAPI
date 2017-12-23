#' Locale nearby Walmart stores
#'
#' \code{\link{store_locator}} helps locate nearest Walmart Stores by letting
#' you users search for stores by latitude and longitude, by zip code and by
#' city.
#'
#' An API key will be required to run this function and can be aqquired by
#' creating an account on the following website
#' \url{https://developer.walmartlabs.com/member}.
#'
#' For more information refer to the original documentation
#' \url{https://developer.walmartlabs.com/docs/read/Store_Locator_API}.
#'
#' @param key Your API access key.
#' @param lat latitude.
#' @param lon longitude.
#' @param city city.
#' @param zip zip code.
#' @param list_output Indicator for list output.
#' @return A tibble with 12 columns in base response format.
#' @examples
#' \dontrun{
#' key <- "************************"
#'
#' store_locator(key = key, lat = 29, lon = -95)
#'
#' store_locator(key = key, city = "Houston")
#'
#' store_locator(key = key, zip = 77063)
#'
#' store_locator(key = key, zip = 77063, list_output = TRUE)
#' }
#' @export
store_locator <- function(key = NULL, lat = NULL, lon = NULL, city = NULL,
                          zip = NULL, list_output = FALSE) {

  if(is.null(key)) stop("Please provide your apiKey to the 'key' argument")

  base_url <- glue::glue("http://api.walmartlabs.com/v1/stores?apiKey={key}")

  if(!is.null(zip)) {
    url <- glue::glue("{base_url}&zip={zip}")
  }
  if(!is.null(city)) {
    url <- glue::glue("{base_url}&city={city}")
  }
  if(sum(c(!is.null(lat), !is.null(lon))) == 1) {
    stop("Both lon and lat needs to specified.")
  }
  if(all(c(!is.null(lat), !is.null(lon)))) {
    url <- glue::glue("{base_url}&lon={lon}&lat={lat}")
  }

  response <- httr::GET(url)

  if (httr::http_type(response) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  if(list_output) {
    return(httr::content(response))
  }

  response %>%
    httr::content() %>%
    purrr::map_df(~ tibble::tibble(no = ifelse_null(.$no),
                                   name = ifelse_null(.$name),
                                   country = ifelse_null(.$country),
                                   lon = ifelse_null(.$coordinates[[1]]),
                                   lat = ifelse_null(.$coordinates[[2]]),
                                   streetAddress = ifelse_null(.$streetAddress),
                                   city = ifelse_null(.$city),
                                   stateProvCode = ifelse_null(.$stateProvCode),
                                   zip = ifelse_null(.$zip),
                                   phoneNumber = ifelse_null(.$phoneNumber),
                                   sundayOpen = ifelse_null(.$sundayOpen),
                                   timezone = ifelse_null(.$timezone),))
}
