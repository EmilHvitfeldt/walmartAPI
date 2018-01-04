#' Value of the day
#'
#' \code{\link{VOD}} provides the Value of the Day item at walmart.
#'
#' An API key will be required to run this function and can be acquired by
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
#' \dontrun{
#' key <- "************************"
#'
#' VOD(key = key)
#'
#' VOD(key = key, list_output = TRUE)
#' }
#' @export
VOD <- function(key = auth_cache$KEY, list_output = FALSE) {

  if(is.null(key)) stop("No arguemnt to 'key'. Use save_walmart_credentials or supply appropriate arguments")

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
