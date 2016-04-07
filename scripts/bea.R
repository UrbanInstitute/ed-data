# Hannah Recht 04-07-16
# Get data from the BEA API - http://www.bea.gov/API/signup/index.cfm

library("readr")
library("jsonlite")
library("dplyr")

beakey <- read_file("/Users/Hannah/Documents/keys/beakey.txt")

# Per capita personal income by state and year (unadjusted for inflation)
url <- "http://www.bea.gov/api/data/?&method=GetData&datasetname=RegionalData&KeyCode=PCPI_CI&GeoFIPS=STATE&Year=ALL&ResultFormat=JSON&UserID="
req <- fromJSON(paste0(url, beakey))
income <- req$BEAAPI$Results$Data

# View notes
req$BEAAPI$Results$Notes

# Clean up variables
income <- income %>% rename(name = GeoName, year = TimePeriod, income_pc = DataValue, fips = GeoFips) %>%
	select(fips, name, year, income_pc) %>%
	filter(year >= 1985)

# Remove trailing 0s from state fips
income$fips <- substr(income$fips, 0, 2)

# Include only states and US, not regions
income <- income %>% filter(fips <= 56) %>%
	arrange(fips, year)

write.csv(income, "data/incomepc_bea.csv", na="", row.names = F)