
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
                     series = c("Bottom decile", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "Top decile"),
                     categories = fig3_3a$Sector, graphtitle=NULL, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json4_7b <- makeJson(sectionn = 4, graphn = 7, subn=2, dt = fig4_7b, graphtype = "bar",
                     series = c("Federal Grants", "Veterans' and Military", "State Grants", "Institutional Grants", "Employer or Private Grants"),
                     categories = fig4_7b$column, graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)


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
fig3_10 <- read.csv(paste(textpath, "Prices and expenses_room and board/03_0100.csv", sep=""),stringsAsFactors=FALSE)
json3_10 <- makeJson(sectionn = 3, graphn = 10, dt = fig3_10, graphtype = "bar", series=c("Room and board", "Tuition and fees"), set1=fig3_10[,c("pell_per_student")], set2=fig4_9[,c("grant_per_recip")],
                    categories = fig4_9$dependency_income, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)


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
                     categories = fig3_14$X, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 3-14
fig3_14 <- read.csv(paste(textpath, "Prices and expenses_student budgets/03_0140.csv", sep=""),stringsAsFactors=FALSE)
fig3_14$X <- gsub("-", "–", fig3_14$X) 
json3_14 <- makeJson(sectionn = 3, graphn = 14, dt = fig3_14, graphtype = "line", series="Annual Spending",
                     categories = fig3_14$X, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
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
fig4_9 <- read.csv(paste(textpath, "Financial aid_federal/04_0090.csv", sep=""),stringsAsFactors=FALSE)
json4_9 <- makeJson(sectionn = 4, graphn = 9, dt = fig4_9, graphtype = "bar", series=c("Pell Grant per full-time student", "Pell Grant per full-time recipient"), set1=fig4_9[,c("pell_per_student")], set2=fig4_9[,c("grant_per_recip")],
                    categories = fig4_9$dependency_income, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)


#Figure 3-20
fig3_20 <- read.csv(paste(textpath, "Financial aid_federal/04_0090.csv", sep=""),stringsAsFactors=FALSE)
json4_9 <- makeJson(sectionn = 4, graphn = 9, dt = fig4_9, graphtype = "bar", series=c("Pell Grant per full-time student", "Pell Grant per full-time recipient"), set1=fig4_9[,c("pell_per_student")], set2=fig4_9[,c("grant_per_recip")],
                    categories = fig4_9$dependency_income, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)