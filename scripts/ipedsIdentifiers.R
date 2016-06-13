# Create IPEDS institutions identifiers dataset
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

########################################################################################################
# Not all identifiers are available for early years - define as laid out by Martha Johnson
# deggrant
########################################################################################################

# 2014 value labels
labels2014 <- readWorkbook(paste(ipedspath, "dict/2014/hd2014.xlsx", sep=""), sheet="Frequencies")

# Define deggrant for <2000
table(institutions$deggrant)
# DEGGRANT	1	Degree-granting
# DEGGRANT	2	Nondegree-granting, primarily postsecondary
# DEGGRANT	-3	{Not available}
# 3 and 4 used rarely in early 2000s for technical/vocational schools
# 1: highest level offering is at least an associate's degree

# NAs are being treated as logical, not numeric - need to replace with something other than NA for variable defintions
institutions$level3[is.na(institutions$level3)] <- -99
institutions$level5[is.na(institutions$level5)] <- -99
institutions$level7[is.na(institutions$level7)] <- -99
institutions$level9[is.na(institutions$level9)] <- -99
institutions$level10[is.na(institutions$level10)] <- -99

institutions$deggrant2 <- institutions$deggrant
institutions$deggrant2[institutions$year < 2000 & (institutions$level3==1 | institutions$level5==1 | institutions$level7==1 | 
                                                institutions$level9==1 | institutions$level10==1)] <- 1
institutions$deggrant2[institutions$year < 2000 & !(institutions$level3==1 | institutions$level5==1 | institutions$level7==1 | 
                                                institutions$level9==1 | institutions$level10==1)] <- 2

########################################################################################################
# pset4flg - Postsecondary and Title IV institution indicator
########################################################################################################

# PSET4FLG	1	Title IV postsecondary institution
# PSET4FLG	2	Non-Title IV postsecondary institution
# PSET4FLG	3	Title IV NOT primarily postsecondary institution
# PSET4FLG	4	Non-Title IV NOT primarily postsecondary institution
# PSET4FLG	6	Non-Title IV postsecondary institution that is NOT open to the public
# PSET4FLG	9	Institution is not active in current universe
table(institutions$pset4flg)
institutions$pset4flg2 <- institutions$pset4flg
# institution is NOT 'not eligible for any of the above' federal financial aid programs
institutions$pset4flg2[institutions$year < 1997 & institutions$finaid9!=1] <- 1
institutions$pset4flg2[institutions$year < 1996 & is.na(institutions$finaid9)] <- 1
# participates in Title IV federal financial aid programs
institutions$pset4flg2[institutions$year >= 1996 & institutions$year < 2000 & institutions$opeflag==1] <- 1

########################################################################################################
# instcat - institutional category
########################################################################################################

# INSTCAT	1	Degree-granting, graduate with no undergraduate degrees
# INSTCAT	2	Degree-granting, primarily baccalaureate or above
# INSTCAT	3	Degree-granting, not primarily baccalaureate or above
# INSTCAT	4	Degree-granting, associate's and certificates
# INSTCAT	5	Nondegree-granting, above the baccalaureate
# INSTCAT	6	Nondegree-granting, sub-baccalaureate
# INSTCAT	-1	Not reported
# INSTCAT	-2	Not applicable
table(institutions$instcat)
institutions$instcat2 <- institutions$instcat
# Master's, Doctor's, or first-professional, no bachelor's, no associate's
institutions$instcat2[institutions$year < 2004 & institutions$deggrant2==1 & 
                        (institutions$level7==1 | institutions$level9==1 | institutions$level10==1) & 
                        institutions$level5!=1 & institutions$level3!=1] <- 1
# Bachelor's or higher, primarily bachelor's or higher
institutions$instcat2[institutions$year < 2004 & institutions$deggrant2==1 & 
                        (institutions$level5==1 | institutions$level7==1 | institutions$level9==1 | institutions$level10==1) & 
                        institutions$degrees_pctbachplus > 0.5] <- 2
# Bachelor's or higher, primarily below bachelor's
institutions$instcat2[institutions$year < 2004 & institutions$deggrant2==1 & 
                        (institutions$level5==1 | institutions$level7==1 | institutions$level9==1 | institutions$level10==1) & 
                        institutions$degrees_pctbachplus <= 0.5] <- 3
# Highest degree is associate's (may have post-bacc certificates)
institutions$instcat2[institutions$year < 2004 & institutions$deggrant2==1 & institutions$level3==1 &
                        institutions$level5!=1 & institutions$level7!=1 & institutions$level9!=1 & institutions$level10!=1] <- 4
# post-bacc certificates, no degrees
institutions$instcat2[institutions$year < 2004 & institutions$deggrant2==2 & institutions$hloffer >= 6] <- 5
# no post-bacc certificates, no degrees
institutions$instcat2[institutions$year < 2004 & institutions$deggrant2==2 & institutions$hloffer < 6] <- 6

# Sector 0 = NA instcat (-2)
institutions$instcat2[institutions$year < 2004 & institutions$sector==0] <- -2

