########################################################################################################
# Hannah Recht, 12-14-15
# Analyze data from IPEDS - http://nces.ed.gov/ipeds/datacenter/Data.aspx
########################################################################################################

library(dplyr)
library(tidyr)
library(openxlsx)

#State fips codes, abbreviations, names, regions for matching
states <- read.csv("data/states.csv",stringsAsFactors = F)

########################################################################################################
# Download institutional variables and dictionary
# Source: "complete data files", 2014 from http://nces.ed.gov/ipeds/datacenter/DataFiles.aspx
########################################################################################################

download.file("http://nces.ed.gov/ipeds/datacenter/data/HD2014.zip","data/original/ipedsidentifiers.zip")
unzip("data/original/ipedsidentifiers.zip", exdir="data/original/")

download.file("http://nces.ed.gov/ipeds/datacenter/data/HD2014_Dict.zip","data/original/ipedsdictionary.zip")
unzip("data/original/ipedsdictionary.zip", exdir="data/original/")

ids <- read.csv("data/original/hd2014.csv", stringsAsFactors = F)
colnames(ids) <- tolower(colnames(ids))

#Choose key identifying variables
colleges <- ids %>% select(unitid,fips,sector,iclevel,control)

#Format variable name meanings correctly
varnames <- read.csv("data/collegeidentifiers/varnames.csv", stringsAsFactors = F, sep='"')
varnames <- varnames %>% select(-X)
write.csv(varnames,"data/collegeidentifiers/varnames.csv",row.names=F, na="")

########################################################################################################
# Column names from custom data files include spaces, parentheses, etc - need a lot of editing
# Make dataframe of column names for creating wide datasets
########################################################################################################

editnames <- function(dt) {
  colnames(dt) <- tolower(colnames(dt))
  rawnames <- colnames(dt)
  #so far max 6 columns needed - adjust if more later
  names <- as.data.frame(rawnames) %>% separate(rawnames, into = paste("V", 1:6, sep = "."))
  names$rawname <- rawnames
  names[ names == "" ] = NA
  #remove columns of all NA
  names <- names[, colSums(is.na(names)) != nrow(names)]
  names <- names %>% mutate(year = gsub("[^[:digit:]]","",names$V.2)) %>% 
    filter(V.1 !="x")
}

########################################################################################################
# Annual enrollment data from IPEDS
# NCES only includes Title 4 schools
# Dataset has some total price info - will revisit later if using
########################################################################################################

enrollment <- read.csv("data/original/enrollment_ipeds/Data_12-14-2015.csv", stringsAsFactors = F)
colnames(enrollment) <- tolower(colnames(enrollment))

########################################################################################################
# Enrollment dataset specific name editing
########################################################################################################

enames <- editnames(enrollment)
table(enames$V.1) 
table(enames$V.2)
table(enames$V.3)
table(enames$V.4)
table(enames$V.5)

enrollnames <- function(names) {
  #years are all encoded in second position (V.2) - split into new column
  names <- names %>% rename(category=V.1) %>% 
    mutate(type = ifelse(category=="cindon"|category=="cinson"|category=="cotson", "totalprice",
                         ifelse(category=="efft"|category=="efpt"|category=="eftotal", "enrollment",
                                "identifier"))) %>% 
    mutate(studenttype = ifelse(category=="efft", "fulltime",
                                ifelse(category=="efpt", "parttime",
                                       ifelse(category=="eftotal", "total",
                                              ifelse(category=="cindon", "indistricton",
                                                     ifelse(category=="cinson", "instateon",
                                                            ifelse(category=="cotson", "outstateon",
                                                                   NA))))))) %>% 
    mutate(studentlevel = (as.numeric(gsub("[^[:digit:]]","",names$V.4)) + as.numeric(gsub("[^[:digit:]]","",names$V.5)))) %>% 
    mutate(temp1 = as.numeric(gsub("[^[:digit:]]","",names$V.4)), temp2 = as.numeric(gsub("[^[:digit:]]","",names$V.5)))
  names$temp1[is.na(names$temp1)] <- 0
  names$temp2[is.na(names$temp2)] <- 0
  names <- names %>% mutate(studentlevel = temp1+temp2) %>%
    select(-temp1,-temp2)
  names$studentlevel[names$studentlevel == 0] <- NA
  names <- names %>% select(rawname,year, type,studenttype,studentlevel)
}

