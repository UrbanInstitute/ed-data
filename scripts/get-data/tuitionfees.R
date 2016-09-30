# Prices and Expenses: Tuition and Fees - IPEDS data
# Logic by Martha Johnson - original Stata code in "IPEDS_Sticker prices_clean.do"

library(dplyr)
library(Hmisc)
library(tidyr)

source("scripts/ipedsFunctions.R")
source("scripts/createJsons.R")

institutions <- read.csv("data/ipeds/institutions.csv", stringsAsFactors = F)

# chg1ay3 Published in-district tuition and fees (year -> year+1 academic year)
indistrict <- returnData("chg1ay3")
tuition <- left_join(institutions, indistrict, by = c("unitid", "year"))

rm(list = ls(pattern = "ic"))

########################################################################################################
# In-district tuition and fees, latest year by state: for public two-year and public four-year colleges
########################################################################################################

# Calculate US average
usave <- tuition %>% filter(year == latestyear & sector_label %in% c("Public four-year", "Public two-year") & !is.na(fteug)) %>% 
  group_by(sector_label) %>%
  summarise(tuition = weighted.mean(chg1ay3, w=fteug, na.rm=TRUE)) %>%
  mutate(fips = 0)

# State level
fig3_4 <- tuition %>% filter(year == latestyear & sector_label %in% c("Public four-year", "Public two-year") & !is.na(fteug)) %>% 
  group_by(fips, sector_label) %>%
  summarise(tuition = weighted.mean(chg1ay3, w=fteug, na.rm=TRUE)) %>%
  # Remove AK two-year (doesn't exist)
  filter(!is.nan(tuition))

usave <- as.data.frame(usave)
fig3_4 <- as.data.frame(fig3_4)

fig3_4 <- rbind(fig3_4, usave)

# Reshape to wide - 1 col per sector for graph file
fig3_4 <- fig3_4 %>% spread(sector_label, tuition) %>%
  rename(pub4 = `Public four-year`, pub2 = `Public two-year`) %>%
  arrange(pub2) %>%
  # Hide DC
  filter(fips != 11)

# Join state names for labels
states <- read.csv("data/states.csv", stringsAsFactors = F)
states <- states %>% select(-abbrev)

fig3_4 <- left_join(fig3_4, states, by="fips")

# Toggle graphs json
json3_4 <- makeJson(sectionn = 3, graphn = 4, set1 = fig3_4$pub2, set2 = fig3_4$pub4, graphtype = "bar", 
                    series = c("Public two-year", "Public four-year"),
                    categories = fig3_4$state, tickformat = "dollar", directlabels = TRUE, rotated = TRUE)

