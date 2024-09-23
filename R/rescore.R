#' Recode and reverse score items
#' @param data Dataframe to create codebook
#' @param vars Name of item to be reverse scored
#' @param old_values List of values present in variable
#' @param new_values Default = NULL
#' @param updatecb Default=TRUE
#' @param cbname Default = "codebook"; Name of codebook to update
#' @return Dataframe with recoded variables 
#' @export

recode_values <- function(data, vars, old_values, new_values = NULL, updatecb = TRUE, cbname = "codebook") {
  # Check if new_values is provided or not, store this condition
  new_values_was_null <- is.null(new_values)
  # If new_values is not provided, reverse old_values
  if (new_values_was_null) {
    new_values <- rev(old_values)
  }
  
  # Check if the lengths of old_values and new_values are the same
  if (length(old_values) != length(new_values)) {
    stop("The length of 'old_values' and 'new_values' must be the same.")
  }
  recode_list <- setNames(new_values, old_values)
  # Loop through each variable (var) in vars and apply the recoding
  for (var in vars) {
    if (new_values_was_null) {
      # Create a new column with recoded values when new_values was NULL
      new_var <- paste0(var, "_r")
      data[[new_var]] <- recode(data[[var]], !!!recode_list, .missing = NULL)
    } else {
      # Recode the original variable if new_values was provided
      data[[var]] <- recode(data[[var]], !!!recode_list, .missing = NULL)
    }
  }
  if (updatecb) {
    if (exists(cbname, envir = .GlobalEnv)) {
      existing_cb <- get(cbname, envir = .GlobalEnv)
      
      for (var in vars) {
        if (new_values_was_null) {
          # Create a new row for the reversed variable
          new_var <- paste0(var, "_r")
          revitems <- data.frame(
            Variable = new_var,
            Alias = var,
            Description = paste("reverse-scored", var),
            Scoring = paste(capture.output(print(recode_list)), collapse = ", "),
            Citation = NA,
            stringsAsFactors = FALSE
          )
          existing_cb <- rbind(existing_cb, revitems)
        } else {
          existing_cb$Scoring[existing_cb$Variable == var] <- paste(capture.output(print(recode_list)), collapse = ", ")
        }
      }
      assign(cbname, existing_cb, envir = .GlobalEnv)
    }
  }
  return(data)
}

