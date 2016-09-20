# Endowments data from IPEDS

library(dplyr)
source("scripts/ipedsFunctions.R")

latestyear <- 2014
# fte12mn Total 12-month FTE student enrollment
# f2fha Does this institution or any of its foundations or other affiliated organizations own endowment assets?

institutions <- read.csv("data/ipeds/institutions.csv", stringsAsFactors = F)

inst <- institutions %>% select(unitid, year, sector_urban, carnegie_urban, fte12mn, instnm)
inst_latest <- inst %>% filter(year == latestyear)

# Get enrollment for undergrads and grads from IPEDS
enrollment <- returnData("fteug")
endow1 <- returnData("f1h02")
endow2 <- returnData("f2h02")

rm(list=setdiff(ls(), c("latestyear", "institutions", "enrollment", "endow1", "endow2")))

# Join data
endow <- full_join(endow1, endow2, by=c("unitid", "year"))
endow <- left_join(institutions, endow, by=c("unitid", "year"))
endow <- left_join(endow, enrollment, by=c("unitid", "year"))

# Make endowment per full time equivalent students variable - logic by Martha Johnson
# GASB public
endow <- endow %>% mutate(endowperfte = ifelse(!is.na(f1h02), f1h02/fte12mn * 0.045,
                                               # /FASB private
                                               ifelse(!is.na(f2h02), f2h02/fte12mn * 0.045,
                                                      NA)))

########################################################################################################
# Average Endowment Income per Student within Deciles of Enrolled Students

# Take each carnegie category. Then within them, divide them in to deciles by endowperfte, weighted by fteug. 
# For each decile, for each carnegie category, calculate the mean endowperfte weighted by fteug. 
########################################################################################################

temp <- endow %>% group_by(carnegie_urban) %>%
  


########################################################################################################
# Endowment spending per FTE by degree of selectivity
# openadmp: open admissions policy

# Selectivity: defined by IPEDS as:
# If number of total applicants (APPLCN) > 0
# then Percent admitted total (DVIC01) = number of admissions-total(ADMSSN) divided by the total applicants(APPLCN)
# **(NOTE: IPEDS DICT SPELLS APPLCN WRONG)**
# Ratios are converted to percentages and rounded to the nearest whole number.
########################################################################################################

selectivity <- returnData(c("admssn", "applcn"))
openad <- returnData("openadmp")
selectivity <- full_join(selectivity, openad, by = c("unitid", "year"))

# Calculate selectivity groups: <25%, 25-50%, 50-75%, 75
selectivity <- selectivity %>% mutate(admitted_pct = admssn/applcn) %>%
  mutate(admitted_pct = replace(admitted_pct, admitted_pct > 1 & !is.na(admitted_pct), 1)) %>%
  mutate(admitted_pct = replace(admitted_pct, openadmp==1, 1)) %>%
  mutate(admitted_pct = replace(admitted_pct, openadmp==2 & admitted_pct>0.99, 0.99)) %>%
  mutate(selectcat = cut(admitted_pct, breaks=c(0, 0.25, 0.50, 0.75, 1), include.lowest=TRUE, labels = F)) %>%
  # separate category for open admissions
  mutate(selectcat = replace(selectcat, admitted_pct==1, 5)) %>%
  arrange(unitid, year)

endow <- left_join(endow, selectivity, by = c("unitid", "year"))
endow_latest = endow %>% filter(year == latestyear)
table(endow_latest$selectcat, endow_latest$sector_urban)

# Graphs: sector_urban = 2 "public four-year", 3 "private nonprofit four-year"
pub4 <- endow_latest %>% filter(sector_urban==2)
pnp4 <- endow_latest %>% filter(sector_urban==3)

fig6 <- endow_latest %>% filter((sector_urban == 2 | sector_urban == 3) & !is.na(selectcat)) %>%
  group_by(sector_urban, selectcat) %>%
  summarize(endowinc_median = median(endowperfte, na.rm=T))

# egen selectcat = cut(selectivity), at(0(25)125)
# table selectcat, contents(min selectivity max selectivity)
# table selectcat [aweight=fteug_2014] if carnegie<7 & carnegie!=3, by(carnegie) contents(n selectivity mean endowperfte_2014)