enames <- enrollnames(enames)

write.csv(enames,"data/original/enrollment_ipeds/varnames.csv",row.names=F, na="")

########################################################################################################
# Compute enrollment sums by state, sector
# Reshape and join to new variable name categories to make wide enrollment dataset
# State x sector x year - enrollment by fulltime/parttime x undergraduate/grad&professional
########################################################################################################

enrollment <- left_join(colleges,enrollment,by="unitid") %>% 
  select(-institution.name)
# Calculate sums by sector and state
enrollsum <- enrollment %>% group_by(fips,sector) %>% summarise_each(funs(sum(., na.rm = TRUE)))

enrollstats <- enrollsum %>% gather(rawname, sum, 6:243) %>% select(fips,sector,rawname,sum)
enrollstats$rawname <- as.character(enrollstats$rawname)
enrollstats <- left_join(enrollstats, enames, by="rawname")
enrollstats <- enrollstats %>% filter(sector >=1 & sector <=5 & type!="identifier")

# Make wide enrollment dataset
enroll<- enrollstats %>% filter(type=="enrollment") %>%
  select(-type, -rawname) %>% 
  rename(enrollment = sum)

enrollwide <- enroll %>% mutate(studenttype = ifelse(studenttype=="total", "tot",
                                                     ifelse(studenttype=="parttime", "pt",
                                                            ifelse(studenttype=="fulltime","ft", NA)))) %>%
  mutate(studentlevel = ifelse(studentlevel==20, "ug",
                               ifelse(studentlevel==50, "gp", NA))) %>%
  mutate(student=paste(studenttype, studentlevel, sep="_")) %>%
  select(-studenttype,-studentlevel) %>%
  spread(student,enrollment)

enrollwide <- left_join(enrollwide,states,by=c("fips"="statefip"))
enrollwide <- enrollwide %>% select(-state,-region) %>%
  arrange(sector,fips,year) %>%
  select(abbrev,everything()) %>% 
  mutate(tot_all = tot_ug + tot_gp)
write.csv(enrollwide,"data/enrollment_ipeds.csv",row.names=F, na="")

rm(temp1,enrollsum,enrollstats,enrollment,enames,enroll)

########################################################################################################
# Non-Enrollment data - a bunch of things that we may use for 2013-14, 2014-15
########################################################################################################

dt <- read.csv("data/original/nonenrollment_ipeds/Data_12-15-2015.csv",stringsAsFactors = F)
varlabs <- read.csv("data/original/nonenrollment_ipeds/variablelabels.csv",stringsAsFactors = F)

########################################################################################################
# Tuition and fees
# Because of 250 column limit, had to split years into two files
# Dictionary ish http://nces.ed.gov/ipeds/datacenter/data/IC2014_AY_Dict.zip
########################################################################################################

tfa <- read.csv("data/original/tuitionfees_ipeds/Data_12-16-2015a.csv",stringsAsFactors = F) #2005-06 to 2014-15
tfb <- read.csv("data/original/tuitionfees_ipeds/Data_12-16-2015b.csv",stringsAsFactors = F) #1999-00 to 2004-05

#Download, read dictionary
download.file("http://nces.ed.gov/ipeds/datacenter/data/IC2014_AY_Dict.zip", "data/tuitionfees_ipeds/tfdictionary.zip")
unzip("data/original/tuitionfees_ipeds/tfdictionary.zip", exdir="data/original/tuitionfees_ipeds")
tfdict <- readWorkbook("data/original/tuitionfees_ipeds/ic2014_ay.xlsx", sheet="varlist", colNames=T, rowNames=F)
tfdict$varname <- tolower(tfdict$varname)
tfdict <- tfdict %>% select(varname,varTitle)

tf <- left_join(tfa,tfb, by=c("UnitID", "Institution.Name"))
tfnames <- editnames(tf)
tftypes <- as.data.frame(table(tfnames$V.1))
table(tfnames$V.2)
table(tfnames$V.3)
table(tfnames$V.4)

#Join titles from dictionary to names
tftypes <- left_join(tftypes,tfdict,by=c("Var1"="varname"))
#Remove the year from names
tftypes$varTitle <- substr(tftypes$varTitle, 1, nchar(tftypes$varTitle)-8)
tfnames <- left_join(tfnames,tftypes,by=c("V.1"="Var1"))
tfnames <- tfnames %>% select(-V.3,-V.4,-Freq)
