# Hannah Recht 04-07-16
# Get data from the BLS API - http://www.bls.gov/developers/api_signature_v2.htm#parameters
# Consumer price index for relevant categories

library("readr")
library("jsonlite")
library("dplyr")
library("httr")

blskey <- read_file("/Users/hrecht/Documents/keys/blskey.txt")

# Consumer price index - annual average, non-seasonally adjusted, national
# There's a multiseries API allowance but it's annoying to parse, just call individually
# Can only get 10 years at once
y1 <- list(start=1985, stop=1994)
y2 <- list(start=1995, stop=2004)
y3 <- list(start=2005, stop=2013)
y4 <- list(start=2014, stop=2015)
baseurl <- "http://api.bls.gov/publicAPI/v2/timeseries/data"

getBLS <- function(series) {
	url <- paste(baseurl, series, sep='/')
	dt <- NULL
	for (y in list(y1, y2, y3, y4)) {
		req <- POST(url, query = list("startYear" = y$start, "endYear" = y$stop, "calculations" = "false", "annualaverage" = "true", "catalog" = "false", "registrationKey" = blskey))
		if (req$status_code != 200) {
			print(req$status_code)
			break
		}
		raw <- fromJSON(content(req, as = "text"))
		temp <- raw$Results$series$data[[1]]
		dt <- rbind(dt, temp)
	}
	dt <- dt %>% filter(periodName=="Annual") %>%
		arrange(year) %>% 
		select(year, value)
	return(dt)
	
}
# All items
cpi_all <- getBLS('CUUS0000SA0') %>% 
	rename(cpi_all = value)
# Food and beverages
cpi_food <- getBLS('CUUS0000SAF') %>% 
	rename(cpi_food = value)	
# Housing at school, excluding board
cpi_housing <- getBLS('CUUR0000SEHB01') %>% 
	rename(cpi_collegehousing = value)	
# Rent of primary residence
cpi_rent <- getBLS('CUUS0000SEHA') %>% 
	rename(cpi_rent  = value)	
# College textbooks
cpi_textbooks <- getBLS('CUUR0000SSEA011') %>% 
	rename(cpi_textbooks = value)	
# Recreational books
cpi_recbooks <- getBLS('CUUR0000SERG02') %>% 
  rename(cpi_recbooks = value)	

# College tuition and fees
# cpi_college <- getBLS('CUUR0000SEEB01')

cpi <- left_join(cpi_all, cpi_food, by="year") %>%
	left_join(., cpi_housing, by="year") %>%
	left_join(., cpi_rent, by="year") %>%
	left_join(., cpi_textbooks, by="year")    %>%
  left_join(., cpi_recbooks, by="year") 

write.csv(cpi, "data/cpi_bls.csv", row.names = F, na="")
