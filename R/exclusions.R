#' Add exclusion filter variable and annotate reason for exclusion (tbe = to be excluded)
#' @param data Dataframe 
#' @param var1 Name of column to filter (must be enclosed in double quotes)
#' @param val1 Value of var1 to filter
#' @param v1prime Default = FALSE = indicates you want to exclude cases where var1=val1; TRUE = indicates you want to exclude cases where var1 is NOT equal to val1
#' @param var2 Name of 2nd column to filter (must be enclosed in double quotes)
#' @param val2 Value of var2 to filter
#' @param v2prime Default = FALSE = indicates you want to exclude cases where var2=val2; TRUE = indicates you want to exclude cases where var2 is NOT equal to val2
#' @param reason Character string annotating reason for exclusion
#' @param intersect Default = FALSE = identifies cases meeting criteria for var1 OR var2; TRUE = identifies cases meeting criteria for var 1 AND var2
#' @return Dataframe with exclude and reason columns
#' @export


tbe <- function(data, var1, val1, v1prime = FALSE, var2, val2, v2prime=FALSE, reason, intersect=FALSE) {
  if (!(var1 %in% names(data))) {
    stop(paste("Column", var1, "not found in data"))
  }
  if (!(var2 %in% names(data))) {
    stop(paste("Column", var2, "not found in data"))
  }
  if(!("exclude" %in% names(data))) {
    data$exclude <- FALSE
  }
  
  condition1 <- if (v1prime) {
    data[[var1]] != val1
  }else {
    data[[var1]] == val1
  }
  condition2 <- if(v2prime) {
    data[[var2]] != val2
  }else {
    data[[var2]] == val2
  }
  
  if(intersect){
    rows_to_exclude <- condition1 & condition2
  }else{
    rows_to_exclude <- condition1 | condition2
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

