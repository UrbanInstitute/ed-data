#Hannah Recht, 12-07-15
#Download and process higher education dashboard data

library(dplyr)
library(tidyr)
library(openxlsx)
library(readxl)

########################################################################################################
# Define datasets
########################################################################################################

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

########################################################################################################
# Annual tuition & fees from College Board
########################################################################################################

#TABLE 2. Average Tuition and Fees and Room and Board (Enrollment-Weighted) in Current Dollars and in 2015 Dollars, 1971-72 to 2015-16
#Only need first section - 2015 dollars, and don't need % change columns
tab2<-readWorkbook(cpx, sheet="Table 2", colNames=T, rowNames=F, rows=3:48, cols=c(1,2,4,6,8,10))
colnames(tab2) <- c("year_academic", "tufees_prnp4", "tufees_pub4", "tufees_pub2", "tufeesrmbd_prnp4", "tufeesrmbd_pub4")
tab2 <- tab2 %>% mutate(year_type = "academic", statefip=0, dollars = 2015)
# Split academic year formatted as "XX-XX" into one numeric year column
tab2 <- tab2 %>% mutate(year=sapply(strsplit(tab2$year_academic, split='-', fixed=TRUE),function(x) (x[1])))
tab2$year <- as.numeric(tab2$year)
tab2 <- tab2 %>% mutate(year = ifelse(year > 30, year+1900,
                                      year + 2000))
tab2 <- tab2 %>% select(c(statefip,year,year_type, dollars), everything()) %>% select(-year_academic)
write.csv(tab2,"data/nationaltuition.csv",row.names=F, na="")

#TABLE 5. Average Published Tuition and Fees by State in Current Dollars and in 2015 Dollars, 2004-05 to 2015-16
#Left (a): public two-year in district
#Right (b): public four-year in state
tab5a<-readWorkbook(cpx, sheet="Table 5", colNames=T, rowNames=F, rows=3:55, cols=1:13)
tab5b<-readWorkbook(cpx, sheet="Table 5", colNames=T, rowNames=F, rows=3:55, cols=c(1,16:28))
names_tuition <- c("state", "y_2004", "y_2005", "y_2006", "y_2007", "y_2008", "y_2009", "y_2010", "y_2011", "y_2012", "y_2013", "y_2014", "y_2015")

#Make long
formatLong <- function(dt) {
  colnames(dt) <- names_tuition
  dt[ dt == "N/A" ] = NA
  long <- dt %>% gather(year,tuition,2:13)
  long$year <- as.character(long$year)
  long$tuition <- as.numeric(long$tuition)
  long <- long %>% mutate(year=sapply(strsplit(long$year, split='_', fixed=TRUE),function(x) (x[2])))
  long$year <- as.numeric(long$year)
  long <- long
}

tab5a <- formatLong(tab5a) %>% rename(tufees_pub2 = tuition)
tab5b <- formatLong(tab5b) %>% rename(tufees_pub4 = tuition)
tuition_cb <- left_join(tab5a,tab5b, by=c("state","year")) %>% mutate(dollars=2015,year_type="academic")
tuition_cb  <- right_join(states,tuition_cb, by="state")
write.csv(tuition_cb,"data/annualtuition.csv",row.names=F, na="")
