#' Create a codebook 
#' @param data Dataframe to create codebook
#' @param headers Default = TRUE; Assumes variable names are treated as headers and row 1 contains variable descriptions
#' @param cbname Default = "codebook"; Name of codebook to create 
#' @return Formatted dataframe with 1 header row and codebook with 5 columns (Variable, Alias, Description, Scoring, Citation)
#' @export

createcb<- function(data, headers=TRUE, cbname="codebook") {
  if (headers){
    variable <-as.list(colnames(data))
    description <- data[1, , drop=FALSE]
    data <- data[-1, , drop=FALSE]
    codebook_df <- data.frame(
      Variable = as.character(variable),
      Alias = character(length(variable)),
      Description = as.character(description),
      Scoring = character(length(variable)),
      Citation = character(length(variable))
    )
    assign(cbname, codebook_df, envir= .GlobalEnv)
    return(data)
  }else{
    stop("Please format your dataframe such that variable names are stored as headers and descriptions are stored in row 1.")
  }
  
}





