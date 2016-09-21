# IPEDS enrollment variables used throughout sections
# fte12mn, fteug

source("scripts/ipedsFunctions.R")
# fteug from IPEDS raw data
fteug <- returnData("fteug")

# IPEDS 12 month FTE enrollment: a derived variable
# Available in the data download center and Delta cost project but NOT in the raw data downloads
# Get available years from Delta, latest from IPEDS data download center

# Use Delta where available because IPEDS data downloader gets data for schools in a given year: so if
# you download using "2015 insitutions" and variables for all years you won't get data for schools that
# closed before 2015

########################################################################################################
# Definition from Delta dictionary:
# The 12-month full-time-equivalent (FTE) enrollments are derived from the 12-month instructional activity 
# portion of the Enrollment component (data for this variable are only available for 2004+). FTE enrollment 
# is the sum of the institutions’ FTE undergraduate and graduate enrollment, plus the estimated FTE of first-professional 
# students. Undergraduate and graduate FTE are calculated using the  12-month instructional activity reported for 
# credit and/or contact hours, with calculation factors . First-professional FTE is estimated by calculating the ratio
# of full-time to part-time first-professional students from the fall enrollment counts and applying this ratio to the 
# 12-month unduplicated headcount of first-professional students. The estimated number of full-time first professional 
# students is added to one-third of the estimated number of part-time first professional students. 
########################################################################################################

library(dplyr)

# Delta Cost Project, 1985-2013 http://www.deltacostproject.org/delta-cost-project-database
# download.file("http://www.deltacostproject.org/sites/default/files/database/Delta_database_87_13_CSV.zip", "data/original/Delta_database_87_13_CSV.zip")
# unzip("data/original/Delta_database_87_13_CSV.zip", exdir="data/original/Delta_database_87_13_CSV")

delta1 <- read.csv("data/original/Delta_database_87_13_CSV/delta_public_release_00_13.csv", stringsAsFactors = F)
#delta2 <- read.csv("data/original/Delta_database_87_13_CSV/delta_public_release_87_99.csv", stringsAsFactors = F)

fte <- delta1 %>% select(unitid, instname, academicyear, fte12mn) %>% 
  arrange(unitid, academicyear) %>%
  filter(academicyear >= 2004)

# IPEDS data center for 2014+ with selections:
# Institutions: all for given year
# Variables: Frequently used/derived variables > 12-month full-time equivalent enrollment
# Output: CSV, include unitid, short variable name

ipedsfte <- read.csv("data/original/fte12mn_2014.csv", stringsAsFactors = F)
ipedsfte <- ipedsfte %>% rename(unitid = UnitID, instname = `Institution.Name`, fte12mn = `FTE12MN..DRVEF122014_RV.`) %>%
  select(unitid, fte12mn, instname) %>%
  mutate(academicyear = 2014)

fte <- rbind(fte, ipedsfte) %>%
  arrange(unitid, academicyear) %>%
  rename(year = academicyear)

write.csv(fte, "data/ipeds/fte12mn.csv", row.names = F, na="")

# Add to institutions dataset
institutions <- read.csv("data/ipeds/institutions.csv", stringsAsFactors = F)

enrollment <- full_join(fte, fteug, by = c("unitid", "year"))
enrollment <- enrollment %>% select(-instname)

institutions <- left_join(institutions, enrollment, by=c("unitid", "year"))
institutions <- institutions %>% arrange(unitid, year)
write.csv(institutions, "data/ipeds/institutions.csv", row.names=F, na="")