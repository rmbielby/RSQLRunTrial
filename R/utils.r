cat("Hi, you're in the script utils.r",fill=TRUE)


open_connection <- function(server, database){
  con <- RODBC::odbcDriverConnect(
    paste('driver={SQL Server Native Client 11.0};
              server=',server,'; 
              database=',database,'; 
              trusted_connection=Yes', sep=''))
  
  print(con)
  return(con)
}

upload_data <- function(connection, filename, sqlTableName, datadir='./data/',overwrite=FALSE){
  file <- paste(datadir,filename,sep='')
  sqlTableName <- paste('dbo.',sqlTableName,sep='')
  if (!(substr(sqlTableName,5,100) %in% sqlTables(connection)$TABLE_NAME) | overwrite==TRUE){
    cat('Trying to read in from',file,'...  ')
    dfin <- read.csv(file)
    cat('Data read in successfully, now going to check upload to the SQL Server.',fill=TRUE)
    sqlSave(connection, dfin, tablename=sqlTableName, rownames=FALSE, fast=TRUE, nastring='NA')
  } else {
    cat("Table ",sqlTableName," already present (overwrite=",overwrite,").",sep="",fill=TRUE)
  }
  
}
