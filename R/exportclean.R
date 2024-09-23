#' Export clean data and codebook
#' @param data Dataframe to create codebook
#' @param name Path name for exported file(s)
#' @param filetype Default = "csv"; "sav" exports .sav file (for use with SPSS), "all" exports .sav and .csv files
#' @param version Default = "all"; "annotated" exports de-identified data with no exclusions, "clean" exports de-identified data with exclusions, "plain" exports data in current format
#' @param idcols List of identifying columns to be excluded when de-identifying data; Default = c("IPAddress","LocationLatitude","LocationLongitude","ExternalReference","RecipientFirstName","RecipientLastName","RecipientEmail")
#' @param usecb Default = TRUE; use "Description" column in codebook as labels in .sav exports
#' @param cbname Default = "codebook"; name of codebook to use
#' @param exportcb Default = TRUE; exports codebook as .csv
#' @export


export <- function(data, name, filetype = "csv", version = "all", idcols = c("IPAddress","LocationLatitude","LocationLongitude","ExternalReference","RecipientFirstName","RecipientLastName","RecipientEmail"), usecb = TRUE,cbname = "codebook", exportcb=TRUE) {
  if ("haven" %in% installed.packages() == FALSE) {
    install.packages("haven")
  }
  library(haven)
  exported_files <- c()
  # Apply labels from codebook for .sav export
  if(usecb){
    apply_codebook_labels <- function(data, cbname) {
      if (exists(cbname)) {
        codebook <- get(cbname)
        if ("Description" %in% colnames(codebook)) {
          for (col in intersect(names(data), codebook$Variable)) {
            attr(data[[col]], "label") <- codebook$Description[codebook$Variable == col]
          }
        }
      }
      return(data)
    }
  }
  
  # Remove unwanted columns for 'annotated' and 'clean' versions
  remove_columns <- function(data, cols_to_remove) {
    data <- data[ , !(names(data) %in% cols_to_remove)]
    return(data)
  }
  
  # Create clean version of the data
  create_clean <- function(data, idcols) {
    clean_data <- remove_columns(data, idcols)
    clean_data <- clean_data[clean_data$exclude != TRUE, ]
    return(clean_data)
  }
  
  # Create annotated version of the data
  create_annotated <- function(data, idcols) {
    annotated_data <- remove_columns(data, idcols)
    return(annotated_data)
  }
  
  # Export data as specified filetype
  export_data <- function(data, name, filetype) {
    if (filetype == "csv" || filetype == "all") {
      csv_name <- paste0(name, ".csv")
      write.csv(data, paste0(name, ".csv"), row.names = FALSE)
      exported_files <<- c(exported_files, csv_name)
    }
    if (filetype == "sav" || filetype == "all") {
      data_sav <- apply_codebook_labels(data, cbname)
      names(data_sav) <- gsub("\\.", "_", names(data_sav))
      sav_name <- paste0(name, ".sav")
      write_sav(data_sav, paste0(name, ".sav"))
      exported_files <<- c(exported_files, sav_name)
    }
  }
  
  # Handling different versions
  if (version == "plain" || version == "all") {
    export_data(data, paste0(name, "_plain"), filetype)
  }
  
  if (version == "annotated" || version == "all") {
    annotated_data <- create_annotated(data, idcols)
    export_data(annotated_data, paste0(name, "_annotated"), filetype)
  }
  
  if (version == "clean" || version == "all") {
    clean_data <- create_clean(data, idcols)
    export_data(clean_data, paste0(name, "_clean"), filetype)
  }
  
  if(exportcb){
    codebook_name <- paste0(name, "_codebook.csv")
    write.csv(cbname, paste0(name, "_codebook.csv"))
  }
  message("Exported files: ", paste(exported_files, collapse = ", "),",",codebook_name)
}

