#' Add exclusion filter variable and annotate reason for exclusion (tbe = to be excluded)
#' @param data Dataframe 
#' @param var1 Name of column to filter (must be enclosed in double quotes)
#' @param val1 Value of var1 to filter
#' @param v1prime Default = FALSE = indicates you want to exclude cases where var1=val1; TRUE = indicates you want to exclude cases where var1 is NOT equal to val1
#' @param var2 Name of 2nd column to filter (must be enclosed in double quotes)
#' @param val2 Value of var2 to filter
#' @param v2prime Default = FALSE = indicates you want to exclude cases where var2=val2; TRUE = indicates you want to exclude cases where var2 is NOT equal to val2
#' @param intersect Default = FALSE = identifies cases meeting criteria for var1 OR var2; TRUE = identifies cases meeting criteria for var 1 AND var2
#' @param updatecb Default = TRUE = updates codebook with new filter variables
#' @param cbname Default = "codebook" = name of codebook to be updated
#' @return Dataframe with exclusion columns
#' @export


tbe <- function(data, var1, val1, v1prime = FALSE, var2, val2, v2prime=FALSE, intersect=FALSE, updatecb=TRUE, cbname="codebook") {
  if (!(var1 %in% names(data))) {
    stop(paste("Column", var1, "not found in data"))
  }
  if (!(var2 %in% names(data))) {
    stop(paste("Column", var2, "not found in data"))
  }
  if(!("exclude" %in% names(data))) {
    data$exclude <- FALSE
  }
  
  var1failname <- paste0(var1, "_fail")
  var2failname <- paste0(var2, "_fail")
  if (!(var1failname %in% names(data))) {
    data[[var1failname]] <- FALSE
  }
  if (!(var2failname %in% names(data))) {
    data[[var2failname]] <- FALSE
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
  data[[var1failname]] <- data[[var1failname]] | condition1
  data[[var2failname]] <- data[[var2failname]] | condition2
  
  if (updatecb){
    if (exists(cbname, envir = .GlobalEnv)){
      tbedf <- data.frame(Variable = c(var1failname, var2failname), 
                         Alias = NA, 
                         Description = c(
                           paste("exclusion variable for",var1), 
                           paste("exclusion variable for", var2)), 
                         Scoring = "TRUE = failed inclusion criteria", 
                         Citation = NA)
      existing_cb <- get(cbname, envir = .GlobalEnv)
      updated_cb <- rbind(existing_cb, tbedf)
      assign(cbname, updated_cb, envir = .GlobalEnv)
      message("Codebook updated with exclusion variables.")
    }else{
      message("To add exclusion variables to existing codebook, include argument cbname and provide name of codebook in quotes.")
    }
  }
  
  return(data)
}

