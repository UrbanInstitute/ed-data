# Create IPEDS institutions identifiers dataset
# Get IPEDS data using scraper https://github.com/UrbanInstitute/ipeds-scraper

library("jsonlite")
library("dplyr")
library("stringr")
library("tidyr")

ipedspath <- "/Users/hrecht/Documents/ipeds-scraper/"
allfiles <- fromJSON(paste(ipedspath, "data/ipedsfiles.json", sep=""))
datacols <- fromJSON(paste(ipedspath, "data/ipedscolumns.json", sep=""))

# Join colnames to file info, remove FLAGS datasets, using 1990+
ipeds <- left_join(datacols, allfiles, by = c("name", "year"))
ipeds <- ipeds %>% filter(!grepl("flags", name)) %>%
  filter(year >= 1990)

# There are a few in the way that IPEDS lists its files - remove them
ipeds <-ipeds[!duplicated(ipeds[,"path"]),]

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

# Bind rows to make one data frame
makeDataset <- function(vars) {
  dt <- ipeds %>% filter(grepl(paste(vars, collapse='|'), columns, ignore.case = T))
  ipeds_list <- lapply(dt$name, get)
  ipedsdata <- bind_rows(ipeds_list)
  ipedsdata <- ipedsdata %>% arrange(year, unitid)
  return(ipedsdata)
}

########################################################################################################
# Get main insitutional characteristics
#######################################################################################################

# Institutional characteristics vars
instvars <- c("fips", "stabbr", "instnm", "sector", "pset4flg", "instcat", "ccbasic", "control", "deggrant", "opeflag", "carnegie", "hloffer")
dl <- searchVars(instvars)
allvars <- tolower(c(instvars, "unitid", "year"))
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

institutions <- makeDataset(instvars)

########################################################################################################
# For years < 2004, we need % of degrees granted that are bachelor's degrees or higher
# Data from completions CDFs
########################################################################################################

#CIPCODE is used in many places - get where it's 6 digits, and keep all the variables besides flags
cipdt <- ipeds %>% filter(grepl("cipcode", columns, ignore.case = T)) %>%
  filter(grepl("6-digit CIP", title, ignore.case = T)) %>%
  filter(year <= 2003)

dl <- split(cipdt, cipdt$name)
allvars <- tolower(c("cipcode", "unitid", "year"))
for (i in seq_along(dl)) {
  csvpath <- dl[[i]]$path
  fullpath <- paste(ipedspath, csvpath, sep="")
  name <- dl[[i]]$name
  d <- read.csv(fullpath, header=T, stringsAsFactors = F)
  # Give it a year variable
  d$year <- dl[[i]]$year
  # All lowercase colnames
  colnames(d) <- tolower(colnames(d))
  
  assign(name, d)
}

ipeds_list <- lapply(cipdt$name, get)
completions <- bind_rows(ipeds_list)
completions <- completions %>% arrange(year, unitid) %>%
  select(-starts_with("x"))

# cipcode==99: all degrees
cip99 <- completions %>% filter(cipcode==99)

# Create a variable that sums all the "crace"i variables - all the subgroups
cip99$degrees <- rowSums(cip99[,grep("crace", names(cip99)),], na.rm=T)

# Later years use majornum column - is this the student's first or second major
# Restrict to majornum = na or 1
cip99 <- cip99 %>% filter(is.na(majornum) | majornum==1) 

# Reshape to by unitid, year, and then # of degrees by award level
degrees <- cip99 %>% select(unitid, year, degrees, awlevel) %>%
  spread(awlevel, degrees)

# Then total degrees = sum of award levels >= 1
# Bachelor's+ degrees = sum of award levels >= 5
degrees[is.na(degrees)] <- 0
degrees <- degrees %>% mutate(degrees_total = `1` + `2` + `3` + `4` + `5` + `6` + `7` + `8` + `9` + `10` + `11`,
                   degrees_bachplus = `5` + `6` + `7` + `8` + `9` + `10` + `11`) %>% 
  select(unitid, year, degrees_total, degrees_bachplus) %>% 
  mutate(degrees_pctbachplus = degrees_bachplus/degrees_total)

# Add to institutions dataset
institutions <- left_join(institutions, degrees, by = c("unitid", "year"))

