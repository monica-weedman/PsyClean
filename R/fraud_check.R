#' Screen for bots using Qualtrics bot detection parameters
#' @param data Dataframe
#' @param recaptcha Name of reCAPTCHA variable; defaults to Q_RecaptchaScore, assuming Qualtrics naming scheme
#' @param relID Name of RelevantID fraud variable; defaults to Q_RelevantIDFraudScore, assuming Qualtrics naming scheme
#' @param rclimit reCAPTCHA threshold used for exclusion; defaults to 0.5; cases scoring less than this value will be excluded
#' @param relIDlimit RelevantID threshold used for exclusion; defaults to 30; cases scoring greater than or equal to this value will be excluded
#' @param intersect Default = FALSE = identifies cases based on recaptcha OR relID; TRUE = identifies cases based on recaptcha AND relID
#' @param updatecb Default = TRUE = updates codebook with CAPTCHA_fail and relID_fail variables
#' @param cbname Default = "codebook" = name of codebook to be updated
#' @return Dataframe with CAPTCHA_fail and relID_fail columns
#' @export 

#Assumes Qualtrics bot detection default naming scheme (Q_RecaptchaScore, Q_RelevantIDFraudScore, etc.) and thresholds.
#Specify variable names if deviating from Qualtrics scheme.
#reCaptcha threshold default to < .5, RelevantIDFraudScore threshold default to > 30. Change values of rclimit and relIDlimit to adjust.

fraud_check <- function(data, recaptcha="Q_RecaptchaScore", relID="Q_RelevantIDFraudScore", rclimit = .5, relIDlimit= 30, intersect=FALSE, updatecb=TRUE, cbname="codebook"){
  if (!(recaptcha %in% names(data))) {
    stop(paste("Column", recaptcha, "not found in data"))
  }
  if (!(relID %in% names(data))) {
    stop(paste("Column", relID, "not found in data"))
  }
  if(!("exclude" %in% names(data))) {
    data$exclude <- FALSE
  }
  if(!("CAPTCHA_fail" %in% names(data))) {
    data$CAPTCHA_fail <- FALSE
  }
  if(!("relID_fail" %in% names(data))) {
    data$relID_fail <- FALSE
  }
  
   if (intersect) {
    rows_to_exclude <- (!is.na(data[[recaptcha]]) & data[[recaptcha]] < rclimit) & (!is.na(data[[relID]]) & data[[relID]] >= relIDlimit)
  } else {
    rows_to_exclude <- (!is.na(data[[recaptcha]]) & data[[recaptcha]] < rclimit) | (!is.na(data[[relID]]) & data[[relID]] >= relIDlimit)
  }

  captcha_exclude <- (!is.na(data[[recaptcha]]) & data[[recaptcha]] < rclimit)
  data$CAPTCHA_fail <- data$CAPTCHA_fail | captcha_exclude
  relID_exclude <- (!is.na(data[[relID]]) & data[[relID]] >= relIDlimit)
  data$relID_fail <- data$relID_fail | relID_exclude
  data$exclude <- data$exclude | rows_to_exclude
  
  if (updatecb){
    if (exists(cbname, envir = .GlobalEnv)){
      frauddf <- data.frame(Variable = c("CAPTCHA_fail", "relID_fail"), 
                          Alias = NA, 
                          Description = c(
                            paste("exclusion variable for",recaptcha), 
                            paste("exclusion variable for", relID)), 
                          Scoring = c(
                            paste("TRUE = failed inclusion criteria",recaptcha,"<",rclimit),
                            paste("TRUE = failed inclusion criteria",relID,">=",relIDlimit)), 
                          Citation = NA)
      existing_cb <- get(cbname, envir = .GlobalEnv)
      updated_cb <- rbind(existing_cb, frauddf)
      assign(cbname, updated_cb, envir = .GlobalEnv)
      message("Codebook updated with exclusion variables.")
    }else{
      message("To add exclusion variables to existing codebook, include argument cbname and provide name of codebook in quotes.")
    }
  }
  
  return(data)
}

