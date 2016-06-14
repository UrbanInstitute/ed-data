# Create data jsons for graphs

library(dplyr)
library(tidyr)
library(jsonlite)

########################################################################################################
# Costs and subsidies (Section 2)
########################################################################################################

# Figure 6 - local support for higher education has grown in recent years relative to state support
# State and local support for higher education: use appropriations_tax (state) and appropriations_local
# Use cpi to age dollar amounts to latest data year
shef <- read.csv("data/shef.csv", stringsAsFactors = F, colClasses = c("fips" = "character"))

fig6 <- shef %>% filter(fips=="00") %>% 
  select(year, cpi_multiplier, appropriations_state, appropriations_local) %>%
  mutate(approp_state_aged = appropriations_state * cpi_multiplier,
         approp_local_aged = appropriations_local * cpi_multiplier)

# Get 2000 values to compare with value by year
state2000 <- fig6$approp_state_aged[fig6$year==2000]
local2000 <- fig6$approp_local_aged[fig6$year==2000]
fig6$approp_state_change <- (fig6$approp_state_aged - state2000)/state2000
fig6$approp_local_change <- (fig6$approp_local_aged - local2000)/local2000
# write.csv(fig6, "data/section2fig6.csv", row.names = F)

# Save data as json
fig6_min <- fig6 %>% select(year, approp_state_change, approp_local_change)

# Once specs are done, make a function of this
dtj <- toJSON(fig6_min, digits = 6)
title <- "Change from FY 2000 in state and local support for higher education"
type <- "line"
ytype <- "%"
src <- "State Higher Education Executive Officers Association."
notes <- "Some notes about the chart if needed (maybe not)."

graphj <- paste('{ "title": "', title, 
                '", "data": ', dtj,
                ', "type": "', type,
                '", "axis": { "y": {"type": "', ytype,
                '"} }, "source": "', src, 
                '", "notes": "', notes, '"}', sep="")

write(graphj, "graph-json/section2fig6.json")