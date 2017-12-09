#' Subsets up to n elements in a vector
#'
#' @param x A vector.
#' @param n A number.
#' @return vector of length equal to length of x or n, whichever is smallest.
#' @examples
#' smart_subset(1:10, 5)
#' smart_subset(1:10, 50)
#' @export
smart_subset <- function(x, n) {
  if(length(x) >= n) {
    x[1:n]
  } else {
    x
  }
}

#' Returns NA if input is null, else returns input
#'
#' @param x A number.
#' @return A number or NA.
#' @examples
#' ifelse_null(NA)
#' ifelse_null(1)
#' @export
ifelse_null <- function(x) {
  ifelse(is.null(x), NA, x)
}

#' Returns tibble of items in base response format
#'
#' response formats are described at the url
#' \url{https://developer.walmartlabs.com/docs/read/Item_Field_Description}.
#'
#' @param x A List.
#' @return A tibble with 15 columns in base response format.
#' @export
item_base_response <- function(x) {
  purrr::map_df(x, ~
                  tibble(itemId = ifelse_null(.$itemId),
                         name = ifelse_null(.$name),
                         msrp = ifelse_null(.$msrp),
                         salePrice = ifelse_null(.$salePrice),
                         upc = ifelse_null(.$upc),
                         categoryPath = ifelse_null(.$categoryPath),
                         longDescription = ifelse_null(.$longDescription),
                         thumbnailImage = ifelse_null(.$thumbnailImage),
                         productTrackingUrl = ifelse_null(.$productTrackingUrl),
                         standardShipRate = ifelse_null(.$standardShipRate),
                         marketplace = ifelse_null(.$marketplace),
                         productUrl = ifelse_null(.$productUrl),
                         availableOnline = ifelse_null(.$availableOnline),
                         offerType = ifelse_null(.$offerType),
                         shippingPassEligible = ifelse_null(.$shippingPassEligible)))
}
