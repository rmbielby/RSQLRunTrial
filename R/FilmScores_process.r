# FilmScores_process.r
# R.M Bielby
# 19th April 2021
# R script to demo calling and running an SQL script.


library(RODBC)
source('R/utils.R')

upload_film_data <- function(connection, year, datadir='./data/',overwrite=TRUE){
  table_stem   <- 'HomeCinemaScores'
  home_ratings_file <- paste(datadir,table_stem,'_',year,'.csv',sep='')
  cat('Trying to read in from',home_ratings_file,fill=TRUE)
  home_ratings <- read.csv(home_ratings_file)
  sqlTableName <- paste('dbo.',table_stem,'_',year,sep='')
  if (!(substr(sqlTableName,5,100) %in% sqlTables(connection)$TABLE_NAME) | overwrite==TRUE){
      sqlSave(connection, home_ratings, tablename=sqlTableName, rownames=FALSE, fast=TRUE, nastring='NA')
  } else {
      cat("Table ",sqlTableName," already present (overwrite=",overwrite,").",sep="",fill=TRUE)
  }
  
}


args          <- commandArgs(trailingOnly=TRUE)
server        <- args[1]
database      <- args[2]
year          <- args[3]

connection    <- open_connection(server, database)

upload_status <- upload_film_data(connection, year)



close(connection)
