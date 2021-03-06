# *******************************************************
# -----------------INSTRUCTIONS -------------------------
# *******************************************************
#
#-----------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------
# This CodeToRun.R is provided as an example of how to run this package.
# Below you will find 3 sections: the 1st is for installing the dependencies 
# required to run the package and the 2nd for setting your database details,
# and the 3rd for running the package.
#
# The code below makes use of R environment variables (denoted by "Sys.getenv(<setting>)") to 
# allow for protection of sensitive information. If you'd like to use R environment variables stored
# in an external file, this can be done by creating an .Renviron file in the root of the folder
# where you have cloned this code. For more information on setting environment variables please refer to: 
# https://stat.ethz.ch/R-manual/R-devel/library/base/html/readRenviron.html
#
#
# Below is an example .Renviron file's contents: (please remove)
# the "#" below as these too are interprted as comments in the .Renviron file:
#
#    DBMS = "postgresql"
#    DB_SERVER = "database.server.com"
#    DB_PORT = 5432
#    DB_USER = "database_user_name_goes_here"
#    DB_PASSWORD = "your_secret_password"
#    FFTEMP_DIR = "E:/fftemp"
#    CONNECTION_STRING = <optional>
#
# The following describes the settings
#    DBMS, DB_SERVER, DB_PORT, DB_USER, DB_PASSWORD := These are the details used to connect
#    to your database server. For more information on how these are set, please refer to:
#    http://ohdsi.github.io/DatabaseConnector/
#
#    FFTEMP_DIR = A directory where temporary files used by the FF package are stored while running.
#.
#
# Once you have established an .Renviron file, you must restart your R session for R to pick up these new
# variables. 
#
# In section 2 below, you will also need to update the code to use your site specific values. Please scroll
# down for specific instructions.
#-----------------------------------------------------------------------------------------------
#
# 
# *******************************************************
# SECTION 1: Make sure to install all dependencies (not needed if already done) 
# *******************************************************
# 
# Prevents errors due to packages being built for other R versions: 
Sys.setenv("R_REMOTES_NO_ERRORS_FROM_WARNINGS" = TRUE)
# 
# First, it probably is best to make sure you are up-to-date on all existing packages.
# Important: This code is best run in R, not RStudio, as RStudio may have some libraries
# (like 'rlang') in use.
#update.packages(ask = "graphics")

# When asked to update packages, select '1' ('update all') (could be multiple times)
# When asked whether to install from source, select 'No' (could be multiple times)
#install.packages("devtools")
#devtools::install_github("EHDEN/CatalogueExport")

# *******************************************************
# SECTION 2: Setting Database Specific Variables 
# *******************************************************

# Optional: specify where the temporary files (used by the ff package) will be created:
fftempdir <- if (Sys.getenv("FFTEMP_DIR") == "") "~/fftemp" else Sys.getenv("FFTEMP_DIR")
options(fftempdir = fftempdir)

# Details for connecting to the server:
dbms = Sys.getenv("DBMS")
user <- if (Sys.getenv("DB_USER") == "") NULL else Sys.getenv("DB_USER")
password <- if (Sys.getenv("DB_PASSWORD") == "") NULL else Sys.getenv("DB_PASSWORD")
server = Sys.getenv("DB_SERVER")
port = Sys.getenv("DB_PORT")
connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = dbms,
                                                                server = server,
                                                                user = user,
                                                                password = password,
                                                                port = port)

# Or use the connectionString if provided.
# connectionString = Sys.getenv("CONNECTION_STRING")
# connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = dbms,
#                                                                 server = server,
#                                                                 user = user,
#                                                                 password = password,
#                                                                 connectionString = connectionString)

# For Oracle: define a schema that can be used to emulate temp tables:
oracleTempSchema <- NULL

# Details specific to the database:
databaseId <- "<your_databaseId>"
databaseName <- "<your_databaseName>"
databaseDescription <- "<your_databaseDescription>"

# Details for connecting to the CDM and storing the results
outputFolder <- file.path("~/Documents/Results", databaseId)
cdmDatabaseSchema <- "<your_cdmDatabaseSchema>"
vocabDatabaseSchema <- "<your_vocabDatabaseSchema>"
resultsDatabaseSchema <- "<your_resultsDatabaseSchema>" 


# *******************************************************
# SECTION 3: Running the package 
# *******************************************************
library(CatalogueExport)
catalogueExport(connectionDetails, 
                cdmDatabaseSchema = cdmDatabaseSchema, 
                resultsDatabaseSchema = resultsDatabaseSchema,
                vocabDatabaseSchema = vocabDatabaseSchema,
                sourceName = databaseName, 
                cdmVersion = "5.3.0")
