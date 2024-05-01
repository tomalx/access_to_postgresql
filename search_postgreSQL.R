#######################################

library(sf)

#setwd
setwd("C:\\Users\\tom.alexander1\\OneDrive - West Of England Combined Authority\\Transport\\7.0 Data\\Rscripts\\")

## check whether the 'connec' database connection exists in the global environment
## if not then connect to the database using connect_postgreSQL.R

if(!exists("connec")) {
  # source the connect_postgreSQL.R script
  source("C:\\Users\\tom.alexander1\\OneDrive - West Of England Combined Authority\\Transport\\7.0 Data\\Rscripts\\access_postgresql\\access_to_postgresql\\connect_postgreSQL.R")
  }

# List all of the schemas in the database
all_schemas <- dbGetQuery(connec,"SELECT schema_name FROM information_schema.schemata")

# List all of the tables from a specified schema, for example...
# list all of the tables in the weca schema
weca_tables <- dbGetQuery(connec,"SELECT table_name FROM information_schema.tables WHERE table_schema='weca'")
# or list all of the tables in the swpti schema
swpti_tables <- dbGetQuery(connec,"SELECT table_name FROM information_schema.tables WHERE table_schema='swpti'")


# use st_read and SQL to read in table from specified schema 
# e.g. to get tramways_historical table in the weca schema:
tramways <- st_read(connec,query = "SELECT * FROM weca.tramways_historical")
lcwip_cycling_routes <- st_read(connec,query = "SELECT * FROM weca.lcwip_cycling_routes")

# cycle_lines <- st_read(connec,query = "SELECT * FROM weca.crsts_walkingcycling_lines_join") %>% 
#   # transform to WGS84
#   st_transform(4326)
# 
# cycle_poly <- st_read(connec,query = "SELECT * FROM weca.crsts_walkingcycling_polygons_join") %>%
#   # transform to WGS84
#   st_transform(4326)
# 
# #draw leaflet map with cycle_lines and cycle_poly layers
# leaflet::leaflet() %>% 
#   leaflet::addTiles() %>% 
#   leaflet::addPolygons(data = cycle_poly, color = "red", weight = 2, opacity = 1, fillOpacity = 0.2) %>% 
#   leaflet::addPolylines(data = cycle_lines, color = "blue", weight = 2, opacity = 1) %>% 
#   leaflet::addLegend("bottomright", colors = c("red","blue"), labels = c("poly","lines"), title = "Legend")

#### query bus gps data from prospective ####
congestion <- st_read(connec,query = "SELECT * FROM prospective.congestion FETCH FIRST 20 ROWS ONLY")
congestion_data_periods <- st_read(connec, query = "SELECT DISTINCT data_period FROM prospective.congestion")


