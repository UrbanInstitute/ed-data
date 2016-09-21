# Create IPEDS institutions identifiers dataset
# Get IPEDS data using scraper https://github.com/UrbanInstitute/ipeds-scraper

library("dplyr")
library("tidyr")

# Functions to return ipeds data
source("scripts/ipedsFunctions.R")

########################################################################################################
# Get main insitutional characteristics
#######################################################################################################

# Institutional characteristics vars
instvars <- c("fips", "stabbr", "instnm", "sector", "pset4flg", "instcat", "ccbasic", "control", "deggrant", "opeflag", "opeind", "opeid", "carnegie", "hloffer")
institutions <- returnData(instvars)

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
levelsdt <- returnData(c("level3", "level5", "level7", "level9", "level10"))
# Add to institutions dataset
institutions <- left_join(institutions, levelsdt, by = c("unitid", "year"))

########################################################################################################
# finaid9 for <1996
# replace zeros with 1 if institution is NOT 'not eligible for any of the above' federal financial aid programs
########################################################################################################
finaid9 <- returnData("finaid9")

# Add to institutions dataset
institutions <- left_join(institutions, finaid9, by = c("unitid", "year"))
write.csv(institutions, "data/ipeds/institutions_raw.csv", row.names=F, na="")

rm(list=setdiff(ls(), c("institutions", "ipeds", "ipedspath")))

########################################################################################################
# Format institutions dataset
# Fun: in 1986, unitids are all screwy
# As of 06/13/16 - using 1994+
########################################################################################################

institutions <- read.csv("data/ipeds/institutions_raw.csv", stringsAsFactors = F)
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

institutions <- as.data.frame(institutions)
institutions <- institutions %>% mutate(deggrant2 = deggrant) %>%
  mutate(deggrant2 = replace(deggrant2, 
                             (year < 2000 & (level3==1 | level5==1 | level7==1 | level9==1 | level10==1)),
                             1)) %>%
  mutate(deggrant2 = replace(deggrant2, 
                             (year < 2000 & !(level3==1 | level5==1 | level7==1 | level9==1 | level10==1)),
                             2))

########################################################################################################
# pset4flg - Postsecondary and Title IV institution indicator
# This is near impossible to make <1994
########################################################################################################

# PSET4FLG	1	Title IV postsecondary institution
# PSET4FLG	2	Non-Title IV postsecondary institution
# PSET4FLG	3	Title IV NOT primarily postsecondary institution
# PSET4FLG	4	Non-Title IV NOT primarily postsecondary institution
# PSET4FLG	6	Non-Title IV postsecondary institution that is NOT open to the public
# PSET4FLG	9	Institution is not active in current universe
table(institutions$pset4flg)

institutions <- institutions %>% mutate(pset4flg2 = pset4flg) %>%
  # institution is NOT 'not eligible for any of the above' federal financial aid programs
  mutate(pset4flg2 = replace(pset4flg2, 
                             (year < 1997 & finaid9 != 1) | (year < 1996 & is.na(finaid9)),
                             1)) %>%
  # participates in Title IV federal financial aid programs
  mutate(pset4flg2 = replace(pset4flg2, 
                             (year %in% c(1996, 1997, 1998, 1999) & (opeind == 1 | opeflag == 1)),
                             1)) %>%
  # 1995: if opeid exists
  mutate(pset4flg2 = replace(pset4flg2, 
                             (year == 1995 & !is.na(opeid)),
                             1))

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

