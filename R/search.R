#' searching with text the Walmart catalogue
#'
#' \code{searching} allows text search on the Walmart.com catalogue and
#'  returns matching items available for sale online.

#' An API key will be required to run this function and can be acquired by
#' creating an account on the following website
#' \url{https://developer.walmartlabs.com/member}.
#'
#' For more information refer to the original documentation
#' \url{https://developer.walmartlabs.com/docs/read/Search_API}.
#'
#' Response formats are described at the url
#' \url{https://developer.walmartlabs.com/docs/read/Item_Field_Description}.
#'
#' @param key Your API access key.
#' @param lsPublisherId Your LinkShare Publisher Id.
#' @param query Search text - whitespace separated sequence of keywords to
#'  search for.
#' @param categoryId Category id of the category for search within a category.
#'  This should match the id field from Taxonomy API.
#' @param start Starting point of the results within the matching set of
#' items - up to 10 items will be returned starting from this item.
#' @param sort Sorting criteria, allowed sort types are (relevance, price,
#'  title, bestseller, customerRating, new). Default sort is by relevance.
#' @param order Sort ordering criteria, allowed values are (asc, desc).
#' This parameter is needed only for the sort types (price, title,
#' customerRating).
#' @param numItems Number of matching items to be returned, max value 25.
#' Default is 10.
#' @param facet Logical. Enables facets. Default value is FALSE.
#' Set this to on to enable facets.
#' @param facet.filter Filter on the facet attribute values. This parameter
#'  can be set to <facet-name>:<facet-value> (without the angles). Here
#'  facet-name and facet-value can be any valid facet picked from the search
#'  API response when facets are on.
#' @param list_output Indicator for list output.
#' @return A tibble with 15 columns in base response format.
#' @examples
#' \dontrun{
#' key <- "************************"
#'
#' searching(query = "ipod", key = key)
#'
#' searching(query = "ipod", key = key, categoryId = 3944)
#'
#' searching(query = "ipod", key = key, start = 44)
#'
#' searching(query = "ipod", key = key, numItems = 44)
#'
#' searching(query = "ipod", key = key, sort = "price", order = "asc")
#'
#' searching(query = "ipod", key = key, sort = "bestseller")
#'
#' searching(query = "ipod", key = key, list_output = TRUE)
#' }
#' @export
searching <- function(query, key = auth_cache$KEY, lsPublisherId = NULL,
                      categoryId = NULL, start = NULL, sort = NULL,
                      order = NULL, numItems = NULL, facet = FALSE,
                      facet.filter = NULL, list_output = FALSE) {

  if(is.null(key)) stop("No arguemnt to 'key'. Use save_walmart_credentials or supply appropriate arguments")

  base_url <- "http://api.walmartlabs.com/v1/search"
  url <- glue::glue("{base_url}?apiKey={key}&query={query}")

  if(!is.null(facet.filter)) {
    url <- glue::glue("{url}&facet.filter={facet.filter}")
  }
  if(facet) {
    url <- glue::glue("{url}&facet=on")
  }
  if(!is.null(numItems)) {
    if(numItems > 25) {
      warning("numItems was larger then 25, set to maximal 25.")
      numItems <- 25
    }
    url <- glue::glue("{url}&numItems={numItems}")
  }
  if(!is.null(order)) {
    url <- glue::glue("{url}&order={order}")
  }
  if(!is.null(sort)) {
    url <- glue::glue("{url}&sort={sort}")
  }
  if(!is.null(start)) {
    url <- glue::glue("{url}&start={start}")
  }
  if(!is.null(categoryId)) {
    url <- glue::glue("{url}&categoryId={categoryId}")
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
    .[["items"]] %>%
    item_base_response()
}
