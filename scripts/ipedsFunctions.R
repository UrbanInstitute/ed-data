# Get IPEDS data using scraper https://github.com/UrbanInstitute/ipeds-scraper

library("jsonlite")
library("dplyr")
library("stringr")
library("openxlsx")

latestyear <- 2014

ipedspath <- "/Users/hrecht/Documents/ipeds-scraper/"
allfiles <- fromJSON(paste(ipedspath, "data/ipedsfiles.json", sep=""))
datacols <- fromJSON(paste(ipedspath, "data/ipedscolumns.json", sep=""))

# IPEDS dictionary
dictionary <- read.csv(paste(ipedspath, "data/dictionary.csv", sep=""), stringsAsFactors = F)

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
getData <- function(datalist, vars, keepallvars) {
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
    
    # OPEID can be sometimes integer sometimes character - coerce to character
    if("opeid" %in% colnames(d))
    {
      d$opeid <- as.character(d$opeid)
    }
    if("f2a20" %in% colnames(d))
    {
      d$f2a20 <- as.character(d$f2a20)
    }
    
    # Select just the need vars
    if(keepallvars == FALSE) {
      selects <- intersect(colnames(d), allvars)
      d <- d %>% select(one_of(selects))
    } else {
      d <- d %>% select(-starts_with("x"))
    }
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
returnData <- function(myvars, keepallvars = FALSE) {
  dl <- searchVars(myvars)
  getData(dl, myvars, keepallvars)
  makeDataset(myvars)
}
rm(allfiles, datacols)