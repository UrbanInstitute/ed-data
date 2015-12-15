#Hannah Recht, 12-14-15
#Analyze data from IPEDS - http://nces.ed.gov/ipeds/datacenter/Data.aspx

library(dplyr)
library(tidyr)

#State fips codes, abbreviations, names, regions for matching
states <- read.csv("data/states.csv",stringsAsFactors = F)

#download identifying variables and dictionary
download.file("http://nces.ed.gov/ipeds/datacenter/data/HD2014.zip","data/original/ipedsidentifiers.zip")
unzip("data/original/ipedsidentifiers.zip", exdir="data/original/")

ids <- read.csv("data/original/hd2014.csv", stringsAsFactors = F)
colnames(ids) <- tolower(colnames(ids))

download.file("http://nces.ed.gov/ipeds/datacenter/data/HD2014_Dict.zip","data/original/ipedsdictionary.zip")
unzip("data/original/ipedsdictionary.zip", exdir="data/original/")

#Choose key identifying variables
colleges <- ids %>% select(unitid,fips,sector,iclevel,control)

#Format variable name meanings correctly
varnames <- read.csv("data/collegeidentifiers/varnames.csv", stringsAsFactors = F, sep='"')
varnames <- varnames %>% select(-X)
write.csv(varnames,"data/collegeidentifiers/varnames.csv",row.names=F, na="")

#Important value labels
# SECTOR (HD2014)	0	Administrative Unit
# SECTOR (HD2014)	1	Public, 4-year or above
# SECTOR (HD2014)	2	Private not-for-profit, 4-year or above
# SECTOR (HD2014)	3	Private for-profit, 4-year or above
# SECTOR (HD2014)	4	Public, 2-year
# SECTOR (HD2014)	5	Private not-for-profit, 2-year
# SECTOR (HD2014)	6	Private for-profit, 2-year
# SECTOR (HD2014)	7	Public, less-than 2-year
# SECTOR (HD2014)	8	Private not-for-profit, less-than 2-year
# SECTOR (HD2014)	9	Private for-profit, less-than 2-year
# SECTOR (HD2014)	99	Sector unknown (not active)
# ICLEVEL (HD2014)	1	Four or more years
# ICLEVEL (HD2014)	2	At least 2 but less than 4 years
# ICLEVEL (HD2014)	3	Less than 2 years (below associate)
# ICLEVEL (HD2014)	-3	{Not available}
# CONTROL (HD2014)	1	Public
# CONTROL (HD2014)	2	Private not-for-profit
# CONTROL (HD2014)	3	Private for-profit
# CONTROL (HD2014)	-3	{Not available}

# 20 = undergraduate
# 50 = graduate and professional

#Total price for in-district students living on campus  2014-15 (DRVIC2014)	CINDON (DRVIC2014)
#Total price for in-state students living on campus 2014-15 (DRVIC2014)	CINSON (DRVIC2014)
#Total price for out-of-state students living on campus 2014-15 (DRVIC2014)	COTSON (DRVIC2014)

#ef = enrollment fall
#total = part time + full time
#ft = full time
#pt = part time
#20 = undergraduate
#50 = graduate and professional

########################################################################################################
# Annual enrollment data from IPEDS
########################################################################################################

enrollment <- read.csv("data/enrollment/Data_12-14-2015.csv", stringsAsFactors = F)
#useful column names
colnames(enrollment) <- tolower(colnames(enrollment))
rawnames <- colnames(enrollment)
names <- as.data.frame(rawnames) %>% separate(rawnames, into = paste("V", 1:6, sep = "."))
names$rawname <- rawnames
names[ names == "" ] = NA
names <- names %>% select(-V.6)
table(names$V.1) 
table(names$V.2)
table(names$V.3)
table(names$V.4)
table(names$V.5)
#years are all encoded in second position (V.2) - split into new column
names <- names %>% mutate(year = gsub("[^[:digit:]]","",names$V.2)) %>% rename(category=V.1)
names <- names %>% mutate(type = ifelse(category=="cindon"|category=="cinson"|category=="cotson", "totalprice",
                                        ifelse(category=="efft"|category=="efpt"|category=="eftotal", "enrollment",
                                               "identifier")))
names <- names %>% mutate(studenttype = ifelse(category=="efft", "fulltime",
                                               ifelse(category=="efpt", "parttime",
                                                      ifelse(category=="eftotal", "total",
                                                             ifelse(category=="cindon", "indistricton",
                                                                    ifelse(category=="cinson", "instateon",
                                                                           ifelse(category=="cotson", "outstateon",
                                                                              NA)))))))
names <- names %>% mutate(studentlevel = (as.numeric(gsub("[^[:digit:]]","",names$V.4)) + as.numeric(gsub("[^[:digit:]]","",names$V.5))))
names <- names %>% mutate(temp1 = as.numeric(gsub("[^[:digit:]]","",names$V.4)), temp2 = as.numeric(gsub("[^[:digit:]]","",names$V.5)))
names$temp1[is.na(names$temp1)] <- 0
names$temp2[is.na(names$temp2)] <- 0
names <- names %>% mutate(studentlevel = temp1+temp2) %>%
  select(-temp1,-temp2)
names$studentlevel[names$studentlevel == 0] <- NA

enrollnames <- names %>% select(rawname,year, type,studenttype,studentlevel)
write.csv(enrollnames,"data/enrollment/varnames.csv",row.names=F, na="")

enrollment <- left_join(colleges,enrollment,by="unitid") %>% 
  select(-institution.name)
# Calculate means and sums by sector and state
####NEED TO DO WEIGHTED MEAN FOR PRICE
enrollsum <- enrollment %>% group_by(fips,sector) %>% summarise_each(funs(sum(., na.rm = TRUE)))
enrollmean <- enrollment %>% group_by(fips,sector) %>% summarise_each(funs(mean(., na.rm = TRUE)))

temp1 <- enrollsum %>% gather(rawname, sum, 6:243) %>% select(fips,sector,rawname,sum)
temp2 <- enrollmean %>% gather(rawname, mean, 6:243) %>% select(fips,sector,rawname,mean)

#Join together and add variable name columns
enrollstats <- left_join(temp1,temp2,by=c("fips","sector","rawname"))
enrollstats$rawname <- as.character(enrollstats$rawname)
enrollstats <- left_join(enrollstats, enrollnames, by="rawname")
enrollstats <- enrollstats %>% filter(sector >=1 & sector <=5 & type!="identifier")
price <- enrollstats %>% filter(type=="totalprice") %>% 
  select(-sum,-studentlevel,-type, -rawname) %>% 
  rename(totalprice = mean)
pricewide <- price %>% spread(studenttype,totalprice)

# Make wide enrollment dataset
enroll<- enrollstats %>% filter(type=="enrollment") %>%
  select(-mean,-type, -rawname) %>% 
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
  select(abbrev,everything())
enrollwide <- enrollwide %>% mutate(tot_all = tot_ug + tot_gp)
write.csv(enrollwide,"data/enrollment.csv",row.names=F, na="")
