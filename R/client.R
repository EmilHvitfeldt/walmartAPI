#' Save API credentials for later use
#'
#' This functions caches the credentials to avoid need for entering it when
#' calling other functions
#' @param app_key application key
#' @examples
#' # since not checking is preformed not to waste API calls
#' # it falls on the user to save correct information
#' save_walmart_credentials("APP_KEY")
#' @export
save_walmart_credentials <- function(app_key) {
  if (app_key != "") {
    assign("KEY", app_key, envir = auth_cache)
  }
}
