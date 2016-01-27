# Hannah Recht, 01-26-16
# Explore data from IPEDS via the Delta Cost Project http://www.deltacostproject.org/delta-cost-project-database

library(readxl)
library(dplyr)
########################################################################################################
# Download database and combine all years
########################################################################################################

download.file("http://www.deltacostproject.org/sites/default/files/database/Delta_database_87_13_CSV.zip", "data/original/delta/Delta_database_87_13_CSV.zip")
unzip("data/original/delta/Delta_database_87_13_CSV.zip", exdir="data/original/delta/")

delta1 <- read.csv("data/original/delta/delta_public_release_00_13.csv", stringsAsFactors = F)
delta2 <- read.csv("data/original/delta/delta_public_release_87_99.csv", stringsAsFactors = F)

delta <- rbind(delta1, delta2)
saveRDS(delta, "data/delta.rds")
rm(delta1, delta2)

# Dictionary
download.file("http://www.deltacostproject.org/sites/default/files/database/Delta_Data_Dictionary_1987_2013.xls", "data/original/delta/Delta_Data_Dictionary_1987_2013.xls")
dict <- read_excel("data/original/delta/Delta_Data_Dictionary_1987_2013.xls", sheet="Proc Contents Order")
labels <- read_excel("data/original/delta/Delta_Data_Dictionary_1987_2013.xls", sheet="Freq (Full Database) 87_13")

########################################################################################################
# Fall enrollment by sector
# Totals don't match data downloaded from IPEDS - why?
########################################################################################################

deltaenrollment <- delta %>% group_by(academicyear, state, sector) %>%
	summarize(total_undergraduates = sum(total_undergraduates, na.rm=T), total_full_time_undergraduates = sum(total_full_time_undergraduates, na.rm = T), total_part_time_undergraduates = sum(total_part_time_undergraduates, na.rm = T), total_graduates = sum(total_graduates, na.rm = T))
deltaenrollment$academicyear = as.character(deltaenrollment$academicyear)

########################################################################################################
# Let's do some straight up comparisons with IPEDS
# Use ipedsdata.R to read in the previously-downloaded data
########################################################################################################
# Join data

enrolljoin <- left_join(deltaenrollment, enrollwide, by=c("state"="abbrev", "sector"="sector", "academicyear"="year"))
enrolljoin <- enrolljoin %>% filter(sector >=1 & sector <=5) %>%
  mutate(diff_undergrad = total_undergraduates - tot_ug)
summary(enrolljoin$diff_undergrad)
