% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rescore.R
\name{recode_values}
\alias{recode_values}
\title{Recode and reverse score items}
\usage{
recode_values(
  data,
  vars,
  old_values,
  new_values = NULL,
  updatecb = TRUE,
  cbname = "codebook"
)
}
\arguments{
\item{data}{Dataframe to create codebook}

\item{vars}{Name of item to be reverse scored}

\item{old_values}{List of values present in variable}

\item{new_values}{Default = NULL}

\item{updatecb}{Default=TRUE}

\item{cbname}{Default = "codebook"; Name of codebook to update}
}
\value{
Dataframe with recoded variables
}
\description{
Recode and reverse score items
}
