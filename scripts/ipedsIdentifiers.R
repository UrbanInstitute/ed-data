# Create IPEDS institutions identifiers dataset
# Get IPEDS data using scraper https://github.com/UrbanInstitute/ipeds-scraper

library("jsonlite")
library("dplyr")
library("stringr")

ipedspath <- "/Users/hrecht/Documents/ipeds-scraper/"
allfiles <- fromJSON(paste(ipedspath, "data/ipedsfiles.json", sep=""))
datacols <- fromJSON(paste(ipedspath, "data/ipedscolumns.json", sep=""))

# Join colnames to file info, remove FLAGS datasets, using 1990+
ipeds <- left_join(datacols, allfiles, by = c("name", "year"))
ipeds <- ipeds %>% filter(!grepl("flags", name)) %>%
  filter(year >= 1990)

# Search for a variable, return list of files that contain it
searchVars <- function(vars) {
  # Filter the full IPEDS metadata dataset info to just those containing your vars
  dt <- ipeds %>% filter(grepl(paste(vars, collapse='|'), columns, ignore.case = T))
  dl <- split(dt, dt$name)
  return(dl)
  # For all the files, read in the CSVs
  #dat <- lapply(dt$path, function(i){
  #  read.csv(i, header=T, stringsAsFactors = F)
  #})
  #names(dat) <- dt$name
}

# Institutional characteristics vars
vars <- c("fips", "stabbr", "instnm", "sector", "pset4flg", "instcat", "ccbasic", "control", "deggrant", "carnegie")
dl <- searchVars(vars)
allvars <- tolower(c(vars, "unitid", "year"))
for (i in seq_along(dl)) {
  csvpath <- dl[[i]]$path
  fullpath <- paste(ipedspath, csvpath, sep="")
  name <- dl[[i]]$name
  d <- read.csv(fullpath, header=T, stringsAsFactors = F)
  # Give it a year variable
  d$year <- dl[[i]]$year
  # All lowercase colnames
  colnames(d) <- tolower(colnames(d))
  # Select just the need vars
  selects <- intersect(colnames(d), allvars)
  d <- d %>% select(one_of(selects))
  
  assign(name, d)
}

makeDataset <- function(vars) {
  dt <- ipeds %>% filter(grepl(paste(vars, collapse='|'), columns, ignore.case = T))
  ipeds_list <- lapply(dt$name, get)
  ipedsdata <- bind_rows(ipeds_list)
  ipedsdata <- ipedsdata %>% arrange(year, unitid)
  return(ipedsdata)
}
institutions <- makeDataset(vars)

########################################################################################################
# Format institutions dataset
# Fun: in 1986, all Puerto Rico colleges have the same unitid
########################################################################################################

carnegievar <- as.data.frame(table(institutions$year, institutions$carnegie))

institutions <- institutions %>% group_by(unitid) %>%
  mutate(yearsin = n())
table(institutions$yearsin)

# Keep 50 states + DC
institutions <- institutions %>% filter(fips <= 56)
institutions <- as.data.frame(institutions)
institutions <- institutions %>% select(year, unitid, everything()) %>%
  arrange(year, unitid)

write.csv(institutions, "data/ipeds/institutions.csv", row.names=F, na="")

# Define universe
dt <- dt %>% filter(sector > 0 & pset4flg==1) %>%
  # Special institutions - graduate-students only or other special focus
  mutate(specialty = ifelse((instcat==1 | ccbasic>23), 1, 0)) %>%
  # Primary Carnegie categories
  mutate(carnegie = ifelse((ccbasic<18 & ccbasic>14) & control==1), "Public research",
         ifelse((ccbasic<21 & ccbasic>17) & control==1, "Public masters",
                ifelse((instcat==3 | instcat==4) & control==1, "Public associates",
                       ifelse((ccbasic<18 & ccbasic>14) & control==2, "Private nonprofit research",
                              ifelse((ccbasic<21 & ccbasic>17) & control==2, "Private nonprofit masters",
                                     ifelse(instcat==2 & control==2 & carnegie==0, "Private nonprofit bachelors",
                                            ifelse(control==3, "For profit",
                                                   ifelse((instcat==2 & control==1 & carnegie==0) | (instcat==3 | instcat==4) & control==2) |(ccbasic==-3 & control!=3 & instcat!=3 & instcat!=4 & specialty!=1), "Small groups",
                                            ifelse(specialty==1 & control!=3, "Special focus",
                                                   ifelse(deggrant==2, NA, NA))
                                     )))))))
