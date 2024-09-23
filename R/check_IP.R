#' Check IP addresses using IPhub API
#' @param data Dataframe containing IP addresses you want to check 
#' @param ip Name of column in Dataframe containing IP addresses
#' @param api_key Your API key obtained from IPhub
#' @param updatecb Default =TRUE; Updates existing codebook with IPflag and IPcountry variables
#' @param cbname Default = "codebook"; Name of codebook to update
#' @return Dataframe with 2 new columns (IPflag and IPcountry). IPflag contains values 0,1, or 2. IPcountry contains country code of IP address.
#' @export

ip_check <- function(data, ip, api_key, updatecb=TRUE, cbname="codebook") {
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
  
  if (updatecb){
    if (exists(cbname, envir = .GlobalEnv)){
      IPdf <- data.frame(Variable = c("IPflag", "IPcountry"), 
                         Alias = NA, 
                         Description = c("IP address type using IPhub schema", "IP address country of origin"), 
                         Scoring = c("0= good, 1 = poor/proxy, 2= mixed", "2-character country code"), 
                         Citation = "iphub.info")
      existing_cb <- get(cbname, envir = .GlobalEnv)
      updated_cb <- rbind(existing_cb, IPdf)
      assign(cbname, updated_cb, envir = .GlobalEnv)
      message("Codebook updated with IPcheck variables.")
    }else{
      message("To add IPflag and IPcountry variables to existing codebook, include argument cbname and provide name of codebook in quotes.")
    }
  }
  return(data)
}
