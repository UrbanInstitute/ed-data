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
#test
fig1<-readWorkbook(cpx, sheet="Fig 1", colNames=T, rowNames=F, rows=2:6)