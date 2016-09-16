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

vars2 <- c("fteug")
dl <- searchVars(vars2)
allvars <- tolower(c(vars2, "unitid", "year"))
for (i in seq_along(dl)) {
  csvpath <- dl[[i]]$path
  fullpath <- paste(ipedspath, csvpath, sep="")
  name <- dl[[i]]$name
  d <- read.csv(fullpath, header=T, stringsAsFactors = F, na.strings=c("",".","NA"))
  # Give it a year variable
  d$year <- dl[[i]]$year
  # All lowercase colnames
  colnames(d) <- tolower(colnames(d))
  # Select just the need vars
  selects <- intersect(colnames(d), allvars)
  d <- d %>% select(one_of(selects))
  
  assign(name, d)
}
enrollment <- makeDataset(vars2)

endowvars1 <- c("f1h02")
dl <- searchVars(endowvars1)
allvars <- tolower(c(endowvars1, "unitid", "year"))
for (i in seq_along(dl)) {
  csvpath <- dl[[i]]$path
  fullpath <- paste(ipedspath, csvpath, sep="")
  name <- dl[[i]]$name
  d <- read.csv(fullpath, header=T, stringsAsFactors = F, na.strings=c("",".","NA"))
  # Give it a year variable
  d$year <- dl[[i]]$year
  # All lowercase colnames
  colnames(d) <- tolower(colnames(d))
  # Select just the need vars
  selects <- intersect(colnames(d), allvars)
  d <- d %>% select(one_of(selects))
  
  assign(name, d)
}
endow1 <- makeDataset(endowvars1)

endowvars2 <- c("f2h02")
dl <- searchVars(endowvars2)
allvars <- tolower(c(endowvars2, "unitid", "year"))
for (i in seq_along(dl)) {
  csvpath <- dl[[i]]$path
  fullpath <- paste(ipedspath, csvpath, sep="")
  name <- dl[[i]]$name
  d <- read.csv(fullpath, header=T, stringsAsFactors = F, na.strings=c("",".","NA"))
  # Give it a year variable
  d$year <- dl[[i]]$year
  # All lowercase colnames
  colnames(d) <- tolower(colnames(d))
  # Select just the need vars
  selects <- intersect(colnames(d), allvars)
  d <- d %>% select(one_of(selects))
  
  assign(name, d)
}
endow2 <- makeDataset(endowvars2)

endow <- full_join(endow1, endow2, by=c("unitid", "year"))