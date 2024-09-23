#' Recode and reverse score items
#' @param data Dataframe to create codebook
#' @param vars Name of item to be reverse scored
#' @param old List of values present in variable
#' @param new Default = NULL
#' @param updatecb Default=TRUE
#' @param cbname Default = "codebook"; Name of codebook to update
#' @return Dataframe with recoded variables 
#' @export

rescore <- function(data, vars, old, new = NULL, updatecb = TRUE, cbname = "codebook") {
  if ("dplyr" %in% installed.packages() == FALSE) {
    install.packages("dplyr")
  }
  library(dplyr)
  # Check if new is provided or not, store this condition
  new_was_null <- is.null(new)
  # If new is not provided, reverse old
  if (new_was_null) {
    new <- rev(old)
  }
  
  # Check if the lengths of old and new are the same
  if (length(old) != length(new)) {
    stop("The length of 'old' and 'new' must be the same.")
  }
  recode_list <- setNames(new, old)
  # Loop through each variable (var) in vars and apply the recoding
  for (var in vars) {
    if (new_was_null) {
      # Create a new column with recoded values when new was NULL
      new_var <- paste0(var, "_r")
      data[[new_var]] <- dplyr::recode(data[[var]], !!!recode_list, .missing = NULL)
    } else {
      # Recode the original variable if new was provided
      data[[var]] <- dplyr::recode(data[[var]], !!!recode_list, .missing = NULL)
    }
  }
  if (updatecb) {
    if (exists(cbname, envir = .GlobalEnv)) {
      existing_cb <- get(cbname, envir = .GlobalEnv)
      
      for (var in vars) {
        if (new_was_null) {
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

