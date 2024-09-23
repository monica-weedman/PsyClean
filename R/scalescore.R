#' Create scale scores
#' @param data Dataframe to create codebook
#' @param items list of items to be combined into a scale score
#' @param method Default= "mean"; can also take "sum"
#' @param newvar Name of new scale score variable to be created
#' @param measure Name of measure being scored
#' @param updatecb Default=TRUE
#' @param cbname Default = "codebook"; Name of codebook to update
#' @param cite Citation for measure being scored
#' @return Data with new column holding scale scores
#' @export

scalescore <- function(data, items, method = "mean", newvar, measure, updatecb = TRUE, cbname = "codebook", cite) {
  if (!all(items %in% names(data))) {
    stop("Some columns in 'items' do not exist in the dataframe.")
  }
  
  if (method == "mean") {
    data[[newvar]] <- rowMeans(data[items], na.rm = TRUE)
  } else if (method == "sum") {
    data[[newvar]] <- rowSums(data[items], na.rm = TRUE)
  } else {
    stop("Unsupported method. Use 'mean' or 'sum'.")
  }
  if (updatecb){
    if (exists(cbname, envir = .GlobalEnv)){
      scoredf <- data.frame(Variable = newvar, 
                          Alias = NA, 
                          Description = measure, 
                          Scoring = paste(method,"of:",paste(items, collapse = ", ")), 
                          Citation = cite)
      existing_cb <- get(cbname, envir = .GlobalEnv)
      updated_cb <- rbind(existing_cb, scoredf)
      assign(cbname, updated_cb, envir = .GlobalEnv)
      message("Codebook updated with new scored variable.")
    }else{
      message("To add scored variable to existing codebook, include argument cbname and provide name of codebook in quotes.")
    }
  }
  return(data)
}


