#' The category taxonomy used by walmart.com to categorize items
#'
#' This function returns the top level of catagories only, for further levels
#' run function with \code{list_output = FALSE} for nested list.
#'
#' \code{\link{taxonomy}} gives returns the category taxonomy used by
#' walmart.com to categorize items.
#'
#' An API key will be required to run this function and can be aqquired by
#' creating an account on the following website
#' \url{https://developer.walmartlabs.com/member}.
#'
#' For more information refer to the original documentation
#' \url{https://developer.walmartlabs.com/docs/read/Taxonomy_API}.
#'
#' @param key Your API access key.
#' @param list_output Indicator for list output.
#' @return A tibble with 15 columns in base response format.
#' @examples
#' \dontrun{
#' key <- "************************"
#'
#' taxonomy(key = key)
#'
#' taxonomy(key = key, list_output = TRUE)
#'}
#' @export
taxonomy <- function(key = auth_cache$KEY, list_output = FALSE) {

  if(is.null(key)) stop("No arguemnt to 'key'. Use save_walmart_credentials or supply appropriate arguments")

  url <- glue::glue("http://api.walmartlabs.com/v1/taxonomy?apiKey={key}")

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
    purrr::map_df(~ tibble::tibble(id = .x$id,
                                   name = .x$name))
}