institutions <- institutions %>% mutate(instcat2 = instcat) %>%
  # Master's, Doctor's, or first-professional, no bachelor's, no associate's
  mutate(instcat2 = replace(instcat2, 
                             (year < 2004 & deggrant2==1 & (level7==1 | level9==1 | level10==1) & level5!=1 & level3!=1),
                             1)) %>%
  # Bachelor's or higher, primarily bachelor's or higher
  mutate(instcat2 = replace(instcat2, 
                            (year < 2004 & deggrant2==1 & (level7==1 | level9==1 | level10==1) & degrees_pctbachplus > 0.5),
                            2)) %>%
  # Bachelor's or higher, primarily below bachelor's
  mutate(instcat2 = replace(instcat2, 
                            (year < 2004 & deggrant2==1 & (level7==1 | level9==1 | level10==1) & degrees_pctbachplus <= 0.5),
                            3)) %>%
  # Highest degree is associate's (may have post-bacc certificates)
  mutate(instcat2 = replace(instcat2, 
                            (year < 2004 & deggrant2==1 & level3==1 & level5!=1 & level7!=1 & level9!=1 & level10!=1),
                            4)) %>%
  # post-bacc certificates, no degrees
  mutate(instcat2 = replace(instcat2, 
                            (year < 2004 & deggrant2==2 & hloffer >= 6),
                            5)) %>%
  # no post-bacc certificates, no degrees
  mutate(instcat2 = replace(instcat2, 
                            (year < 2004 & deggrant2==2 & hloffer < 6),
                            6)) %>%
  # Sector 0 = NA instcat (-2)
  mutate(instcat2 = replace(instcat2, 
                            (year < 2004 & sector==0),
                            -2))

table(institutions$instcat2)

########################################################################################################
# ccbasic for 1994 - 2004
# can't make but don't need earlier years so not an issue
# We'll generally be using carnegie for the latest year but sector over time
########################################################################################################

institutions <- institutions %>% mutate(ccbasic2 = ccbasic) %>%
  # doctoral and research level
  mutate(ccbasic2 = replace(ccbasic2, (year < 2000 & year >= 1994 & carnegie %in% c(11, 12, 13, 14)), 15)) %>%
  mutate(ccbasic2 = replace(ccbasic2, (year < 2005 & year >= 2000 & carnegie %in% c(15, 16)), 15)) %>%
  # masters level
  mutate(ccbasic2 = replace(ccbasic2, (year < 2005 & year >= 1994 & carnegie %in% c(21, 22)), 20)) %>%
  # special focus
  mutate(ccbasic2 = replace(ccbasic2, (year < 2005 & year >= 1994 & carnegie > 50), 25))
table(institutions$ccbasic2)

########################################################################################################
# Redefined carnegie for this project - carnegie_urban
# 1 "public research" 2 "public masters" 3 "public associates" 4 "private nonprofit research" 5 "private nonprofit masters"
# 6 "private nonprofit bachelors" 7 "for profit" 8 "small groups" 9 "special focus"
########################################################################################################
# Special institutions - graduate-students only or other special focus
institutions <- institutions %>% mutate(specialty = 0) %>%
  # doctoral and research level
  mutate(specialty = replace(specialty, (instcat2==1 | ccbasic2 > 23), 1))

institutions <- institutions %>% mutate(carnegie_urban = 0) %>%
  ### PUBLIC
  # public research
  mutate(carnegie_urban = replace(carnegie_urban, ccbasic2 %in% c(15, 16, 17) & control==1, 1)) %>%
  # public masters
  mutate(carnegie_urban = replace(carnegie_urban, ccbasic2 %in% c(18, 19, 20) & control==1, 2)) %>%
  # public associates
  mutate(carnegie_urban = replace(carnegie_urban, ccbasic2 %in% c(3, 4) & control==1, 3)) %>%
  
  ### PRIVATE
  # private nonprofit research
  mutate(carnegie_urban = replace(carnegie_urban, ccbasic2 %in% c(15, 16, 17) & control==2, 4)) %>%
  # private nonprofit masters
  mutate(carnegie_urban = replace(carnegie_urban, ccbasic2 %in% c(18, 19, 20) & control==2, 5)) %>%
  # private nonprofit bachelors
  mutate(carnegie_urban = replace(carnegie_urban, instcat2==2 & control==2 & carnegie_urban==0, 6)) %>%
  # for profit
  mutate(carnegie_urban = replace(carnegie_urban, control==3, 7)) %>%

  #### SMALL GROUPS
  # public bachelors
  mutate(carnegie_urban = replace(carnegie_urban, instcat2==2 & control==1 & carnegie_urban==0, 8)) %>%
  # private nonprofit associates
  mutate(carnegie_urban = replace(carnegie_urban, instcat2 %in% c(3,4) & control==2, 8)) %>%
  # Special focus
  mutate(carnegie_urban = replace(carnegie_urban, specialty==1, 9)) %>%
  # non degree granting excluded
  mutate(carnegie_urban = replace(carnegie_urban, deggrant2==2, NA))

