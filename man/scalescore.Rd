% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scalescore.R
\name{scalescore}
\alias{scalescore}
\title{Create scale scores}
\usage{
scalescore(
  data,
  items,
  method = "mean",
  newvar,
  measure,
  updatecb = TRUE,
  cbname = "codebook",
  cite
)
}
\arguments{
\item{data}{Dataframe to create codebook}

\item{items}{list of items to be combined into a scale score}

\item{method}{Default= "mean"; can also take "sum"}

\item{newvar}{Name of new scale score variable to be created}

\item{measure}{Name of measure being scored}

\item{updatecb}{Default=TRUE}

\item{cbname}{Default = "codebook"; Name of codebook to update}

\item{cite}{Citation for measure being scored}
}
\value{
Data with new column holding scale scores
}
\description{
Create scale scores
}
