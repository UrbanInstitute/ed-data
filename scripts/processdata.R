#Hannah Recht, 12-07-15
#Download and process higher education dashboard data

library(dplyr)
library(openxlsx)
library(readxl)

#State fips codes, abbreviations, names, regions for matching
states <- read.csv("data/states.csv",stringsAsFactors = F)

#College Board Trends in College Pricing - xls, need to save as xlsx to use openxlsx - probably worth it
cp = "data/original/cbtrends-pricing2015.xls"
cpx = "data/original/cbtrends-pricing2015.xlsx"
download.file("http://trends.collegeboard.org/sites/default/files/2015-trends-college-pricing-source-data-11-2-15.xls", cp)

#Trends in Student Aid
sa = "data/original/cbtrends-studentaid2015.xls"
sax = "data/original/cbtrends-studentaid2015.xlsx"
download.file("http://trends.collegeboard.org/sites/default/files/2015-trends-student-aid-source-data-final.xls", sa)

#Read in relevant data
#College Board prices
#TABLE 2. Average Tuition and Fees and Room and Board (Enrollment-Weighted) in Current Dollars and in 2015 Dollars, 1971-72 to 2015-16
#Only need first section - 2015 dollars
tab2<-readWorkbook(cpx, sheet="Table 2", colNames=T, rowNames=F, rows=3:48)
colnames(tab2) <- c("year_academic", "tufees_prnp4", "a", "tufees_pub4", "b", "tufees_pub2", "c", "tufeesrmbd_prnp4", "d", "tufeesrmbd_pub4", "e")
tab2 <- tab2 %>% select (-c(a,b,c,d,e))