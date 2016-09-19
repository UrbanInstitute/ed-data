# Get IPEDS data using scraper https://github.com/UrbanInstitute/ipeds-scraper

library("jsonlite")
library("dplyr")
library("stringr")
library("tidyr")
library("openxlsx")

ipedspath <- "/Users/hrecht/Documents/ipeds-scraper/"
allfiles <- fromJSON(paste(ipedspath, "data/ipedsfiles.json", sep=""))
datacols <- fromJSON(paste(ipedspath, "data/ipedscolumns.json", sep=""))

# Join colnames to file info, remove FLAGS datasets, using 1990+
ipeds <- left_join(datacols, allfiles, by = c("name", "year"))
ipeds <- ipeds %>% filter(!grepl("flags", name)) %>%
  filter(year >= 1990)

# There are a few in the way that IPEDS lists its files - remove them
ipeds <-ipeds[!duplicated(ipeds[,"path"]),]

# Search for a variable(s), return list of files that contain it
searchVars <- function(vars) {
  # Filter the full IPEDS metadata dataset info to just those containing your vars
  dt <- ipeds %>% filter(grepl(paste(vars, collapse='|'), columns, ignore.case = T))
  datalist <- split(dt, dt$name)
  return(datalist)
}

# Return the datasets containing the var(s) and selected the necessary columns
getData <- function(datalist, vars) {
  allvars <- tolower(c(vars, "unitid", "year"))
  for (i in seq_along(datalist)) {
    csvpath <- datalist[[i]]$path
    fullpath <- paste(ipedspath, csvpath, sep="")
    name <- datalist[[i]]$name
    d <- read.csv(fullpath, header=T, stringsAsFactors = F, na.strings=c("",".","NA"))
    # Give it a year variable
    d$year <- datalist[[i]]$year
    # All lowercase colnames
    colnames(d) <- tolower(colnames(d))
    # Select just the need vars
    selects <- intersect(colnames(d), allvars)
    d <- d %>% select(one_of(selects))
    assign(name, d, envir = .GlobalEnv)
  }
}

# Bind rows to make one data frame
makeDataset <- function(vars) {
  dt <- ipeds %>% filter(grepl(paste(vars, collapse='|'), columns, ignore.case = T))
  ipeds_list <- lapply(dt$name, get)
  ipedsdata <- bind_rows(ipeds_list)
  ipedsdata <- ipedsdata %>% arrange(year, unitid)
  return(ipedsdata)
}

# If desired (usually the case): Do all the things: search, get datasets
returnData <- function(myvars) {
  dl <- searchVars(myvars)
  getData(dl, myvars)
  makeDataset(myvars)
}
rm(allfiles, datacols)