#' Check IP addresses using IPhub API
#' @param data Dataframe containing IP addresses you want to check 
#' @param ip Name of column in Dataframe containing IP addresses
#' @param api_key Your API key obtained from IPhub
#' @return Dataframe with 2 new columns (IPflag and IPcountry). IPflag contains values 0,1, or 2. IPcountry contains country code of IP address.
#' @export

ip_check <- function(data, ip, api_key) {
  if (!requireNamespace("httr", quietly=TRUE)){
    stop("Package 'httr' is required but not installed. ")
  }
  api_endpoint <- "https://v2.api.iphub.info/ip/"
  check_ip <- function(ip) {
    url <- paste0(api_endpoint, ip)
    headers <- c("X-Key" = api_key)
    response <- GET(url, add_headers(headers))
    if (status_code(response) != 200) {
      stop("API request failed with status: ", status_code(response))
    }
    data <- content(response, as = "parsed")
    block <- data$block
    countryCode <- data$countryCode
    result <- list(countryCode = countryCode, block = block)
    return(result)
  }
  ip_addresses <- data[[ip]]
  results <- lapply(ip_addresses, check_ip)
  countryCodes <- sapply(results, function(x) x$countryCode)
  blocks <- sapply(results, function(x) x$block)
  data$IPcountry <- countryCodes
  data$IPflag <- blocks
  return(data)
}
