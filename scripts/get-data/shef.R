# Get data from the State Higher Education Officers Association SHEF (State Higher Education Finance)
# http://www.sheeo.org/projects/shef-fy15

library(openxlsx)
library(dplyr)
library(stringr)

# OLD DATA
# Excel file emailed to Martha from source
# shef <- read_excel("data/original/SHEF nominal data by state.xlsx", sheet = 1)

states <- read.csv("data/states.csv", stringsAsFactors = F, colClasses = "character")
states <- states %>% select(-abbrev)

# Download FY 2015 report data (released May 2016)
download.file("http://www.sheeo.org/sites/default/files/Unadjusted_Nominal_Data_FY15.xlsx","data/original/SHEF_Unadjusted_Nominal_Data_FY15.xlsx")
# Excel file uses multi-row merged col heads...when new data is released, make sure to double check col heads and rows needed
shef <- readWorkbook("data/original/SHEF_Unadjusted_Nominal_Data_FY15.xlsx", startRow = 8)
# Column names
shef <- shef %>% rename(appropriations_local = X10, appropriations_net = X12, enrollment_fte = X16, state = State, year_fiscal = FY) %>%
  select(state, year_fiscal, appropriations_local, appropriations_net, enrollment_fte) %>%
  # Calculated variable - state appropriations. Shef has a similar column but they subtract some research money, which we don't want to do.
  mutate(appropriations_state = appropriations_net - appropriations_local)
  
# Join to fips codes
shef <- left_join(shef, states, by="state")

# Make national rows
national <- shef %>% group_by(year_fiscal) %>%
	summarize_each(funs(sum), -fips, -state) %>%
	mutate(fips = "00", state = "United States")
shef <- rbind(shef, national)

# Fiscal year 2010 = 2009-2010: so based on our income inflation rules we'll be using the 2009 CPI for FY 2010
# We'll want axis ticks to be labelled as '09-'10
shef <- shef %>% mutate(year_cpi = year_fiscal - 1, 
                        year_axis = paste("'", str_sub(year_cpi, start = -2), "–'", str_sub(year_fiscal, start = -2), sep=""))

########################################################################################################
# State and local support for higher education: use appropriations_tax (state) and appropriations_local
# Add cpi to age dollar amounts to latest data year
########################################################################################################
cpi <- read.csv("data/cpi_bls.csv", stringsAsFactors = F)
cpi <- cpi %>% select(year, cpi_all)

cpi2014 <- cpi$cpi_all[cpi$year==2014]
shef <- left_join(shef, cpi, by=c("year_cpi" = "year"))
shef$cpi_multiplier = cpi2014/shef$cpi_all

shef <- shef %>% arrange(fips, year_fiscal)
write.csv(shef, "data/shef.csv", row.names = F, na="")