# String variables
institutions <- institutions%>% mutate(carnegie_label = ifelse(carnegie_urban == 1, "Public research",
                                                               ifelse(carnegie_urban == 2, "Public master's",
                                                                      ifelse(carnegie_urban == 3, "Public associate's",
                                                                             ifelse(carnegie_urban == 4, "Private nonprofit research",
                                                                                    ifelse(carnegie_urban == 5, "Private nonprofit master's",
                                                                                           ifelse(carnegie_urban == 6, "Private nonprofit bachelor's",
                                                                                                  ifelse(carnegie_urban == 7, "For profit",
                                                                                                         ifelse(carnegie_urban == 8, "Small groups",
                                                                                                                ifelse(carnegie_urban == 9, "Special focus",
                                                                                                                       ""))))))))))

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

institutions <- institutions %>% mutate(sector_urban = 0) %>%
  # public and fewer than 50% of degrees/certificates are bachelor's or higher
  mutate(sector_urban = replace(sector_urban, instcat2 %in% c(3,4) & control==1, 1)) %>%
  # public and more than 50% of degrees/certificates are bachelor's or higher
  mutate(sector_urban = replace(sector_urban, instcat2==2 & control==1, 2)) %>%
  # private and more than 50% of degrees/certificates are bachelor's or higher
  mutate(sector_urban = replace(sector_urban, instcat2==2 & control==2, 3)) %>%
  # for profit, any level
  mutate(sector_urban = replace(sector_urban, control==3, 4)) %>%
  # other degree-granting (small groups and special focus)
  # NOTE: We cannot include public bachelor's and special focus institutions in 'other' prior to 1994 because
  # defining those categories requires ccbasic. We can only include private nonprofit associate's institutions.
  mutate(sector_urban = replace(sector_urban, 
                                (carnegie_urban %in% c(8,9) & year>=1994) | (instcat2 %in% c(3, 4) & control==2 & year < 1994), 
                                5)) %>%
  # non-degree-granting
  mutate(sector_urban = replace(sector_urban, deggrant2==2, 6))

# String variables
institutions <- institutions%>% mutate(sector_label = ifelse(sector_urban == 1, "Public two-year",
                                                               ifelse(sector_urban == 2, "Public four-year",
                                                                      ifelse(sector_urban == 3, "Private nonprofit four-year",
                                                                             ifelse(sector_urban == 4, "For-profit",
                                                                                    ifelse(sector_urban == 5, "Other",
                                                                                           ifelse(sector_urban == 6, "Non-degree-granting",
                                                                                                                       "")))))))

# Check
table(institutions$carnegie_label, institutions$sector_label)
table(institutions$sector_label, institutions$year)

# Remove some of the original variables (all saved in institutions_raw if needed again)
colnames(institutions)
institutions <- institutions %>% select(-hloffer, -opeid, -opeind, -opeflag, -sector, -control, -carnegie, -deggrant, -pset4flg, -instcat, -ccbasic, -starts_with("level"), -finaid9,
                                        -instcat2, -ccbasic2, -yearsin)

write.csv(institutions, "data/ipeds/institutions.csv", row.names=F, na="")

institutionskeep <- institutions %>% filter(sector_urban > 0 & pset4flg2==1)
table(institutionskeep$year)
table(institutionskeep$sector_urban, institutionskeep$year)