########################################################################################################
# ccbasic for 1994 - 2004
# can't make but don't need earlier years so not an issue
# We'll generally be using carnegie for the latest year but sector over time
########################################################################################################

institutions$ccbasic2 <- institutions$ccbasic
# doctoral and research level
institutions$ccbasic2[institutions$year < 2000 & institutions$year >= 1994 & 
                        (institutions$carnegie %in% c(11, 12, 13, 14))] <- 15
institutions$ccbasic2[institutions$year < 2005 & institutions$year >= 2000 & 
                        (institutions$carnegie %in% c(15,16))] <- 15

# masters level
institutions$ccbasic2[institutions$year < 2005 & institutions$year >= 1994 & 
                        (institutions$carnegie %in% c(21, 22))] <- 20
# special focus
institutions$ccbasic2[institutions$year < 2005 & institutions$year >= 1994 & 
                        (institutions$carnegie > 50)] <- 20

########################################################################################################
# Redefined carnegie for this project - carnegie_urban
# 1 "public research" 2 "public masters" 3 "public associates" 4 "private nonprofit research" 5 "private nonprofit masters"
# 6 "private nonprofit bachelors" 7 "for profit" 8 "small groups" 9 "special focus"
########################################################################################################
# Special institutions - graduate-students only or other special focus
institutions$specialty <- 0
institutions$specialty[(institutions$instcat2==1 | institutions$ccbasic2 > 23)] <- 1

institutions$carnegie_urban <- 0
### PUBLIC
# public research
institutions$carnegie_urban[institutions$ccbasic2 %in% c(15, 16, 17) & institutions$control==1] <- 1
# public masters
institutions$carnegie_urban[institutions$ccbasic2 %in% c(18, 19, 20) & institutions$control==1] <- 2
# public associates
institutions$carnegie_urban[institutions$instcat2 %in% c(3, 4) & institutions$control==1] <- 3

### PRIVATE
# private nonprofit research
institutions$carnegie_urban[institutions$ccbasic2 %in% c(15, 16, 17) & institutions$control==2] <- 4
# private nonprofit masters
institutions$carnegie_urban[institutions$ccbasic2 %in% c(18, 19, 20) & institutions$control==2] <- 5
# private nonprofit bachelors
institutions$carnegie_urban[institutions$instcat2==2 & institutions$control==2 & institutions$carnegie_urban==0] <- 6

# for profit
institutions$carnegie_urban[institutions$control==3] <- 7

#### SMALL GROUPS
# public bachelors
institutions$carnegie_urban[institutions$instcat2==2 & institutions$control==1 & institutions$carnegie_urban==0] <- 8
# private nonprofit associates
institutions$carnegie_urban[institutions$instcat2 %in% c(3,4) & institutions$control==2] <- 8

# Special focus
institutions$carnegie_urban[institutions$specialty==1] <- 9

# non degree granting excluded
institutions$carnegie_urban[institutions$deggrant2==2] <- NA


########################################################################################################
# Basic sector - sector_urban (named sectorv2 in Stata draft do files)
# 1 "public two-year" 2 "public four-year" 3 "private nonprofit four-year" 4 "for profit" 5 "other" 6 "non-degree-granting"
########################################################################################################
# IPEDS version
# SECTOR	0	Administrative Unit
# SECTOR	1	Public, 4-year or above
# SECTOR	2	Private not-for-profit, 4-year or above
# SECTOR	3	Private for-profit, 4-year or above
# SECTOR	4	Public, 2-year
# SECTOR	5	Private not-for-profit, 2-year
# SECTOR	6	Private for-profit, 2-year
# SECTOR	7	Public, less-than 2-year
# SECTOR	8	Private not-for-profit, less-than 2-year
# SECTOR	9	Private for-profit, less-than 2-year

institutions$sector_urban <- 0
# public and fewer than 50% of degrees/certificates are bachelor's or higher
institutions$sector_urban[institutions$instcat2 %in% c(3,4) & institutions$control==1] <- 1
# public and more than 50% of degrees/certificates are bachelor's or higher
institutions$sector_urban[institutions$instcat2==2 & institutions$control==1] <- 2
# private and more than 50% of degrees/certificates are bachelor's or higher
institutions$sector_urban[institutions$instcat2==2 & institutions$control==2] <- 3
# for profit, any level
institutions$sector_urban[institutions$control==3] <- 4
# other degree-granting (small groups and special focus)
institutions$sector_urban[institutions$carnegie_urban %in% c(8,9) & institutions$sector_urban==0] <- 5
# non-degree-granting
institutions$sector_urban[institutions$deggrant2==2] <- 6

# Check
table(institutions$carnegie_urban, institutions$sector_urban)

write.csv(institutions, "data/ipeds/institutions.csv", row.names=F, na="")

institutionskeep <- institutions %>% filter(sector_urban > 0 & pset4flg2==1)
table(institutionskeep$year)

########################################################################################################
# Format institutions dataset
# Fun: in 1986, unitids are all screwy
########################################################################################################

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
