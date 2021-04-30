# FilmScores_process.r
# Rich Bielby
# 19th April 2021
# R script to demo calling and running an SQL script.
# Run with the command:
# Rscript

library(RODBC)
source('R/utils.R')


args          <- commandArgs(trailingOnly=TRUE)
server        <- args[1]
database      <- args[2]
year          <- args[3]

connection    <- open_connection(server, database)

fn_revbal     <- paste('CFR_RevenueBalance_Schools_NE_',year,'.csv',sep='')
tb_revbal     <- paste('CFR_RevenueBalance_NE_',year,sep='')

upload_status <- upload_data(connection, fn_revbal, tb_revbal)



close(connection)
