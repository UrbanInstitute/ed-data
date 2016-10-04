# Prices and Expenses: Tuition and Fees - IPEDS data
# Logic by Martha Johnson - original Stata code in "IPEDS_Sticker prices_clean.do"

library(dplyr)
library(Hmisc)
library(tidyr)

source("scripts/ipedsFunctions.R")
source("scripts/createJsons.R")

institutions <- read.csv("data/ipeds/institutions.csv", stringsAsFactors = F)


# Weighting variables: enrollment
# MJ code uses ipeds data center derived variables, not available in the complete data files
# We'll use fteug for consistency and bc it's basically identical

########################################################################################################
# Tuition
# chg1ay3 Published in-district tuition and fees (year -> year+1 academic year)
########################################################################################################
tuition <- returnData("chg1ay3")
tuition <- left_join(institutions, tuition, by = c("unitid", "year"))

rm(list = ls(pattern = "ic"))

########################################################################################################
# Distribution of Full-Time Students by Published Tuition and Fees within Sectors
# Decile chart
########################################################################################################
fig3 <- tuition %>% filter(year == latestyear)
calcDeciles <- function(category) {
  dt <- fig3 %>% filter(sector_label == category)
  dt <- dt %>% filter(!is.na(chg1ay3))
  deciles <- as.data.frame(wtd.quantile(dt$chg1ay3, weights = dt$fteug, probs=0:10/10))
  colnames(deciles) <- "tuition"
  # format decile names
  deciles$decile <- as.numeric(sub("%", "", row.names(deciles)))
  deciles <- deciles %>% filter(decile > 0) %>%
    mutate(decile = decile/10) %>%
    arrange(decile)
  return(deciles)
}
fig3a <- calcDeciles("Public two-year")
fig3b <- calcDeciles("Public four-year")
fig3c <- calcDeciles("Private nonprofit four-year")
fig3d <- calcDeciles("For-profit")

json3_3a <- makeJson(sectionn = 3, graphn = 3, subn = 1, dt = fig3a$tuition, graphtype = "bar", series = "Average tuition and fees", graphtitle = "Public two-year",
                     categories = fig3a$decile, tickformat = "dollar")
json3_3b <- makeJson(sectionn = 3, graphn = 3, subn = 2, dt = fig3b$tuition, graphtype = "bar", series = "Average tuition and fees", graphtitle = "Public four-year",
                     categories = fig3b$decile, tickformat = "dollar")
json3_3c <- makeJson(sectionn = 3, graphn = 3, subn = 3, dt = fig3c$tuition, graphtype = "bar", series = "Average tuition and fees", graphtitle = "Private nonprofit four-year",
                     categories = fig3c$decile, tickformat = "dollar")
json3_3d <- makeJson(sectionn = 3, graphn = 3, subn = 4, dt = fig3d$tuition, graphtype = "bar", series = "Average tuition and fees", graphtitle = "For-profit",
                     categories = fig3d$decile, tickformat = "dollar")

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

# Join state names for labels
states <- read.csv("data/states.csv", stringsAsFactors = F)
states <- states %>% select(-abbrev)
fig3_4 <- left_join(fig3_4, states, by="fips")

# Reshape to wide - 1 col per sector for graph file
# fig3_4 <- fig3_4 %>% spread(sector_label, tuition) %>%
#   rename(pub4 = `Public four-year`, pub2 = `Public two-year`) %>%
#   arrange(pub2) %>%
#   # Hide DC
#   filter(fips != 11)

# Toggle graphs json
# json3_4 <- makeJson(sectionn = 3, graphn = 4, set1 = fig3_4$pub2, set2 = fig3_4$pub4, graphtype = "bar", 
#                     series = c("Public two-year", "Public four-year"),
#                     categories = fig3_4$state, tickformat = "dollar", directlabels = TRUE, rotated = TRUE)

# MULTIPLES instead
fig3_4a <- fig3_4 %>% filter(sector_label == "Public two-year")%>%
  filter(!is.na(tuition)) %>%
  arrange(desc(tuition))
fig3_4b <- fig3_4 %>% filter(sector_label == "Public four-year") %>%
  filter(!is.na(tuition)) %>%
  arrange(desc(tuition))

json3_4a <- makeJson(sectionn = 3, graphn = 4, subn = 1, dt = fig3_4a$tuition, graphtype = "bar", 
                    series = "In-district tuition and fees", graphtitle = "Public two-year",
                    categories = fig3_4a$state, tickformat = "dollar", directlabels = TRUE, rotated = TRUE)
json3_4b <- makeJson(sectionn = 3, graphn = 4, subn = 2, dt = fig3_4b$tuition, graphtype = "bar", 
                     series = "In-district tuition and fees", graphtitle = "Public four-year",
                     categories = fig3_4b$state, tickformat = "dollar", directlabels = TRUE, rotated = TRUE)
