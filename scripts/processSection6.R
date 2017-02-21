
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

#Figure 6-100
fig6_100<- read.csv(paste(textpath, "After College_landing page/06_0100.csv", sep=""),stringsAsFactors=FALSE)
json6_100<- makeJson(sectionn = 6, graphn = 100, dt = fig6_100, graphtype = "bar", series=c("4 years", "5 years", "6 years"),
                    categories = fig6_100$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 6-200
fig6_200 <- read.csv(paste(textpath, "After college_landing page/06_0200-ALL.csv", sep=""),stringsAsFactors=FALSE, check.names=FALSE)
json6_200<- makeJson(sectionn = 6, graphn = 200, dt = fig6_200, graphtype = "bar", set1= fig6_200[grep("part", fig6_200$category), c("Completed Bachelor's degree at four-year college", "Completed degree at two-year college", "Still enrolled", "Not enrolled")], 
                     set2= fig6_200[grep("full", fig6_200$category),c("Completed bachelor's degree at four-year college", "Completed degree at two-year college", "Still enrolled", "Not enrolled")], 
                     series = c("Mixed", "Full-time"),
                    categories = fig6_200$category_labels, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 6-1
fig6_1<- read.csv(paste(textpath, "After College_employment/06_0010.csv", sep=""),stringsAsFactors=FALSE)
json6_1 <- makeJson(sectionn = 6, graphn = 1, dt = fig6_1, graphtype = "line", series=c("High school or equivalent", "Some college, no degree", "Associate degree", "Bachelor's degree", "Advanced degree"),
                    categories = fig6_1$year, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 6-2
fig6_2<- read.csv(paste(textpath, "After College_employment/06_0020.csv", sep=""),stringsAsFactors=FALSE)
json6_2 <- makeJson(sectionn = 6, graphn = 2, dt = fig6_2, graphtype = "line", series=c("High school or equivalent", "Some college, no degree", "Associate degree", "Bachelor's degree", "Advanced degree"),
                    categories = fig6_2$year, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 6-3

fig6_3 <- read.csv(paste(textpath, "After college_employment/06_0030.csv", sep=""),stringsAsFactors=FALSE)
json6_3 <- makeJson(sectionn = 6, graphn = 3, dt = fig6_3, graphtype = "bar",
                     series = c("No work last year", "Part year or part time", "Full year full time"),
                     categories = fig6_3$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 6-4
fig6_4<- read.csv(paste(textpath, "After College_earnings/06_0040-revised.csv", sep=""),stringsAsFactors=FALSE)
json6_4 <- makeJson(sectionn = 6, graphn = 4, dt = fig6_4, graphtype = "line", series=c("High school or equivalent", "Some college, no degree", "Associate degree", "Bachelor's degree", "Advanced degree"),
                    categories = fig6_4$year, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 6-5
fig6_5<- read.csv(paste(textpath, "After College_earnings/06_0050.csv", sep=""),stringsAsFactors=FALSE)
fig6_5$age <- gsub("-", "–", fig6_5$age) 
json6_5 <- makeJson(sectionn = 6, graphn = 5, dt = fig6_5, graphtype = "line", series=c("High school or equivalent", "Some college, no degree", "Associate degree", "Bachelor's degree", "Advanced degree"),
                    categories = fig6_5$age, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 6-6
fig6_6 <- read.csv(paste(textpath, "After college_earnings/06_0060.csv", sep=""),stringsAsFactors=FALSE)
json6_6 <- makeJson(sectionn = 6, graphn = 6, dt = fig6_6, graphtype = "bar",
                    series = c("$0-$20,999",	"$21,000-$35,399",	"$35,400-$51,999",	"$52,000-$79.999",	"$80,000+"),
                    categories = fig6_6$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 6-15
fig6_15 <- read.csv(paste(textpath, "After college_debt/06_0150.csv", sep=""),stringsAsFactors=FALSE)
figjson6_15 <- makeJson(sectionn = 6, graphn = 15, dt = fig6_15, graphtype = "bar",
                     series = c("No debt", "Less than $10,000", "$10,000–$19,999", "$20,000–$29,999", "$30,000–$39,000", "$40,000 or more"),
                     categories = fig6_15$race, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 6-14
fig6_14 <- read.csv(paste(textpath, "After college_debt/06_0140.csv", sep=""),stringsAsFactors=FALSE)
fig6_14$column <- gsub("-", "–", fig6_14$column) 
json6_14 <- makeJson(sectionn = 6, graphn = 14, dt = fig6_14, graphtype = "bar",
                     series = c("No debt", "Less than $10,000", "$10,000–$19,999", "$20,000–$29,999", "$30,000–$39,000", "$40,000 or more"),
                     categories = fig6_14$column, tickformat = "percent", rotated = TRUE, directlabels = TRUE)


#Figure 6-13
fig6_13 <- read.csv(paste(textpath, "After college_debt/06_0130.csv", sep=""),stringsAsFactors=FALSE)
json6_13 <- makeJson(sectionn = 6, graphn = 13, dt = fig6_13, graphtype = "bar",
                     series = c("No debt", "Less than $10,000", "$10,000–$19,999", "$20,000–$29,999", "$30,000–$39,000", "$40,000 or more"),
                     categories = fig6_13$dependency, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 6-12
fig6_12 <- read.csv(paste(textpath, "After college_debt/06_0120.csv", sep=""),stringsAsFactors=FALSE)
json6_12 <- makeJson(sectionn = 6, graphn = 12, dt = fig6_12, graphtype = "bar",
                     series = c("No debt", "Less than $10,000", "$10,000–$19,999", "$20,000–$29,999", "$30,000–$39,000", "$40,000 or more"),
                     categories = fig6_12$Sector, tickformat = "percent", rotated = TRUE, directlabels = TRUE)
#Figure 6-11
fig6_11 <- read.csv(paste(textpath, "After college_debt/06_0110.csv", sep=""),stringsAsFactors=FALSE)
json6_11 <- makeJson(sectionn = 6, graphn = 11, dt = fig6_11, graphtype = "bar",
                     series = c("No debt", "Less than $10,000", "$10,000–$19,999", "$20,000–$29,999", "$30,000–$39,000", "$40,000 or more"),
                     categories = fig6_11$Sector, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 6-10
fig6_10 <- read.csv(paste(textpath, "After college_debt/06_0100.csv", sep=""),stringsAsFactors=FALSE)
json6_10 <- makeJson(sectionn = 6, graphn = 10, dt = fig6_10, graphtype = "bar",
                     series = c("No debt", "Less than $10,000", "$10,000–$19,999", "$20,000–$29,999", "$30,000–$39,000", "$40,000–$59,000","$60,000–$99,999", "$100,000 or more" ),
                     categories = fig6_10$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 6-9
fig6_9 <- read.csv(paste(textpath, "After college_debt/06_0090.csv", sep=""),stringsAsFactors=FALSE)
fig6_9$Year <- gsub("-", "–", fig6_9$Year) 
json6_9 <- makeJson(sectionn = 6, graphn = 9, dt = fig6_9, graphtype = "bar",
                     series = c("No debt", "Less than $10,000", "$10,000–$19,999", "$20,000–$29,999", "$30,000–$39,000", "$40,000 or More"),
                     categories = fig6_9$Year, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 6-8
fig6_8 <- read.csv(paste(textpath, "After college_debt/06_0080.csv", sep=""),stringsAsFactors=FALSE)
json6_8 <- makeJson(sectionn = 6, graphn = 8, dt = fig6_8, graphtype = "bar",
                    series = c("Bottom Quartile", "Second Quartile", "Third Quartile", "Highest Quartile"), ymax=1,
                    categories = fig6_8$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 6-7
fig6_7 <- read.csv(paste(textpath, "After college_earnings/06_0070.csv", sep=""),stringsAsFactors=FALSE)
json6_7 <- makeJson(sectionn = 6, graphn = 7, dt = fig6_7, graphtype = "bar",
                    series = c("25th percentile", "50th percentile", "75th percentile"),
                    categories = fig6_7$field, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)


#Figure 6-16
fig6_16a<- read.csv(paste(textpath, "After College_loan repayment/06_0160.csv", sep=""),stringsAsFactors=FALSE)
json6_16a <- makeJson(sectionn = 6, graphn = 161, dt = fig6_16a$percent, graphtype = "bar", series="Borrowers in repayment",
                    categories = fig6_16a$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

fig6_16b<- read.csv(paste(textpath, "After College_loan repayment/06_0161.csv", sep=""),stringsAsFactors=FALSE)
json6_16b <- makeJson(sectionn = 6, graphn = 162, dt = fig6_16b$debt, graphtype = "bar", series="Average debt",
                      categories = fig6_16b$category, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 6-17
fig6_17<- read.csv(paste(textpath, "After College_loan repayment/06_0170.csv", sep=""),stringsAsFactors=FALSE)
json6_17<- makeJson(sectionn = 6, graphn = 17, dt = fig6_17, graphtype = "line", series=c("For-profit", "Public two-year", "Public four-year", "Private four-year"),
                      categories = fig6_17$X, tickformat = "percent", rotated = FALSE, directlabels = TRUE)
#Figure 6-18
fig6_18<- read.csv(paste(textpath, "After College_loan repayment/06_0180.csv", sep=""),stringsAsFactors=FALSE)
json6_18<- makeJson(sectionn = 6, graphn = 18, dt = fig6_18, graphtype = "bar", series=c("2009–10", "2010–11", "2011–12"),
                    categories = fig6_18$X, tickformat = "percent", rotated = FALSE, directlabels = FALSE)

#Figure 6-19
fig6_19<- read.csv(paste(textpath, "After College_loan repayment/06_0190.csv", sep=""),stringsAsFactors=FALSE)
json6_19<- makeJson(sectionn = 6, graphn = 19, dt = fig6_19, graphtype = "line", series=c("Graduated", "Did not graduate", "Total"),
                    categories = fig6_19$X, tickformat = "percent", rotated = FALSE, directlabels = TRUE)
#Figure 6-20
fig6_20<- read.csv(paste(textpath, "After College_loan repayment/06_0200.csv", sep=""),stringsAsFactors=FALSE)
fig6_20$X <- gsub("-", "–", fig6_20$X) 
json6_20<- makeJson(sectionn = 6, graphn = 20, dt = fig6_20$Default.Rate, graphtype = "bar", series="Default Rate",
                    categories = fig6_20$X, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 6-21
fig6_21 <- read.csv(paste(textpath, "Breaking even/06_0210.csv", sep=""),stringsAsFactors=FALSE)
json6_21 <- makeJson(sectionn = 6, graphn = 21, dt = fig6_21, graphtype = "line", xlabel="Age",
                    series = c("High school graduate","Associate degree", "Bachelor's degree"),
                    categories = fig6_21$age, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

