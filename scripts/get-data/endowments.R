# Endowments data from IPEDS

library(dplyr)

latestyear <- 2014
# fte12mn Total 12-month FTE student enrollment
# f2fha Does this institution or any of its foundations or other affiliated organizations own endowment assets?

institutions <- read.csv("data/ipeds/institutions.csv", stringsAsFactors = F)

inst <- institutions %>% select(unitid, year, sector_urban, carnegie_urban, fte12mn, instnm)
inst_latest <- inst %>% filter(year == latestyear)

# Get enrollment for undergrads and grads from IPEDS
source("scripts/ipedsFunctions.R")

enrollment <- returnData("fteug")
endow1 <- returnData("f1h02")
endow2 <- returnData("f2h02")

endow <- full_join(endow1, endow2, by=c("unitid", "year"))

rm(list=setdiff(ls(), c("latestyear", "institutions", "enrollment", "endow1", "endow2")))