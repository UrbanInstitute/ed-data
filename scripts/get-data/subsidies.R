# Producing Education: Subsidies - IPEDS data
# Logic by Martha Johnson - original Stata code in "IPEDS_Cost of education and subsides_clean.do"

library(dplyr)

source("scripts/ipedsFunctions.R")
source("scripts/createJsons.R")

institutions <- read.csv("data/ipeds/institutions.csv", stringsAsFactors = F)

########################################################################################################
# Calculate subsidies
########################################################################################################

# Need a ton of variables from the f1a and f2 datasets
# Return the whole csvs

# GASB
subs1 <- returnData(c("f1b01", "f1e08", "f1e05", "f1e06"), keepallvars = TRUE)
# FASB
subs2 <- returnData(c("f2d01", "f2c08", "f2c05"), keepallvars = TRUE)

subs <- full_join(subs1, subs2, by = c("year", "unitid"))

# Just checking no duplicates - should be none
temp <- subs[duplicated(subs[,c("unitid", "year")]),]

# Join data
subsidies <- left_join(institutions, subs, by = c("year", "unitid"))
subsidies <- subsidies  %>% filter(year >= 2005) %>%
  mutate(fte = fteug + ftegd)

# Clean up workspace
rm(list = ls(pattern = "^f1"))
rm(list = ls(pattern = "^f0"))
rm(list = ls(pattern = "^f9"))

# Calculate variables - logic by Martha Johnson
subsidies <- subsidies %>% 
  # GASB
  mutate(nettuition = ifelse(!is.na(f1b01) & year >= 2004, f1b01 + f1e08 - f1e05 - f1e06,
                            #FASB
                            ifelse(!is.na(f2d01) & year >= 2004, f2d01 + f2c08 - f2c05 - f2c06,
                                   NA))) %>%
  mutate(studserv = ifelse(year >= 2009 & !is.na(f1c061), f1c061 - f1c066 - f1c067,
                           ifelse(year <= 2008 & year >= 2004 & !is.na(f1c061), f1c061,
                                  # FASB
                                  ifelse(year >= 2009 & !is.na(f2e051), f2e051 - f2e054 - f2e056,
                                         ifelse(year <= 2008 & year >= 2004 & !is.na(f2e051), f2e051 - f2e054 - f2e056,
                                                NA))))) %>%
  mutate(research = ifelse(year >= 2009 & !is.na(f1c061), f1c021 - f1c026 - f1c027,
                          ifelse(year <= 2008 & year >= 2004 & !is.na(f1c061), f1c021,
                                 # FASB
                                 ifelse(year >= 2009 & !is.na(f2e051), f2e021 - f2e024 - f2e026,
                                        ifelse(year <= 2008 & year >= 2004 & !is.na(f2e051), f2e021 - f2e024 - f2e026,
                                               NA))))) %>%
  mutate(pubserv = ifelse(year >= 2009 & !is.na(f1c061), f1c031 - f1c036 - f1c037,
                          ifelse(year <= 2008 & year >= 2004 & !is.na(f1c061), f1c031,
                                 # FASB
                                 ifelse(year >= 2009 & !is.na(f2e051), f2e031 - f2e034 - f2e036,
                                        ifelse(year <= 2008 & year >= 2004 & !is.na(f2e051), f2e031 - f2e034 - f2e036,
                                               NA))))) %>%
  mutate(acadsupp = ifelse(year >= 2009 & !is.na(f1c061), f1c051 - f1c056 - f1c057,
                          ifelse(year <= 2008 & year >= 2004 & !is.na(f1c061), f1c051,
                                 # FASB
                                 ifelse(year >= 2009 & !is.na(f2e051), f2e041 - f2e044 - f2e046,
                                        ifelse(year <= 2008 & year >= 2004 & !is.na(f2e051), f2e041 - f2e044 - f2e046,
                                               NA))))) %>%
  mutate(instsupp = ifelse(year >= 2009 & !is.na(f1c061), f1c071- f1c076 - f1c077,
                           ifelse(year <= 2008 & year >= 2004 & !is.na(f1c061), f1c071,
                                  # FASB
                                  ifelse(year >= 2009 & !is.na(f2e051), f2e061 - f2e064 - f2e066,
                                         ifelse(year <= 2008 & year >= 2004 & !is.na(f2e051), f2e061 - f2e064 - f2e066,
                                                NA))))) %>%
  mutate(opermain = ifelse(year >= 2009 & !is.na(f1c061), f1c016 + f1c026 + f1c036 + f1c056 + f1c066 + f1c076,
                           ifelse(year <= 2008 & year >= 2004 & !is.na(f1c061), f1c081,
                                  # FASB
                                  ifelse(year >= 2009 & !is.na(f2e051), f2e014 + f2e024 + f2e034 + f2e044 + f2e054 + f2e064,
                                         ifelse(year <= 2008 & year >= 2004 & !is.na(f2e051), f2e014 + f2e024 + f2e034 + f2e044 + f2e054 + f2e064,
                                                NA))))) %>%
  mutate(instruction = ifelse(year >= 2009 & !is.na(f1c011), f1c011 - f1c016 - f1c017,
                           ifelse(year <= 2008 & year >= 2004 & !is.na(f1c011), f1c011,
                                  # FASB
                                  ifelse(year >= 2009 & !is.na(f2e011), f2e011 - f2e014 - f2e016,
                                         ifelse(year <= 2008 & year >= 2004 & !is.na(f2e011), f2e011 - f2e014 - f2e016,
                                                NA))))) %>%
  mutate(education_share = (instruction + studserv)/(instruction + studserv + research + pubserv),
         eandr = (instruction + studserv) + (education_share * (acadsupp + instsupp + opermain)),
         eandr_perfte = eandr/fte,
         nettuition_perfte = nettuition/fte,
         subsidy_perfte = pmax(0, (eandr_perfte - nettuition_perfte)))

# write.csv(subsidies, "data/ipeds/subsidies.csv", na="", row.names = F)

########################################################################################################
# Education and Related Spending per Full-Time Equivalent Students 2005-–06 to 2013-–14
# Graphs for public and private sectors
# Net tuition revenue per FTE and subsidies per FTE
# Dual formatted tooltips - $ and %
########################################################################################################
temp <- subsidies %>% select(unitid, instnm, year, carnegie_label, sector_label, fte, nettuition_perfte, subsidy_perfte)

########################################################################################################
# Average Subsidy per Full-Time Equivalent Student within Undergraduate Deciles
########################################################################################################

calcSubsidyDeciles <- function(category) {
  dt <- fig5 %>% filter(carnegie_label == category)
  dt <- dt %>% filter(!is.na(endowperfte))
  dt$endowdecile <- as.integer(cut(dt$endowperfte, wtd.quantile(dt$endowperfte, weights = dt$fteug, probs = seq(0, 1, 0.1)), include.lowest=TRUE))
  dt <- dt %>% group_by(endowdecile, carnegie_label) %>%
    summarise(endowperfte_wmean = weighted.mean(endowperfte, w = fteug, na.rm=T))
  return(dt)
}