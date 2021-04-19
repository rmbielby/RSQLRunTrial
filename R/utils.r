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