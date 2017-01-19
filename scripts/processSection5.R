
library(dplyr)
library(tidyr)
library(jsonlite)
library(openxlsx)


source('~/Documents/ed-data/scripts/createJsons.R')
textpath <- "/Users/vhou/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) Project/**Production/"
graphtext <- readWorkbook(paste(textpath, "GraphText.xlsx", sep=""),sheet = 1)
graphtext$section_number <- as.numeric(graphtext$section_number)
graphtext$multiples <- as.numeric(graphtext$multiples)
graphtext$toggle <- as.numeric(graphtext$toggle)

#Figure 5-19
##add ` "hideTooltip": true ` to outermost bracket
fig5_19<- read.csv(paste(textpath, "Covering Expenses_time to degree/05_0190.csv", sep=""),stringsAsFactors=FALSE)
json5_19<- makeJson(sectionn = 5, graphn = 19, dt = fig5_19, graphtype = "bar",
                    series = c("Average years enrolled", "Average years elasped"),
                    categories = fig5_19$category, tickformat = "number", rotated = FALSE, directlabels = TRUE)
#Figure 5-32
fig5_32<- read.csv(paste(textpath, "Covering Expenses_savings/05_0320.csv", sep=""),stringsAsFactors=FALSE)
json5_32<- makeJson(sectionn = 5, graphn = 32, dt = fig5_32$X..of.PSE.students, graphtype = "line",
                    series = "Percentage",
                    categories = fig5_32$X, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 5-31
fig5_31a<- read.csv(paste(textpath, "Covering Expenses_savings/05_0310.csv", sep=""),stringsAsFactors=FALSE)
fig5_31b<- read.csv(paste(textpath, "Covering Expenses_savings/05_0311.csv", sep=""),stringsAsFactors=FALSE)

json5_31a<- makeJson(sectionn = 5, graphn = 311, dt = fig5_31a$Number.of.accounts..millions., graphtype = "bar",
                    series = "Accounts in millions", ylabel= "In millions",
                    categories = fig5_31a$X, tickformat = "number", rotated = FALSE, directlabels = TRUE)
json5_31b<- makeJson(sectionn = 5, graphn = 312, dt = fig5_31b$Average.Account..Thousands.of.2015.Dollars, graphtype = "bar",
                    series = "Average account size in thousands",
                    categories = fig5_31b$X, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)


#Figure 5-30
fig5_30<- read.csv(paste(textpath, "Covering Expenses_savings/05_0300.csv", sep=""),stringsAsFactors=FALSE)
json5_30<- makeJson(sectionn = 5, graphn = 30, dt = fig5_30, graphtype = "line",
                    series = c("No high school diploma", "High school diploma", "Some college", "Bachelor's Degree or Higher"),
                    categories = fig5_30$X, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 5-29

fig5_29<- read.csv(paste(textpath, "Covering Expenses_savings/05_0290.csv", sep=""),stringsAsFactors=FALSE)
json5_29<- makeJson(sectionn = 5, graphn = 29, dt = fig5_29, graphtype = "line",
                    series = c("White non-Hispanic", "Non-white or Hispanic"),
                    categories = fig5_29$X, tickformat = "$.2s", rotated = FALSE, directlabels = TRUE)

#Figure 5-28
#add ` "hideTooltip": true ` to outermost bracket
fig5_28<- read.csv(paste(textpath, "Covering Expenses_savings/05_0280.csv", sep=""),stringsAsFactors=FALSE)
json5_28<- makeJson(sectionn = 5, graphn = 28, dt = fig5_28, graphtype = "bar",
                    series = c("Lowest quintile", "Second quintile", "Third quintile", "Fourth quintile", "Highest quintile"),
                    categories = fig5_28$X, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)

#Figure 5-27
fig5_27<- read.csv(paste(textpath, "Covering Expenses_savings/05_0270.csv", sep=""),stringsAsFactors=FALSE)
json5_27<- makeJson(sectionn = 5, graphn = 27, dt = fig5_27, graphtype = "line",
                    series = c("All Families", "Family with head age 45–54", "Single with children", "Couple with children"),
                    categories = fig5_27$year, tickformat = "$.2s", rotated = FALSE, directlabels = TRUE)

#Figure 5-26
fig5_26<- read.csv(paste(textpath, "Covering Expenses_savings/05_0260.csv", sep=""),stringsAsFactors=FALSE)
json5_26<- makeJson(sectionn = 5, graphn = 26, dt = fig5_26$Total.EFC, graphtype = "line",
                    series = "Total EFC", xlabel="Savings",
                    categories = fig5_26$Savings, tickformat = "$.2s", rotated = FALSE, directlabels = TRUE)
#Figure 5-25
#add "overrideTickCount": true to outermost bracket
#set x.ticks.count to 11
#add 4 blank data points (two at beginning and two at end) 
fig5_25<- read.csv(paste(textpath, "Covering Expenses_savings/05_0250.csv", sep=""),stringsAsFactors=FALSE)
json5_25<- makeJson(sectionn = 5, graphn = 25, dt = fig5_25$amount, graphtype = "line",
                    series = "Personal savings rate",
                    categories = fig5_25$year, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 5-24
fig5_24<- read.csv(paste(textpath, "Covering Expenses_time to degree/05_0240.csv", sep=""),stringsAsFactors=FALSE)
json5_24<- makeJson(sectionn = 5, graphn = 24, dt = fig5_24$foregone, graphtype = "bar",
                    series = "Forgone earnings",
                    categories = fig5_24$category, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)


#Figure 5-22
#1) for first graph, set max y value and ticks:
#
#```
#"y": {
#"padding": {"top":0 , "bottom":0},
#"max": 400000,
#"tick": {
#"format": "dollar",
#"count": 5
#}
#},
#```
#2) for second graph, set max y value and ticks:
#```
#"y": {
#"padding": {"top": 0, "bottom": 0},
#"max": 800000,
#"tick": {
#"format": "dollar",
#"count": 5
#}
#},
#```
#3) for both graphys, delete "groups" array

fig5_22a<- read.csv(paste(textpath, "Covering Expenses_time to degree/05_0221.csv", sep=""),stringsAsFactors=FALSE)
fig5_22b<- read.csv(paste(textpath, "Covering Expenses_time to degree/05_0222.csv", sep=""),stringsAsFactors=FALSE)
json5_13a <- makeJson(sectionn = 5, graphn = 13, subn= 1, dt = fig5_13a, graphtype = "bar",
                      series = c("Average per borrower", "Average per student"),
                      categories = fig5_13a$category,  xlabel = "All",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, ymax=10000, directlabels = TRUE)

json5_22a <- makeJson(sectionn = 5, graphn = 22, subn=1, dt = fig5_22a, graphtype = "bar", xlabel="Public four-year in-state", categories = fig5_22a$category, 
                       series=c("4 years", "5 years", "6 years"), graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels=TRUE)
json5_22b <- makeJson(sectionn = 5, graphn = 22, subn=2, dt = fig5_22b, graphtype = "bar", xlabel="Private Nonprofit four-year", categories = fig5_22b$category, 
                      series=c("4 years", "5 years", "6 years"), graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels=TRUE)
#Figure 5-23

fig5_23 <- read.csv(paste(textpath, "Covering expenses_time to degree/05_0230.csv", sep=""),stringsAsFactors=FALSE)
json5_23 <- makeJson(sectionn = 5, graphn = 23, dt = fig5_23, graphtype = "bar",
                     series = c("No debt", "Less than $10,000", "$10,000–$19,999", "$20,000–$29,999", "$30,000–$39,000", "$40,000 or More"),
                     categories = fig5_23$time_between_enroll_completion, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 5-21
#add ` "hideTooltip": true ` to outermost bracket
fig5_21 <- read.csv(paste(textpath, "Covering expenses_time to degree/05_0210.csv", sep=""),stringsAsFactors=FALSE)
json5_21 <- makeJson(sectionn = 5, graphn = 21, dt = fig5_21, graphtype = "bar",
                     series = c("2 years or less", "3 years", "4 to 5 years", "6 years or more"),
                     categories = fig5_21$Sector, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 5-20
#add ` "hideTooltip": true ` to outermost bracket
fig5_20 <- read.csv(paste(textpath, "Covering expenses_time to degree/05_0200.csv", sep=""),stringsAsFactors=FALSE)
json5_20 <- makeJson(sectionn = 5, graphn = 20, dt = fig5_20, graphtype = "bar",
                     series = c("4 years or less", "5 years", "6 to 7 years", "8 years or more"),
                     categories = fig5_20$Sector, tickformat = "percent", rotated = TRUE, directlabels = TRUE)



#Figure 5-17
#1) in the first graph, make x-label three lines by adding spaces in between "All full-time/ dependent/ students"
#2) in the second graph, make each x-label two lines, so  "Less than          ....." or "$30,000–            ........." for instance
#3) set max y-value and ticks

#"y": {
#  "padding": {"top": 0, "bottom": 0},
#  "tick": {
#    "count": 3,
#    "format": "dollar"
#  },
#  "max": 20000
#},
fig5_17a <- read.csv(paste(textpath, "Covering expenses_borrowing/05_0171.csv", sep=""),stringsAsFactors=FALSE)
fig5_17b <- read.csv(paste(textpath, "Covering expenses_borrowing/05_0172.csv", sep=""),stringsAsFactors=FALSE)
fig5_17b$category <- gsub("-", "–", fig5_17b$category) 
fig5_17c <- read.csv(paste(textpath, "Covering expenses_borrowing/05_0173.csv", sep=""),stringsAsFactors=FALSE)

json5_17a <- makeJson(sectionn = 5, graphn = 17, subn= 1, dt = fig5_17a$amount, graphtype = "bar",
                      series = "Loans borrowed",
                      categories = fig5_17a$category,  xlabel = "All full-time dependent students",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, ymax=17000, directlabels = TRUE)
json5_17b <- makeJson(sectionn = 5, graphn = 17, subn= 2, dt = fig5_17b$amount, graphtype = "bar",
                      series = "Loans borrowed",
                      categories = fig5_17b$category,  xlabel = "Family income",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, ymax=17000, directlabels = TRUE)
json5_17c <- makeJson(sectionn = 5, graphn = 17, subn= 3, dt = fig5_17c$amount, graphtype = "bar",
                      series = "Loans borrowed",
                      categories = fig5_17c$category,  xlabel = "Family income",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, ymax=17000, directlabels = TRUE)
#Figure 5-16
fig5_16<- read.csv(paste(textpath, "Covering expenses_borrowing/05_0160.csv", sep=""),stringsAsFactors=FALSE)
json5_16 <- makeJson(sectionn = 5, graphn = 16, dt = fig5_16$amount, graphtype = "bar", series="Loan amount",
                     categories = fig5_16$year, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 5-15
#First graph
fig5_151<- read.csv(paste(textpath, "Covering expenses_borrowing/05_0151.csv", sep=""),stringsAsFactors=FALSE)
json5_151 <- makeJson(sectionn = 5, graphn = 151, dt = fig5_15a$X..of.students.borrowing.federal.loans, graphtype = "bar", series="Percentage of students borrowing federal loans",
                     categories = fig5_15a$Degree, tickformat = "percent", rotated = FALSE, directlabels = TRUE)
#Second graph
fig5_152<- read.csv(paste(textpath, "Covering expenses_borrowing/05_0152.csv", sep=""),stringsAsFactors=FALSE)
json5_152 <- makeJson(sectionn = 5, graphn = 152, dt = fig5_15b$amount, graphtype = "bar", series="Average amount in federal loans",
                      categories = fig5_15b$Degree, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 5-14
#add "overrideTickCount": true to outermost bracket
fig5_14<- read.csv(paste(textpath, "Covering expenses_borrowing/05_0140.csv", sep=""),stringsAsFactors=FALSE)
json5_14 <- makeJson(sectionn = 5, graphn = 14, dt = fig5_14, graphtype = "line", series=c("$ Average per borrower", "$ Average per student"),
                    categories = fig5_14$Academic.Year, tickformat = "$.2s", rotated = FALSE, directlabels = TRUE)

#Figure 5-13
fig5_13a <- read.csv(paste(textpath, "Covering expenses_borrowing/05_0131.csv", sep=""),stringsAsFactors=FALSE)
fig5_13b <- read.csv(paste(textpath, "Covering expenses_borrowing/05_0132.csv", sep=""),stringsAsFactors=FALSE)
fig5_13c <- read.csv(paste(textpath, "Covering expenses_borrowing/05_0133.csv", sep=""),stringsAsFactors=FALSE)
fig5_13d <- read.csv(paste(textpath, "Covering expenses_borrowing/05_0134.csv", sep=""),stringsAsFactors=FALSE)

json5_13a <- makeJson(sectionn = 5, graphn = 13, subn= 1, dt = fig5_13a, graphtype = "bar",
                     series = c("Average per borrower", "Average per student"),
                     categories = fig5_13a$category,  xlabel = "All",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, ymax=10000, directlabels = TRUE)
json5_13b <- makeJson(sectionn = 5, graphn = 13, subn= 2, dt = fig5_13b, graphtype = "bar",
                      series = c("Average per borrower", "Average per student"),
                      categories = fig5_13b$category,  xlabel = "Dependency status",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, ymax=10000, directlabels = TRUE)
json5_13c <- makeJson(sectionn = 5, graphn = 13, subn= 3, dt = fig5_13c, graphtype = "bar",
                      series = c("Average per borrower", "Average per student"),
                      categories = fig5_13c$category,  xlabel = "Dependent Student's Parent Income",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, ymax=10000, directlabels = TRUE)
json5_13d <- makeJson(sectionn = 5, graphn = 13, subn= 4, dt = fig5_13d, graphtype = "bar",
                      series = c("Average per borrower", "Average per student"),
                      categories = fig5_13d$category,  xlabel = "Attendance pattern",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, ymax=10000, directlabels = TRUE)
#Figure 5-12
fig5_12 <- read.csv(paste(textpath, "Covering expenses_borrowing/05_0120.csv", sep=""),stringsAsFactors=FALSE)
json5_12 <- makeJson(sectionn = 5, graphn = 12, dt = fig5_12, graphtype = "bar", series=c("With debt", "Borrowed in 2011–2012"),
                    categories = fig5_12$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)


#Figure 5-11
# 1) add ` "hideTooltip": true ` to outermost bracket
# 2) set max y-value and ticks
#"y": {
#  "padding": {"top": 0, "bottom": 0},
#  "max": 0.5,
#  "tick": {
#    "format": "percent",
#    "count": 6
#  }
#},
fig5_11 <- read.csv(paste(textpath, "Covering expenses_working/05_0110.csv", sep=""),stringsAsFactors=FALSE)
fig5_11$category <- gsub("-", "–", fig5_11$category) 
json5_11 <- makeJson(sectionn = 5, graphn = 11, dt = fig5_11, graphtype = "bar", series=c("Total", "Public four-year", "Private nonprofit four-year", "Public two-year", "For-profit"), set1=fig5_11[,c("all")], set2=fig5_11[,c("publicfour")],
                     set3=fig5_11[,c("publictwo")], set4=fig5_11[,c("privatenonprofit")], set5=fig5_11[,c("forprofit")], categories = fig5_11$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 5-10
#add ` "hideTooltip": true ` to outermost bracket
fig5_10 <- read.csv(paste(textpath, "Covering expenses_working/05_0100.csv", sep=""),stringsAsFactors=FALSE)
json5_10 <- makeJson(sectionn = 5, graphn = 10, dt = fig5_10, graphtype = "bar",
                     series = c("No earnings", "$1–$2,999", "$3,000–$5,999", "$6,000–$8,999", "$9,000–$11,999", "$12,000–$14,999", "$15,000 or more"),
                     categories = fig5_10$hours, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 5-9
#add ` "hideTooltip": true ` to outermost bracket
fig5_9 <- read.csv(paste(textpath, "Covering expenses_working/05_0090.csv", sep=""),stringsAsFactors=FALSE)
json5_9 <- makeJson(sectionn = 5, graphn = 9, dt = fig5_9, graphtype = "bar",
                     series = c("No work", "1–5", "6–10", "11–15", "16–20", "21–30", "31–40", "41 or more"),
                     categories = fig5_9$hours, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 5-8
# add "highlightIndex" : 0  to outermost bracket
fig5_8<- read.csv(paste(textpath, "Covering expenses_working/05_0080.csv", sep=""),stringsAsFactors=FALSE)
json5_8 <- makeJson(sectionn = 5, graphn = 8, dt = fig5_8$minwage, graphtype = "bar", series="State minimum wage",
                    categories = fig5_8$state, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)

#Figure 5-7
fig5_7<- read.csv(paste(textpath, "Covering expenses_working/05_0070.csv", sep=""),stringsAsFactors=FALSE)
json5_7 <- makeJson(sectionn = 5, graphn = 7, dt = fig5_7$fed_min_wage, graphtype = "line", series="Federal minimum wage",
                    categories = fig5_7$year, tickformat = "$,.2f", rotated = FALSE, directlabels = TRUE)

#Figure 5-6
fig5_6<- read.csv(paste(textpath, "Covering expenses_working/05_0060.csv", sep=""),stringsAsFactors=FALSE)
json5_6 <- makeJson(sectionn = 5, graphn = 6, dt = fig5_6, graphtype = "line", series=c("Tuition and fees", "800 hours at minimum wage", "Tuition, fees, room, and board"),
                    categories = fig5_6$year, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
#Figure 5-5
fig5_5<- read.csv(paste(textpath, "Covering expenses_income/05_0050.csv", sep=""),stringsAsFactors=FALSE)
json5_5 <- makeJson(sectionn = 5, graphn = 5, dt = fig5_5$Median.Income, graphtype = "line", series="Median Income",
                    categories = fig5_5$X, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 5-4
fig5_4<- read.csv(paste(textpath, "Covering expenses_income/05_0040.csv", sep=""),stringsAsFactors=FALSE)
json5_4 <- makeJson(sectionn = 5, graphn = 4, dt = fig5_4, graphtype = "line", series=c("Ages 25 to 34", "Ages 35 to 44", "Ages 45 to 54", "Ages 55 to 64"),
                    categories = fig5_4$Year, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 5-3
# add   "highlightIndex" : 25  to outermost bracket
fig5_3<- read.csv(paste(textpath, "Covering expenses_income/05_0030.csv", sep=""),stringsAsFactors=FALSE)
json5_3 <- makeJson(sectionn = 5, graphn = 3, dt = fig5_3$median.income, graphtype = "bar", series="Median Income",
                    categories = fig5_3$State, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)

#Figure 5-2
fig5_2<- read.csv(paste(textpath, "Covering expenses_income/05_0020.csv", sep=""),stringsAsFactors=FALSE)
json5_2 <- makeJson(sectionn = 5, graphn = 2, dt = fig5_2$Median.Income, graphtype = "bar", series="Median Income",
                    categories = fig5_2$Ed.level, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)

#Figure 5-1
#1) in first graph, add bracket for x.categories since single category "All families"
#2) set max y value and ticks
#"y": {
#"padding": {"top": 0, "bottom": 0},
#"max": 120000,
#"tick": {
#"count": 4,
#"format": "dollar"
#}
#},
#3) For x-axis labels, add space between year range and "years", so that they are on two lines, 
#for example: "25-34           years"

fig5_1a <- read.csv(paste(textpath, "Covering expenses_income/05_0011.csv", sep=""),stringsAsFactors=FALSE)
fig5_1b <- read.csv(paste(textpath, "Covering expenses_income/05_0012.csv", sep=""),stringsAsFactors=FALSE)
fig5_1c <- read.csv(paste(textpath, "Covering expenses_income/05_0013.csv", sep=""),stringsAsFactors=FALSE)
fig5_1d <- read.csv(paste(textpath, "Covering expenses_income/05_0014.csv", sep=""),stringsAsFactors=FALSE)
fig5_1d$category <- gsub(" to ", "–", fig5_1d$category) 

json5_1a <- makeJson(sectionn = 5, graphn = 1, subn= 1, dt = fig5_1a$income, graphtype = "bar",
                      series = "Income",
                      categories = fig5_1a$category,  xlabel = "All",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, ymax=100000, directlabels = TRUE)
json5_1b <- makeJson(sectionn = 5, graphn = 1, subn= 2, dt = fig5_1b$income, graphtype = "bar",
                      series = "Income",
                      categories = fig5_1b$category,  xlabel = "Race",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, ymax=100000, directlabels = TRUE)
json5_1c <- makeJson(sectionn = 5, graphn = 1, subn= 3, dt = fig5_1c$income, graphtype = "bar",
                      series = "Income",
                      categories = fig5_1c$category,  xlabel = "Geographical region",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, ymax=100000, directlabels = TRUE)
json5_1d <- makeJson(sectionn = 5, graphn = 1, subn= 4, dt = fig5_1d$income, graphtype = "bar",
                      series = "Income",
                      categories = fig5_1d$category,  xlabel = "Age",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, ymax=100000, directlabels = TRUE)

