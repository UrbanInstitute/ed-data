# Hannah Recht, 02-29-16
# Format SLFI tax data (Appropriations category)

library(readxl)
library(dplyr)

states <- read.csv("data/states.csv", stringsAsFactors = F, colClasses = "character")

# Read data downloaded from SLFI - by Martha Johnson
# For total taxes data, go to SLF-DQS, then go to:	
# 1	Create a Table
# 2	State
# 3	Select All (under Pre-Selected Geographic Groupings)
# 4	Add R05 Total Taxes
# 5	Add years 2000 through 2013
# 6	Select Total and Nominal
# 7	Repeat steps 3 through 6 for Local instead of State

stax <- read_excel("data/original/state total tax 2000 to 2013.xlsx", skip=3)
ltax <- read_excel("data/original/local total tax 2000 to 2013.xlsx", skip=3)

stax <- stax[, c(1,2,4)]
colnames(stax) <- c("state", "year", "taxes_state")
ltax <- ltax[, c(1,2,4)]
colnames(ltax) <- c("state", "year", "taxes_local")

taxes <- full_join(stax,ltax, by=c("state","year"))
# Remove empty rows and rows with notes (not data)
taxes <- taxes %>% filter(!is.na(year))
# Add fips code
taxes <- left_join(taxes, states, by="state")
# DC is named as "DC", not "District of Columbia"
taxes <- taxes %>% mutate(statefip = ifelse(state=="DC", "11", statefip)) %>% 
  select(-state) %>%
  select(statefip, year, everything())
write.csv(taxes, "data/taxes_slfi.csv", row.names=F, na="")