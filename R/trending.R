#' Trending products at Walmart.com
#'
#' \code{\link{trending}} gives information on what is bestselling on
#'  Walmart.com right now.
#'
#' An API key will be required to run this function and can be acquired by
#' creating an account on the following website
#' \url{https://developer.walmartlabs.com/member}.
#'
#' For more information refer to the original documentation
#' \url{https://developer.walmartlabs.com/docs/read/Trending_API}.
#'
#' Response formats are described at the url
#' \url{https://developer.walmartlabs.com/docs/read/Item_Field_Description}.
#'
#' @param key Your API access key.
#' @param lsPublisherId Your LinkShare Publisher Id.
#' @param list_output Indicator for list output.
#' @return A tibble with 15 columns in base response format.
#' @examples
#' \dontrun{
#' key <- "************************"
#'
#' trending(key = key)
#'
#' trending(key = key, list_output = TRUE)
#'}
#' @export
trending <- function(key = auth_cache$KEY, lsPublisherId = NULL,
                     list_output = FALSE) {

  if(is.null(key)) stop("No arguemnt to 'key'. Use save_walmart_credentials or supply appropriate arguments")

  url <- glue::glue("http://api.walmartlabs.com/v1/trends?apiKey={key}&format=json")

  if(!is.null(lsPublisherId)) {
    url <- glue::glue("{url}&lsPublisherId={lsPublisherId}")
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
    .[["items"]] %>%
    item_base_response()
}
