# FilmScores_process.r
# R.M Bielby
# 19th April 2021
# R script to demo calling and running an SQL script.

args <- commandArgs(trailingOnly=TRUE)

library(RODBC)

source('R/utils.R')

cat("Hi, you're in the script FilmScores_process.r",fill=TRUE)
cat("These are the args:",fill=TRUE)
print(args)

server <- args[1]
database <- args[2]
connection <- open_connection(server, database)

close(con)
