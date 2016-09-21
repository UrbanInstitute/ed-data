# Endowments data from IPEDS

library(dplyr)
library(Hmisc)

source("scripts/ipedsFunctions.R")
source("scripts/createJsons.R")

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

# carnegie_urban: # 1 "public research" 2 "public masters" 3 "public associates" 4 "private nonprofit research" 5 "private nonprofit masters"
# 6 "private nonprofit bachelors" 7 "for profit" 8 "small groups" 9 "special focus"
# We need 1, 2, 4, 5, 6
########################################################################################################

fig5 <- endow %>% filter(carnegie_urban %in% c(1, 2, 4, 5, 6)) %>%
  mutate(carnegie_label = ifelse(carnegie_urban == 1, "Public research",
                                ifelse(carnegie_urban == 2, "Public masters",
                                       ifelse(carnegie_urban == 4, "Private nonprofit research",
                                              ifelse(carnegie_urban == 5, "Private nonprofit masters",
                                                     ifelse(carnegie_urban == 6, "Private nonprofit bachelors",
                                                            "")))))) %>%
  filter(year == latestyear)

# Within a carnegie group, calculate weighted deciles of endowment group
# Then by decile, weighted mean endowment per FTE
calcDeciles <- function(category) {
  dt <- fig5 %>% filter(carnegie_label == category)
  dt <- dt %>% filter(!is.na(endowperfte))
  dt$endowdecile <- as.integer(cut(dt$endowperfte, wtd.quantile(dt$endowperfte, weights = dt$fteug, probs = seq(0, 1, 0.1)), include.lowest=TRUE))
  dt <- dt %>% group_by(endowdecile) %>%
    summarise(endowperfte_wmean = weighted.mean(endowperfte, w = fteug, na.rm=T))
  return(dt)
}

fig5a <- calcDeciles("Public research")
fig5b <- calcDeciles("Public masters")
fig5c <- calcDeciles("Private nonprofit research")
fig5d <- calcDeciles("Private nonprofit masters")
fig5e <- calcDeciles("Private nonprofit bachelors")

json2_5a <- makeJson(sectionn = 2, graphn = 5, subn = 1, dt = fig5a$endowperfte_wmean, graphtype = "bar", series = "Public research", 
                     categories = fig5a$endowdecile, tickformat = "dollar", xtype = "category")
json2_5b <- makeJson(sectionn = 2, graphn = 5, subn = 2, dt = fig5b$endowperfte_wmean, graphtype = "bar", series = "Public masters", 
                     categories = fig5b$endowdecile, tickformat = "dollar", xtype = "category")
json2_5c <- makeJson(sectionn = 2, graphn = 5, subn = 3, dt = fig5c$endowperfte_wmean, graphtype = "bar", series = "Private nonprofit research", 
                     categories = fig5c$endowdecile, tickformat = "dollar", xtype = "category")
json2_5d <- makeJson(sectionn = 2, graphn = 5, subn = 4, dt = fig5d$endowperfte_wmean, graphtype = "bar", series = "Private nonprofit masters", 
                     categories = fig5d$endowdecile, tickformat = "dollar", xtype = "category")
json2_5e <- makeJson(sectionn = 2, graphn = 5, subn = 5, dt = fig5e$endowperfte_wmean, graphtype = "bar", series = "Private nonprofit bachelors", 
                     categories = fig5e$endowdecile, tickformat = "dollar", xtype = "category")

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

# Label groups
selectivity <- selectivity %>% mutate(selectlabel = ifelse(selectcat==5, "Open admissions policy",
                                                           ifelse(selectcat==4, "75 - 100%",
                                                                  ifelse(selectcat==3, "50 - 75%",
                                                                         ifelse(selectcat==2, "25 - 50%", "0 - 25%")))))

endow <- left_join(endow, selectivity, by = c("unitid", "year"))
endow_latest = endow %>% filter(year == latestyear)
table(endow_latest$selectlabel, endow_latest$sector_urban)

# Graphs: sector_urban = 2 "public four-year", 3 "private nonprofit four-year"
fig6 <- endow_latest %>% filter((sector_urban == 2 | sector_urban == 3) & !is.na(selectcat)) %>%
  group_by(sector_urban, selectlabel) %>%
  summarize(endowinc_median = median(endowperfte, na.rm=T),
            endowinc_wmean = weighted.mean(endowperfte, w=fteug, na.rm=T))

fig6a <- fig6 %>% filter(sector_urban==3)
fig6b <- fig6 %>% filter(sector_urban==2)
# Small multiples of median by sector
json2_6a <- makeJson(sectionn = 2, graphn = 6, subn = 1, dt = fig6a$endowinc_median, graphtype = "bar", series = "Private Nonprofit Four-Year Institutions", 
                    categories = fig6a$selectlabel, tickformat = "dollar", directlabels = TRUE, rotated = TRUE, xtype = "category")
json2_6b <- makeJson(sectionn = 2, graphn = 6, subn = 2, dt = fig6b$endowinc_median, graphtype = "bar", series = "Public Four-Year Institutions", 
                     categories = fig6b$selectlabel, tickformat = "dollar", directlabels = TRUE, rotated = TRUE, xtype = "category")