#' Screen for bots using Qualtrics bot detection parameters
#' @param data Dataframe
#' @param recaptcha Name of reCAPTCHA variable; defaults to Q_RecaptchaScore, assuming Qualtrics naming scheme
#' @param relID Name of RelevantID fraud variable; defaults to Q_RelevantIDFraudScore, assuming Qualtrics naming scheme
#' @param rclimit reCAPTCHA threshold used for exclusion; defaults to 0.5; cases scoring less than this value will be excluded
#' @param relIDlimit RelevantID threshold used for exclusion; defaults to 30; cases scoring greater than or equal to this value will be excluded
#' @param reason Character strong annotating reason for exclusion; defaults to "Likely fraudulent response"
#' @param intersect Default = FALSE = identifies cases based on recaptcha OR relID; TRUE = identifies cases based on recaptcha AND relID
#' @return Dataframe with exclude and reason columns
#' @export 

#Assumes Qualtrics bot detection default naming scheme (Q_RecaptchaScore, Q_RelevantIDFraudScore, etc.) and thresholds.
#Specify variable names if deviating from Qualtrics scheme.
#reCaptcha threshold default to < .5, RelevantIDFraudScore threshold default to > 30. Change values of rclimit and relIDlimit to adjust.

fraud_check <- function(data, recaptcha="Q_RecaptchaScore", relID="Q_RelevantIDFraudScore", rclimit = .5, relIDlimit= 30, reason="Likely fraudulent response", intersect=FALSE){
  if (!(recaptcha %in% names(data))) {
    stop(paste("Column", recaptcha, "not found in data"))
  }
  if (!(relID %in% names(data))) {
    stop(paste("Column", relID, "not found in data"))
  }
  if(!("exclude" %in% names(data))) {
    data$exclude <- FALSE
  }
  
  
   if (intersect) {
    rows_to_exclude <- (!is.na(data[[recaptcha]]) & data[[recaptcha]] < rclimit) & (!is.na(data[[relID]]) & data[[relID]] >= relIDlimit)
  } else {
    rows_to_exclude <- (!is.na(data[[recaptcha]]) & data[[recaptcha]] < rclimit) | (!is.na(data[[relID]]) & data[[relID]] >= relIDlimit)
  }

  data$exclude <- data$exclude | rows_to_exclude
  
  find_reason_column <- function(data) {
    reason_cols <- grep("^reason", names(data), value = TRUE)
    if (length(reason_cols) == 0) {
      return("reason1")
    }
    for (col in reason_cols) {
      if (all(is.na(data[[col]]))) {
        return(col)
      }
    }
    return(paste0("reason", length(reason_cols) + 1))
  }
  
  reason_col <- find_reason_column(data)
  if(!(reason_col %in% names(data))) {
    data[[reason_col]] <- NA
  }
  
  data[[reason_col]][rows_to_exclude] <- reason
  
  return(data)
}

