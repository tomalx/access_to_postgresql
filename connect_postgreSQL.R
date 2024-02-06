### script to connect to Theo's GIS PostgreSQL database


## If not installed, install RPostgres, DBI and tidyverse packages
if(!require(RPostgres)) install.packages("RPostgres")
if(!require(DBI)) install.packages("DBI")
if(!require(tidyverse)) install.packages("tidyverse")

## specify credentials for database (provided by Theo)
## read in postgresql credentials
path <- "C:\\Users\\tom.alexander1\\OneDrive - West Of England Combined Authority\\Shared Documents - GIS\\General\\Technical\\pg_credentials"
credentials <- read_lines(file = paste0(path, "\\GIS_database_credentials.txt"))
credentials <- credentials[10:14]
credentials <- read.delim(text = credentials, sep = ":", header = FALSE)

credentials2 <- data.frame(t(credentials[-1]))
colnames(credentials2) <- credentials[,1]
credentials2[1,] <- str_trim(credentials2[1,])
credentials <- credentials2
rm(credentials2)


tryCatch({
  #drv <- dbDriver("PostgreSQL")
  print("Connecting to GIS Database…")
  connec <- dbConnect(RPostgres::Postgres(),
                      host = credentials[,"host name/server name"],
                      dbname = credentials[,"database name"],
                      user = credentials[,"user name"],
                      password = credentials[,"pass"])
  print("Database Connected! :D")
},
error=function(cond) {
  print("Oh dear. Something has gone wrong. Unable to connect to GIS Database.")
})

# remove values beginning with "dsn_" from global environment (using stringr syntax)
rm(list = ls()[stringr::str_detect(ls(), "^dsn_")])
rm(credentials, path)


