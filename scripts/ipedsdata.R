#Hannah Recht, 12-14-15
#Analyze data from IPEDS - http://nces.ed.gov/ipeds/datacenter/Data.aspx

library(dplyr)
library(tidyr)

#download identifying variables and dictionary
download.file("http://nces.ed.gov/ipeds/datacenter/data/HD2014.zip","data/original/ipedsidentifiers.zip")
unzip("data/original/ipedsidentifiers.zip", exdir="data/original/")

ids <- read.csv("data/original/hd2014.csv", stringsAsFactors = F)
colnames(ids) <- tolower(colnames(ids))

download.file("http://nces.ed.gov/ipeds/datacenter/data/HD2014_Dict.zip","data/original/ipedsdictionary.zip")
unzip("data/original/ipedsdictionary.zip", exdir="data/original/")

#Choose key identifying variables
colleges <- ids %>% select(unitid,instnm,city,stabbr,fips,sector,iclevel,control)

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


########################################################################################################
# Annual enrollment data from IPEDS
########################################################################################################

enrollment <- read.csv("data/enrollment/Data_12-14-2015.csv", stringsAsFactors = F)
colnames(enrollment) <- tolower(colnames(enrollment))
rawnames <- colnames(enrollment)

#ef = enrollment fall
#total = part time + full time
#ft = full time
#pt = part time
#20 = undergraduate
#50 = graduate and professional

enrollment <- left_join(colleges,enrollment,by="unitid")

