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

#TEST
test_ip <- ip_check(test_data, "IPAddress", "MjEwNTg6cGV4dE9ySGVBeTlMaktLeEswWEJwS2NsenBJM29TWnE=")


#' Filter data based on IPcountry and IPflag 
#' @param data Dataframe to filter
#' @param cval country code value in 'IPcountry' column you would like to filter by 
#' @param fval value in 'IPflag' column you would like to filter by
#' @param country name of variable containing country codes (must be enclosed in double quotes); defaults to "IPcountry"
#' @param flag name of variable containing flags (must be enclosed in double quotes); defaults to "IPflag"
#' @param exclude Default = FALSE = returns list of cases with specified country code and/or flag values; TRUE = returns data excluding cases with specified country code or flag values
#' @param intersect Default = FALSE = identifies cases not specified country code OR not specified flag; TRUE = identifies cases not specified country code AND not specified flag
#' @return Filtered data excluding cases with specified IPcountry or IPflag values
#' @export

ip_filter <- function(data, cval, fval, country="IPcountry", flag="IPflag", exclude=FALSE, intersect=FALSE) {
  if (intersect) {
    ip_flagged <- data[(data[[country]] != cval & data[[flag]] != fval), ]
    print(paste("Cases identified as non-", cval, "and with flag code other than",fval,":", nrow(ip_flagged)))
  } else {
    ip_flagged <- data[(data[[country]] != cval | data[[flag]] != fval), ]
    print(paste("Cases identified as non-", cval, "or with flag code other than",fval,":", nrow(ip_flagged)))
  }
  if (exclude) {
    filtered_data <- data[!rownames(data) %in% rownames(ip_flagged),]
    print(paste("Returning data excluding IP flagged cases. Count:", nrow(filtered_data)))
    return(filtered_data)
  } else {
    return(ip_flagged)
  }
}

#TEST (exclude = FALSE, intersect= FALSE)
ex_f_inter_f <- ip_filter(test_ip,cval="US",fval=0)
#TEST (exclude = FALSE, intersect= TRUE)
ex_f_inter_t <- ip_filter(test_ip,cval="US",fval=0, intersect=TRUE)
#TEST (exclude = TRUE, intersect= FALSE)
ex_t_inter_f <- ip_filter(test_ip,cval="US",fval=0, exclude=TRUE)

