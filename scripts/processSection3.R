
library(dplyr)
library(tidyr)
library(jsonlite)
library(openxlsx)


source('~/Documents/ed-data/scripts/createJsons.R')

# Path to Excel file with graph metadata - change to your file path

textpath <- "/Users/vhou/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) Project/**Production/"

graphtext <- readWorkbook(paste(textpath, "GraphText.xlsx", sep=""),sheet = 1)
graphtext$section_number <- as.numeric(graphtext$section_number)
graphtext$multiples <- as.numeric(graphtext$multiples)
graphtext$toggle <- as.numeric(graphtext$toggle)

graphtext <- readWorkbook(paste(textpath,"GraphText.xlsx", sep=""), sheet = 1)
graphtext$section_number <- as.numeric(graphtext$section_number)
graphtext$multiples <- as.numeric(graphtext$multiples)
graphtext$toggle <- as.numeric(graphtext$toggle)
fig3_17 <- read.csv(paste(textpath, "Prices and expenses_forgone earnings/03_0170.csv", sep=""),stringsAsFactors=FALSE)
fig3_17 <- as.data.frame(fig3_17)

#Figure 3-1
fig3_1 <- read.csv(paste(textpath, "Prices and expenses_tuition and fees/03_0010.csv", sep=""),stringsAsFactors=FALSE)
json3_1 <- makeJson(sectionn = 3, graphn = 1, dt = fig3_1, graphtype = "bar",
                    series = c("In-district or in-state tuition", "Additional tuition charged to out-of-state students"),
                    categories = fig3_1$category, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 3-2
fig3_2 <- read.csv(paste(textpath, "Prices and expenses_tuition and fees/03_0020-revised.csv", sep=""),stringsAsFactors=FALSE)
json3_2 <- makeJson(sectionn = 3, graphn = 2, dt = fig3_2, graphtype = "line",
                    series = c("for profit", "private nonprofit four-year", "public four-year", "public two-year"),
                    categories = fig3_2$year, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 3-3

fig3_3a <- read.csv(paste(textpath, "Prices and expenses_tuition and fees/03_0031.csv", sep=""),stringsAsFactors=FALSE)
fig3_3b <- read.csv(paste(textpath, "Prices and expenses_tuition and fees/03_0032.csv", sep=""),stringsAsFactors=FALSE)
fig3_3c <- read.csv(paste(textpath, "Prices and expenses_tuition and fees/03_0033.csv", sep=""),stringsAsFactors=FALSE)
fig3_3d <- read.csv(paste(textpath, "Prices and expenses_tuition and fees/03_0034.csv", sep=""),stringsAsFactors=FALSE)


json3_3a <- makeJson(sectionn = 3, graphn = 3, subn= 1, dt = fig3_3a, graphtype = "bar",
                     series = c("Lowest decile", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "Highest decile"),
                     categories = fig3_3a$category, graphtitle="Public two-year", tickformat = "dollar", rotated = FALSE, directlabels = FALSE)
json3_3b <- makeJson(sectionn = 3, graphn = 3, subn= 2, dt = fig3_3b, graphtype = "bar",
                     series = c("Lowest decile", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "Highest decile"),
                     categories = fig3_3b$category, graphtitle="Public four-year", tickformat = "dollar", rotated = FALSE, directlabels = FALSE)
json3_3c <- makeJson(sectionn = 3, graphn = 3, subn= 3, dt = fig3_3c, graphtype = "bar",
                     series = c("Lowest decile", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "Highest decile"),
                     categories = fig3_3c$category, graphtitle="Private non-profit four-year", tickformat = "dollar", rotated = FALSE, directlabels = FALSE)
json3_3d <- makeJson(sectionn = 3, graphn = 3, subn= 4, dt = fig3_3d, graphtype = "bar",
                     series = c("Lowest decile", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "Highest decile"),
                     categories = fig3_3d$category, graphtitle="For-profit", tickformat = "dollar", rotated = FALSE, directlabels = FALSE)
#Figure 3-4
fig3_4a <- read.csv(paste(textpath, "Prices and expenses_tuition and fees/03_0040.csv", sep=""),stringsAsFactors=FALSE)
fig3_4b <- read.csv(paste(textpath, "Prices and expenses_tuition and fees/03_0041.csv", sep=""),stringsAsFactors=FALSE)

json3_4a <- makeJson(sectionn = 3, graphn = 4, subn= 1, dt = fig3_4a$amount, graphtype = "bar",
                     series = FALSE,
                     categories = fig3_4a$state, graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)
json3_4b <- makeJson(sectionn = 3, graphn = 4, subn= 2, dt = fig3_4b$amount, graphtype = "bar",
                     series = FALSE,
                     categories = fig3_4b$state, graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)

#Figure 3-5
fig3_5 <- read.csv(paste(textpath, "Prices and expenses_room and board/03_0050.csv", sep=""),stringsAsFactors=FALSE)
json3_5 <- makeJson(sectionn = 3, graphn = 5, dt = fig3_5, graphtype = "bar",
                     series = c("On campus", "Off campus", "Living with parents"),
                     categories = fig3_5$Sector, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 3-6
fig3_6 <- read.csv(paste(textpath, "Prices and expenses_room and board/03_0060.csv", sep=""),stringsAsFactors=FALSE)
json3_6 <- makeJson(sectionn = 3, graphn = 6, dt = fig3_6$amount, graphtype = "bar", series="Price",
                    categories = fig3_6$category, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 3-7
fig3_7 <- read.csv(paste(textpath, "Prices and expenses_room and board/03_0070.csv", sep=""),stringsAsFactors=FALSE)
json3_7 <- makeJson(sectionn = 3, graphn = 7, dt = fig3_7$roomamt, graphtype = "bar", series=FALSE,
                    categories = fig3_7$state, tickformat = "number", rotated = TRUE, directlabels = TRUE)





#Figure 3-9
fig3_9 <- read.csv(paste(textpath, "Prices and expenses_room and board/03_0090.csv", sep=""),stringsAsFactors=FALSE)
json3_9 <- makeJson(sectionn = 3, graphn = 9, dt = fig3_9, graphtype = "line", series=c("Private nonprofit four-year", "Public four-year"),
                    categories = fig3_9$year, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 3-10
#graph 1
fig3_10 <- read.csv(paste(textpath, "Prices and expenses_room and board/03_0100.csv", sep=""),stringsAsFactors=FALSE)
json3_10 <- makeJson(sectionn = 3, graphn = 10, subn=0, dt = fig3_10, graphtype = "bar", series=c("Room and board", "Tuition and fees"),
                categories = fig3_10$category, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)
#graph2  
fig3_101<- read.csv(paste(textpath, "Prices and expenses_room and board/03_0101.csv", sep=""),stringsAsFactors=FALSE)
json3_101 <- makeJson(sectionn = 3, graphn = 10, subn=1, dt = fig3_101, graphtype = "bar", series=c("Room and board", "Tuition and fees"),
                            categories = fig3_10$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 3-11
fig3_11 <- read.csv(paste(textpath, "Prices and expenses_student budgets/03_0110.csv", sep=""),stringsAsFactors=FALSE)
json3_11 <- makeJson(sectionn = 3, graphn = 11, dt = fig3_11, graphtype = "bar", series=c("Lowest quintile", "2nd", "3rd", "4th", "Highest quintile"),
                     categories = fig3_11$category, tickformat = "dollar", rotated = FALSE, directlabels = FALSE)

#Figure 3-12
fig3_12a <- read.csv(paste(textpath, "Prices and expenses_student budgets/03_0120.csv", sep=""),stringsAsFactors=FALSE)
fig3_12b <- read.csv(paste(textpath, "Prices and expenses_student budgets/03_0121.csv", sep=""),stringsAsFactors=FALSE)
fig3_12c <- read.csv(paste(textpath, "Prices and expenses_student budgets/03_0122.csv", sep=""),stringsAsFactors=FALSE)
fig3_12d <- read.csv(paste(textpath, "Prices and expenses_student budgets/03_0123.csv", sep=""),stringsAsFactors=FALSE)
fig3_12d$year <- gsub("-", "–", fig3_12d$year) 


json3_12a <- makeJson(sectionn = 3, graphn = 12, subn= 1, dt = fig3_12a, graphtype = "bar",
                     series = c("Tuition and fees", "Room and board", "Books and supplies", "Transportation", "Other"),
                     categories = fig3_12a$year, graphtitle="Public two-year, living off campus", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_12b <- makeJson(sectionn = 3, graphn = 12, subn= 2, dt = fig3_12b, graphtype = "bar",
                      series = c("Tuition and fees", "Room and board", "Books and supplies", "Transportation", "Other"),
                      categories = fig3_12b$year, graphtitle="Public four-year in state, living on campus", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_12c <- makeJson(sectionn = 3, graphn = 12, subn= 3, dt = fig3_12c, graphtype = "bar",
                      series = c("Tuition and fees", "Room and board", "Books and supplies", "Transportation", "Other"),
                      categories = fig3_12c$year, graphtitle="Private nonprofit four-year, living on campus", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_12d <- makeJson(sectionn = 3, graphn = 12, subn= 4, dt = fig3_12d, graphtype = "bar",
                      series = c("Tuition and fees", "Room and board", "Books and supplies", "Transportation", "Other"),
                      categories = fig3_12d$year, graphtitle="For profit, living off campus", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 3-13
fig3_13 <- read.csv(paste(textpath, "Prices and expenses_student budgets/03_0130.csv", sep=""),stringsAsFactors=FALSE)
json3_13 <- makeJson(sectionn = 3, graphn = 13, dt = fig3_13, graphtype = "bar", series=c("2001", "2016"),
                     categories = fig3_14$X, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 3-14
fig3_14 <- read.csv(paste(textpath, "Prices and expenses_student budgets/03_0140.csv", sep=""),stringsAsFactors=FALSE)
fig3_14$X <- gsub("-", "–", fig3_14$X) 
json3_14 <- makeJson(sectionn = 3, graphn = 14, dt = fig3_14$course.material.spending, graphtype = "line", series="Annual Spending",
                     categories = fig3_14$X, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
#need to add: "line": {"connectNull": true}  in JSON


#Figure 3-15
fig3_15 <- read.csv(paste(textpath, "Prices and expenses_student budgets/03_0150.csv", sep=""),stringsAsFactors=FALSE)
fig3_15$X <- gsub("-", "–", fig3_15$X) 
json3_15 <- makeJson(sectionn = 3, graphn = 15, dt = fig3_15, graphtype = "line", series=c("New", "Used"),
                     categories = fig3_15$X, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 3-16
fig3_16 <- read.csv(paste(textpath, "Prices and expenses_student budgets/03_0160.csv", sep=""),stringsAsFactors=FALSE)
json3_16 <- makeJson(sectionn = 3, graphn = 16, dt = fig3_16, graphtype = "line", series=c("Public two-year", "Public four-year", "Private nonprofit", "For profit"),
                     categories = fig3_16$X, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 3-17
fig3_17 <- read.csv(paste(textpath, "Prices and expenses_forgone earnings/03_0170.csv", sep=""),stringsAsFactors=FALSE)
json3_17 <- makeJson(sectionn = 3, graphn = 17, dt = fig3_17, graphtype = "bar",
                     series = c("Did not work last year", "Part year or part time", "Full year full time"),
                     categories = fig3_17$age, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 3-18
fig3_18a <- read.csv(paste(textpath, "Prices and expenses_forgone earnings/03_01801.csv", sep=""),stringsAsFactors=FALSE)
fig3_18a$age <- gsub("-", "–", fig3_18a$age) 
fig3_18b <- read.csv(paste(textpath, "Prices and expenses_forgone earnings/03_01802.csv", sep=""),stringsAsFactors=FALSE)
fig3_18b$age <- gsub("-", "–", fig3_18b$age) 
fig3_18c <- read.csv(paste(textpath, "Prices and expenses_forgone earnings/03_01803.csv", sep=""),stringsAsFactors=FALSE)
fig3_18d <- read.csv(paste(textpath, "Prices and expenses_forgone earnings/03_01804.csv", sep=""),stringsAsFactors=FALSE)
fig3_18e <- read.csv(paste(textpath, "Prices and expenses_forgone earnings/03_01805.csv", sep=""),stringsAsFactors=FALSE)
fig3_18f <- read.csv(paste(textpath, "Prices and expenses_forgone earnings/03_01806.csv", sep=""),stringsAsFactors=FALSE)

#First set
json3_18a <- makeJson(sectionn = 3, graphn = 18, subn= 1, dt = fig3_18a, graphtype = "bar",
                      series = c("25th percentile", "75th percentile", "Median"),
                      categories = fig3_18a$age, graphtitle="Median earnings of men by age", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_18b <- makeJson(sectionn = 3, graphn = 18, subn= 2, dt = fig3_18b, graphtype = "bar",
                      series = c("25th percentile", "75th percentile", "Median"),
                      categories = fig3_18b$age, graphtitle="Median earnings of women by age", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
#Second set
json3_18c <- makeJson(sectionn = 3, graphn = 18, subn= 11, dt = fig3_18c, graphtype = "bar",
                      series = c("25th percentile", "75th percentile", "Median"),
                      categories = fig3_18c$race, graphtitle="Median earnings of men by race", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_18d <- makeJson(sectionn = 3, graphn = 18, subn= 12, dt = fig3_18d, graphtype = "bar",
                      series = c("25th percentile", "75th percentile", "Median"),
                      categories = fig3_18d$race, graphtitle="Median earnings of women by race", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
#Third set
json3_18e <- makeJson(sectionn = 3, graphn = 18, subn= 21, dt = fig3_18e, graphtype = "bar",
                      series = c("25th percentile", "75th percentile", "Median"),
                      categories = fig3_18e$race, graphtitle="Median earnings of men by race", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_18f <- makeJson(sectionn = 3, graphn = 18, subn= 22, dt = fig3_18f, graphtype = "bar",
                      series = c("25th percentile", "75th percentile", "Median"),
                      categories = fig3_18f$race, graphtitle="Median earnings of women by race", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 3-19

#Made hand corrections to x axis ticks. For normal line charts handled in the college-affordability.urban.org repo at:
#`college-affordability.urban.org/components/30-components/graphs/graph/graph.jsx`
#in various blocks specific to line and area charts. Given that this chart is a single edge case (toggle
#line chart), made corrections by hand, namely:
#- set `x.tick.count: 14`
#- added empty tick `""` to start and end of x.categories array
#- added empty tick `null` to start and end of each data series array in `data.sets`

# fig3_19 <- read.csv(paste(textpath, "Prices and expenses_forgone earnings/03_0190.csv", sep=""),stringsAsFactors=FALSE)
# json3_19 <- makeJson(sectionn = 3, graphn = 19, dt = fig3_19, graphtype = "line", series=c("Ages 18-23", "Ages 24-34"), set1=fig3_19[,c("median.income_18", "p25.income_18", "p75.income_18")], set2=fig3_19[,c("incwage_24", "p25incwage_24", "p75incwage_24", "incwage_24")],
#                      categories = fig3_19$year, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)


#MEN
#fig3_19 <- read.csv(paste(textpath, "Prices and expenses_forgone earnings/03_0190.csv", sep=""),stringsAsFactors=FALSE)
#json3_19 <- makeJson(sectionn = 3, graphn = 19, dt = fig3_19, graphtype = "line", series=c("Ages 18-23", "Ages 24-34"), set1=fig3_19[,c("median.income_18", "p25.income_18", "p75.income_18")], set2=fig3_19[,c("incwage_24", "p25incwage_24", "p75incwage_24", "incwage_24")],
#                     categories = fig3_19$year, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#WOMEN
#fig3_19b <- read.csv(paste(textpath, "Prices and expenses_forgone earnings/03_0191.csv", sep=""),stringsAsFactors=FALSE)
#json3_19b <- makeJson(sectionn = 3, graphn = 19, subn=1, dt = fig3_19b, graphtype = "line", series=c("Ages 18-23", "Ages 24-34"), set1=fig3_19b[,c("median.income_18", "p25.income_18", "p75.income_18")], set2=fig3_19b[,c("median_24", "p25.income_24", "p75.income_24")],
#                      categories = fig3_19b$year, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)


#Figure 3-20
fig3_20a <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_0200.csv", sep=""),stringsAsFactors=FALSE)
fig3_20b <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_0201.csv", sep=""),stringsAsFactors=FALSE)

json3_20a <- makeJson(sectionn = 3, graphn = 20, subn= 1, dt = fig3_20a, graphtype = "bar",
                      series = c("Grant Aid", "Tuition and fees left over"),
                      categories = fig3_20a$category, graphtitle="Dollars", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_20b <- makeJson(sectionn = 3, graphn = 20, subn= 2, dt = fig3_20b, graphtype = "bar", 
                      series = c("Grant Aid", "Tuition and fees left over"),
                      categories = fig3_20b$category, graphtitle="Percent", tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 3-21
#First set of multiples- need to add "groups": [["Tuition and fees covered by grant aid","Remaining (net) tuition and fees","Living expenses covered by grant aid", "Remaining (net) living expenses"]]
fig3_21a <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02101.csv", sep=""),stringsAsFactors=FALSE)
fig3_21b <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02102.csv", sep=""),stringsAsFactors=FALSE)
fig3_21c <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02103.csv", sep=""),stringsAsFactors=FALSE)
fig3_21d <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02104.csv", sep=""),stringsAsFactors=FALSE)

json3_21a <- makeJson(sectionn = 3, graphn = 21, subn= 1, dt = fig3_21a, graphtype = "bar",
                      series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                      categories = fig3_21a$Income, graphtitle="Public four-year", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_21b <- makeJson(sectionn = 3, graphn = 21, subn= 2, dt = fig3_21b, graphtype = "bar", 
                      series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                      categories = fig3_21b$Income, graphtitle="Private nonprofit four-year", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_21c <- makeJson(sectionn = 3, graphn = 21, subn= 3, dt = fig3_21c, graphtype = "bar", 
                      series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                      categories = fig3_21c$Income, graphtitle="Public two-year", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_21d <- makeJson(sectionn = 3, graphn = 21, subn= 4, dt = fig3_21d, graphtype = "bar", 
                      series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                      categories = fig3_21d$Income, graphtitle="For-profit", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Second set of multiples- need to add "groups": [["Grant aid","Remaining (net) tuition and fees","Remaining (net) living expenses"]]
fig3_211a <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02111.csv", sep=""),stringsAsFactors=FALSE)
fig3_211b <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02112.csv", sep=""),stringsAsFactors=FALSE)
fig3_211c <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02113.csv", sep=""),stringsAsFactors=FALSE)
fig3_211d <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02114.csv", sep=""),stringsAsFactors=FALSE)

json3_211a <- makeJson(sectionn = 3, graphn = 21, subn= 11, dt = fig3_211a, graphtype = "bar",
                      series = c("Grant aid", "Remaining (net) tuition and fees", "Remaining (net) living expenses"),
                      categories = fig3_211a$Income, graphtitle="Public four-year", tickformat = "percent", rotated = FALSE, directlabels = TRUE)
json3_211b <- makeJson(sectionn = 3, graphn = 21, subn= 12, dt = fig3_211b, graphtype = "bar",
                       series = c("Grant aid", "Remaining (net) tuition and fees", "Remaining (net) living expenses"),
                       categories = fig3_211b$Income, graphtitle="Private nonprofit four-year", tickformat = "percent", rotated = FALSE, directlabels = TRUE)
json3_211c <- makeJson(sectionn = 3, graphn = 21, subn= 13, dt = fig3_211c, graphtype = "bar",
                       series = c("Grant aid", "Remaining (net) tuition and fees", "Remaining (net) living expenses"),
                       categories = fig3_211c$Income, graphtitle="Public two-year", tickformat = "percent", rotated = FALSE, directlabels = TRUE)
json3_211d <- makeJson(sectionn = 3, graphn = 21, subn= 14, dt = fig3_211d, graphtype = "bar", 
                      series = c("Grant aid", "Remaining (net) tuition and fees", "Remaining (net) living expenses"), 
                      categories = fig3_211d$Income, graphtitle="For-profit", tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 3-21
#First set of multiples- need to add "groups": [["Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"]]
fig3_22a <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02201.csv", sep=""),stringsAsFactors=FALSE)
fig3_22b <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02202.csv", sep=""),stringsAsFactors=FALSE)
fig3_22c <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02203.csv", sep=""),stringsAsFactors=FALSE)
fig3_22d <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02204.csv", sep=""),stringsAsFactors=FALSE)
fig3_22e <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02205.csv", sep=""),stringsAsFactors=FALSE)

json3_22a <- makeJson(sectionn = 3, graphn = 22, subn= 1, dt = fig3_22a, graphtype = "bar",
                      series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                      categories = fig3_22a$Year, graphtitle="Lowest 25 percent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_22b <- makeJson(sectionn = 3, graphn = 22, subn= 2, dt = fig3_22b, graphtype = "bar", 
                      series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                      categories = fig3_22b$Year, graphtitle="Lower Middle 25 percent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_22c <- makeJson(sectionn = 3, graphn = 22, subn= 3, dt = fig3_22c, graphtype = "bar", 
                      series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                      categories = fig3_22c$Year, graphtitle="Upper Middle 25 percent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_22d <- makeJson(sectionn = 3, graphn = 22, subn= 4, dt = fig3_22d, graphtype = "bar", 
                      series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                      categories = fig3_22d$Year, graphtitle="Highest 25 percent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_22e <- makeJson(sectionn = 3, graphn = 22, subn= 5, dt = fig3_22e, graphtype = "bar", 
                      series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                      categories = fig3_22e$Year, graphtitle="Independent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Second set of multiples- need to add "groups": [["Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"]]
fig3_221a <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02211.csv", sep=""),stringsAsFactors=FALSE)
fig3_221b <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02212.csv", sep=""),stringsAsFactors=FALSE)
fig3_221c <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02213.csv", sep=""),stringsAsFactors=FALSE)
fig3_221d <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02214.csv", sep=""),stringsAsFactors=FALSE)
fig3_221e <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02215.csv", sep=""),stringsAsFactors=FALSE)

json3_221a <- makeJson(sectionn = 3, graphn = 22, subn= 11, dt = fig3_221a, graphtype = "bar",
                      series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                      categories = fig3_221a$Year, graphtitle="Lowest 25 percent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_221b <- makeJson(sectionn = 3, graphn = 22, subn= 12, dt = fig3_221b, graphtype = "bar", 
                      series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                      categories = fig3_221b$Year, graphtitle="Lower Middle 25 percent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_221c <- makeJson(sectionn = 3, graphn = 22, subn= 13, dt = fig3_221c, graphtype = "bar", 
                      series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                      categories = fig3_221c$Year, graphtitle="Upper Middle 25 percent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_221d <- makeJson(sectionn = 3, graphn = 22, subn= 14, dt = fig3_221d, graphtype = "bar", 
                      series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                      categories = fig3_221d$Year, graphtitle="Highest 25 percent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_221e <- makeJson(sectionn = 3, graphn = 22, subn= 15, dt = fig3_221e, graphtype = "bar", 
                      series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                      categories = fig3_221e$Year, graphtitle="Independent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Third set of multiples- need to add "groups": [["Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"]]
fig3_222a <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02221.csv", sep=""),stringsAsFactors=FALSE)
fig3_222b <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02222.csv", sep=""),stringsAsFactors=FALSE)
fig3_222c <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02223.csv", sep=""),stringsAsFactors=FALSE)
fig3_222d <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02224.csv", sep=""),stringsAsFactors=FALSE)
fig3_222e <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02225.csv", sep=""),stringsAsFactors=FALSE)

json3_222a <- makeJson(sectionn = 3, graphn = 22, subn= 21, dt = fig3_222a, graphtype = "bar",
                       series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                       categories = fig3_222a$Year, graphtitle="Lowest 25 percent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_222b <- makeJson(sectionn = 3, graphn = 22, subn= 22, dt = fig3_222b, graphtype = "bar", 
                       series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                       categories = fig3_222b$Year, graphtitle="Lower Middle 25 percent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_222c <- makeJson(sectionn = 3, graphn = 22, subn= 23, dt = fig3_222c, graphtype = "bar", 
                       series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                       categories = fig3_222c$Year, graphtitle="Upper Middle 25 percent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_222d <- makeJson(sectionn = 3, graphn = 22, subn= 24, dt = fig3_222d, graphtype = "bar", 
                       series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                       categories = fig3_222d$Year, graphtitle="Highest 25 percent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_222e <- makeJson(sectionn = 3, graphn = 22, subn= 25, dt = fig3_222e, graphtype = "bar", 
                       series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                       categories = fig3_222e$Year, graphtitle="Independent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Fourth set of multiples- need to add "groups": [["Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"]]
fig3_223a <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02231.csv", sep=""),stringsAsFactors=FALSE)
fig3_223b <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02232.csv", sep=""),stringsAsFactors=FALSE)
fig3_223c <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02233.csv", sep=""),stringsAsFactors=FALSE)
fig3_223d <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02234.csv", sep=""),stringsAsFactors=FALSE)
fig3_223e <- read.csv(paste(textpath, "Prices and expenses_net price/correct csvs/03_02235.csv", sep=""),stringsAsFactors=FALSE)

json3_223a <- makeJson(sectionn = 3, graphn = 22, subn= 31, dt = fig3_223a, graphtype = "bar",
                       series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                       categories = fig3_223a$Year, graphtitle="Lowest 25 percent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_223b <- makeJson(sectionn = 3, graphn = 22, subn= 32, dt = fig3_223b, graphtype = "bar", 
                       series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                       categories = fig3_223b$Year, graphtitle="Lower Middle 25 percent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_223c <- makeJson(sectionn = 3, graphn = 22, subn= 33, dt = fig3_223c, graphtype = "bar", 
                       series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                       categories = fig3_223c$Year, graphtitle="Upper Middle 25 percent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_223d <- makeJson(sectionn = 3, graphn = 22, subn= 34, dt = fig3_223d, graphtype = "bar", 
                       series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                       categories = fig3_223d$Year, graphtitle="Highest 25 percent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json3_223e <- makeJson(sectionn = 3, graphn = 22, subn= 35, dt = fig3_223e, graphtype = "bar", 
                       series = c("Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"),
                       categories = fig3_223e$Year, graphtitle="Independent", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