########################################################################################################
# Level variables
# 2014 definitions
# LEVEL1	N	2	Disc		Less than one year certificate
# LEVEL2	N	2	Disc		One but less than two years certificate
# LEVEL3	N	2	Disc		Associate's degree
# LEVEL4	N	2	Disc		Two but less than 4 years certificate
# LEVEL5	N	2	Disc		Bachelor's degree
# LEVEL6	N	2	Disc		Postbaccalaureate certificate
# LEVEL7	N	2	Disc		Master's degree
# LEVEL8	N	2	Disc		Post-master's certificate
# LEVEL12	N	2	Disc		Other degree
# LEVEL17	N	2	Disc		Doctor's degree - research/scholarship
# LEVEL18	N	2	Disc		Doctor's degree - professional practice
# LEVEL19	N	2	Disc		Doctor's degree - other
########################################################################################################

# Additional institutional characteristics
vars2 <- c("level3", "level5", "level7", "level9", "level10")
dl <- searchVars(vars2)
allvars <- tolower(c(vars2, "unitid", "year"))
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
levelsdt <- makeDataset(vars2)

# Add to institutions dataset
institutions <- left_join(institutions, levelsdt, by = c("unitid", "year"))

########################################################################################################
# finaid9 for <1996
# replace zeros with 1 if institution is NOT 'not eligible for any of the above' federal financial aid programs
########################################################################################################
dl <- searchVars("finaid9")
allvars <- tolower(c("finaid9", "unitid", "year"))
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
finaid9 <- makeDataset("finaid9")

# Add to institutions dataset
institutions <- left_join(institutions, finaid9, by = c("unitid", "year"))
write.csv(institutions, "data/ipeds/institutions.csv", row.names=F, na="")

########################################################################################################
# Format institutions dataset
# Fun: in 1986, unitids are all screwy
########################################################################################################

institutions <- read.csv("data/ipeds/institutions.csv", stringsAsFactors = F)
carnegievar <- as.data.frame(table(institutions$year, institutions$carnegie))

institutions <- institutions %>% group_by(unitid) %>%
  mutate(yearsin = n())
table(institutions$yearsin)

# Keep 50 states + DC
institutions <- institutions %>% filter(fips <= 56)
institutions <- institutions %>% select(year, unitid, everything()) %>%
  arrange(year, unitid)

# Define deggrant for <2000
table(institutions$deggrant)
# DEGGRANT	1	Degree-granting
# DEGGRANT	2	Nondegree-granting, primarily postsecondary
# DEGGRANT	-3	{Not available}
# 3 and 4 used rarely in early 2000s for technical/vocational schools
# 1: highest level offering is at least an associate's degree

########## LEFT OFF HERE #############
institutions <- institutions %>% mutate(temp = ifelse((year < 2000 & (level3==1 | level5==1 | level7==1 | level9==1 | level10==1)), 1, 0))

# Define universe
# dt <- dt %>% filter(sector > 0 & pset4flg==1) %>%
#   # Special institutions - graduate-students only or other special focus
#   mutate(specialty = ifelse((instcat==1 | ccbasic>23), 1, 0)) %>%
#   # Primary Carnegie categories
#   mutate(carnegie = ifelse((ccbasic<18 & ccbasic>14) & control==1), "Public research",
#          ifelse((ccbasic<21 & ccbasic>17) & control==1, "Public masters",
#                 ifelse((instcat==3 | instcat==4) & control==1, "Public associates",
#                        ifelse((ccbasic<18 & ccbasic>14) & control==2, "Private nonprofit research",
#                               ifelse((ccbasic<21 & ccbasic>17) & control==2, "Private nonprofit masters",
#                                      ifelse(instcat==2 & control==2 & carnegie==0, "Private nonprofit bachelors",
#                                             ifelse(control==3, "For profit",
#                                                    ifelse((instcat==2 & control==1 & carnegie==0) | (instcat==3 | instcat==4) & control==2) |(ccbasic==-3 & control!=3 & instcat!=3 & instcat!=4 & specialty!=1), "Small groups",
#                                             ifelse(specialty==1 & control!=3, "Special focus",
#                                                    ifelse(deggrant==2, NA, NA))
#                                      )))))))
