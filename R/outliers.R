#' Check for outliers
#' @param data Dataframe containing column to check for outliers
#' @param var Name of column to check for outliers (must be enclosed in double quotes)
#' @param threshold Number in standard deviation units to act as upper and lower bound for outliers
#' @param exclude Default = FALSE = returns list of outliers; TRUE= returns data excluding outliers
#' @export

#Add 'new' parameter. When FALSE, extreme returns list of outliers. When TRUE, extreme returns original df excluding outliers
extreme <- function(data, var, threshold, exclude=FALSE) {
  mean_x <- mean(data[[var]], na.rm = TRUE)
  sd_x <- sd(data[[var]], na.rm = TRUE)
  lower_bound <- mean_x - threshold * sd_x
  upper_bound <- mean_x + threshold * sd_x
  extreme_cases <- data[!is.na(data[[var]]) & (data[[var]] < lower_bound | data[[var]] > upper_bound), ]
  print(paste("Mean of",var,":",mean_x))
  print(paste("Standard deviation of",var,":",sd_x))
  print(paste("Cases exceeding", threshold, "SDs from the mean:", nrow(extreme_cases)))
  if (exclude) {
    non_extreme_cases <- data[!rownames(data) %in% rownames(extreme_cases), ]
    print(paste("Returning data excluding extreme cases. Count:", nrow(non_extreme_cases)))
    return(non_extreme_cases)
  } else {
    return(extreme_cases)
  }
}