#' Screen for bots using Qualtrics bot detection parameters
#' @param data Dataframe containing bot detection variables
#' @param recaptcha Name of reCAPTCHA variable; defaults to Q_RecaptchaScore, assuming Qualtrics naming scheme
#' @param relID Name of RelevantID fraud variable; defaults to Q_RelevantIDFraudScore, assuming Qualtrics naming scheme
#' @param rclimit reCAPTCHA yhreshold to use for flagging responses; defaults to 0.5; cases scoring less than this value will be flagged
#' @param relIDlimit RelevantID threshold to use for flagging responses; defaults to 30; cases scoring greater than or equal to this value will be flagged
#' @param exclude Default = FALSE = identifies cases that are likely bots based on recaptcha/relID thresholds set; TRUE = returns data excluding likely bots
#' @param intersect Default = FALSE = identifies cases based on recaptcha OR relID; TRUE = identifies cases based on recaptcha AND relID
#' @export 

#Assumes Qualtrics bot detection default naming scheme (Q_RecaptchaScore, Q_RelevantIDFraudScore, etc.) and thresholds.
#Specify variable names if deviating from Qualtrics scheme.
#reCaptcha threshold default to < .5, RelevantIDFraudScore threshold default to > 30. Change values of rclimit and relIDlimit to adjust.

fraud_check <- function(data, recaptcha="Q_RecaptchaScore", relID="Q_RelevantIDFraudScore", rclimit = .5, relIDlimit= 30, exclude=FALSE, intersect=FALSE){
  if (intersect) {
    likely_bot <- data[!is.na(data[[recaptcha]]) & (data[[recaptcha]] < rclimit) & !is.na(data[[relID]]) & (data[[relID]] >= relIDlimit), ]
    print(paste("Number of cases flagged as potential fraud based on set parameters (",recaptcha,"<",rclimit,"&", relID,"≥",relIDlimit,"):", nrow(likely_bot)))
  } else {
    likely_bot <- data[!is.na(data[[recaptcha]]) & (data[[recaptcha]] < rclimit) | !is.na(data[[relID]]) & (data[[relID]] >= relIDlimit), ]
    print(paste("Number of cases flagged as potential fraud based on set parameters (",recaptcha,"<",rclimit,"or", relID,"≥",relIDlimit,"):", nrow(likely_bot)))
  }
  if (exclude) {
    not_likely_bot <- data[!rownames(data) %in% rownames(likely_bot), ]
    print(paste("Returning data excluding likely bots. Count:", nrow(not_likely_bot)))
    return(not_likely_bot)
  }else {
    return(likely_bot)
  }
}

