#' Rename variables 
#' @param data Dataframe
#' @param old Variable to rename
#' @param new New name for variable
#' @param updatecb Default=TRUE
#' @param cbname Default = "codebook"; Name of codebook to update
#' @return Dataframe with renamed variable
#' @export

rename <- function(data, old, new, updatecb=TRUE,cbname="codebook"){
  colnames(data)[colnames(data)== old] <- new
  if (updatecb){
    if (exists(cbname, envir = .GlobalEnv)){
      existing_cb <- get(cbname, envir = .GlobalEnv)
      existing_cb$Alias[existing_cb$Variable == old] <- old
      existing_cb$Variable[existing_cb$Variable == old] <- new
      assign(cbname, existing_cb, envir = .GlobalEnv)
    }else{
      message("To update variable name in existing codebook, provide name of codebook to cbname argument.")
    }
  }
  return(data)
}