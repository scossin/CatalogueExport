% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CatalogueExport.R
\name{dropAllScratchTables}
\alias{dropAllScratchTables}
\title{Drop all possible scratch tables}
\usage{
dropAllScratchTables(
  connectionDetails,
  scratchDatabaseSchema,
  tempPrefix = "tmpach",
  numThreads = 1,
  tableTypes = "catalogueExport",
  outputFolder,
  verboseMode = TRUE
)
}
\arguments{
\item{connectionDetails}{An R object of type \code{connectionDetails} created using the function \code{createConnectionDetails} in the \code{DatabaseConnector} package.}

\item{scratchDatabaseSchema}{string name of database schema that CatalogueExport scratch tables were written to.}

\item{tempPrefix}{The prefix to use for the "temporary" (but actually permanent) CatalogueExport analyses tables. Default is "tmpach"}

\item{numThreads}{The number of threads to use to run this function. Default is 1 thread.}

\item{tableTypes}{The types of scratch tables to drop: catalogueExport}

\item{outputFolder}{Path to store logs and SQL files}

\item{verboseMode}{Boolean to determine if the console will show all execution steps. Default = TRUE}
}
\description{
Drop all possible scratch tables
}
\details{
Drop all possible CatalogueExport scratch tables
}
