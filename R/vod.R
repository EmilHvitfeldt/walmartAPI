#' Value of the day
#'
#' \code{\link{VOD}} provides the Value of the Day item at walmart.
#'
#' An API key will be required to run this function and can be aqquired by
#' creating an account on the following website
#' \url{https://developer.walmartlabs.com/member}.
#'
#' Response formats are described at the url
#' \url{https://developer.walmartlabs.com/docs/read/Item_Field_Description}.
#'
#' @param key Your API access key.
#' @param list_output Indicator for list output.
#' @return A tibble with 15 columns in base response format.
#' @examples
#' key <- "************************"
#'
#' VOD(key = key)
#' @export
VOD <- function(key, list_output = FALSE) {

  url <- glue::glue("http://api.walmartlabs.com/v1/vod?format=json&apiKey={key}")

  response <- httr::GET(url)

  if (httr::http_type(response) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  if(list_output) {
    return(httr::content(response))
  }

  response %>%
    httr::content() %>%
    list() %>%
    item_base_response()
}
