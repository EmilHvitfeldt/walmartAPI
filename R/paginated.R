#' Looks up product information
#'
#' \code{\link{lookup}} gives access to item price and availability in
#' real-time.
#'
#' An API key will be required to run this function and can be aqquired by
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
#' @param category Category id of the desired category. This should match the
#' id field from \code{\link{taxonomy}} function.
#' @param brand Brand name.
#' @param specialOffer Special offers like (rollback, clearance, specialBuy).
#' @param list_output Indicator for list output.
#' @return A tibble with 16 columns. Firsst 15 is the items in base response
#' format, followed by a column containing the URL path for the next page.
#' @examples
#' \dontrun{
#' key <- "************************"
#'
#' paginted(key = key, brand = "Apple")
#'
#' paginted(key = key, category = 3944)
#'
#' paginted(key = key, category = 3944, specialOffer = "rollback")
#'
#' paginted(key = key, brand = "Apple", list_output = TRUE)
#' }
#' @export
paginted <- function(key = auth_cache$KEY, lsPublisherId = NULL,
                     category = NULL, brand = NULL, specialOffer = NULL,
                     list_output = FALSE) {

  if(is.null(key)) stop("No arguemnt to 'key'. Use save_walmart_credentials or supply appropriate arguments")

  base_url <- "http://api.walmartlabs.com/v1/paginated/items"
  url <- glue::glue("{base_url}?apiKey={key}")

  if(!is.null(specialOffer)) {
    url <- glue::glue("{url}&specialOffer={specialOffer}")
  }
  if(!is.null(brand)) {
    url <- glue::glue("{url}&brand={brand}")
  }
  if(!is.null(category)) {
    url <- glue::glue("{url}&category={category}")
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
    item_base_response() %>%
    dplyr::mutate(next_page = response %>% httr::content() %>% .$nextPage)
}
