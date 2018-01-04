#' Looks up product information
#'
#' \code{\link{lookup}} gives access to item price and availability in real-time.
#'
#' An API key will be required to run this function and can be acquired by
#' creating an account on the following website
#' \url{https://developer.walmartlabs.com/member}.
#'
#' For more information refer to the original documentation
#' \url{https://developer.walmartlabs.com/docs/read/Home}.
#'
#' Response formats are described at the url
#' \url{https://developer.walmartlabs.com/docs/read/Item_Field_Description}.
#'
#' @param key Your API access key.
#' @param lsPublisherId Your LinkShare Publisher Id.
#' @param id vector of item ids.
#' @param upc upc of the item.
#' @param list_output Indicator for list output.
#' @return A tibble with 15 columns in base response format.
#' @examples
#' \dontrun{
#' key <- "************************"
#'
#' ## Up to 20 ids can be called at once.
#' lookup(id = c(12417882:12417937), key = key)
#'
#' lookup(id = 12417832, key = key)
#'
#' lookup(upc = 10001137891, key = key)
#'
#' ## First argument will be used with conflicting arguments.
#' lookup(id = 12417837, upc = 10001137891, key = key)
#'
#' lookup(id = 12417832, key = key, list_output = TRUE)
#' }
#' @export
lookup <- function(key = auth_cache$KEY, lsPublisherId = NULL, id = NULL, upc = NULL,
                   list_output = FALSE) {

  if(is.null(key)) stop("No arguemnt to 'key'. Use save_walmart_credentials or supply appropriate arguments")

  base_url <- "http://api.walmartlabs.com/v1/items?&format=json"

  if(!is.null(upc)) {
    url <- glue::glue("{base_url}&apiKey={key}&upc={upc}")
  }
  if(!is.null(id)) {
    id <- stringr::str_c(smart_subset(id, 20), collapse = ",")
    url <- glue::glue("{base_url}&apiKey={key}&ids={id}")
  }
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
    purrr::flatten() %>%
    item_base_response()
}
