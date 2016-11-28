
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
json6_5 <- makeJson(sectionn = 6, graphn = 5, dt = fig6_5, graphtype = "line", series=c("High school or equivalent", "Some college, no degree", "Associate degree", "Bachelor's degree", "Advanced degree"),
                    categories = fig6_5$age, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 6-6

fig6_6 <- read.csv(paste(textpath, "After college_earnings/06_0060.csv", sep=""),stringsAsFactors=FALSE)
json6_6 <- makeJson(sectionn = 6, graphn = 6, dt = fig6_6, graphtype = "bar",
                    series = c("$0-$20,999",	"$21,000-$35,399",	"$35,400-$51,999",	"$52,000-$79.999	$80,000+"),
                    categories = fig6_6$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 6-15

fig6_15 <- read.csv(paste(textpath, "After college_debt/06_0150.csv", sep=""),stringsAsFactors=FALSE)
figjson6_15 <- makeJson(sectionn = 6, graphn = 15, dt = fig6_15, graphtype = "bar",
                     series = c("No debt", "Less than $10,000", "$10,000–$19,999", "$20,000–$29,999", "$30,000–$39,000", "$40,000 or More"),
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
                     series = c("No debt", "Less than $10,000", "$10,000–$19,999", "$20,000–$29,999", "$30,000–$39,000", "$40,000 or More"),
                     categories = fig6_13$dependency, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 6-12

fig6_12 <- read.csv(paste(textpath, "After college_debt/06_0120.csv", sep=""),stringsAsFactors=FALSE)
json6_12 <- makeJson(sectionn = 6, graphn = 12, dt = fig6_12, graphtype = "bar",
                     series = c("No debt", "Less than $10,000", "$10,000–$19,999", "$20,000–$29,999", "$30,000–$39,000", "$40,000 or More"),
                     categories = fig6_12$Sector, tickformat = "percent", rotated = TRUE, directlabels = TRUE)
#Figure 6-11

fig6_11 <- read.csv(paste(textpath, "After college_debt/06_0110.csv", sep=""),stringsAsFactors=FALSE)
json6_11 <- makeJson(sectionn = 6, graphn = 11, dt = fig6_11, graphtype = "bar",
                     series = c("No debt", "Less than $10,000", "$10,000–$19,999", "$20,000–$29,999", "$30,000–$39,000", "$40,000 or More"),
                     categories = fig6_11$Sector, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 6-10
fig6_10 <- read.csv(paste(textpath, "After college_debt/06_0100.csv", sep=""),stringsAsFactors=FALSE)
json6_10 <- makeJson(sectionn = 6, graphn = 10, dt = fig6_10, graphtype = "bar",
                     series = c("No debt", "Less than $10,000", "$10,000–$19,999", "$20,000–$29,999", "$30,000–$39,000", "$40,000 or More"),
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
                    series = c("Bottom Quartile", "Second Quartile", "Third Quartile", "Highest Quartile"),
                    categories = fig6_8$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 6-7

fig6_7 <- read.csv(paste(textpath, "After college_earnings/06_0070.csv", sep=""),stringsAsFactors=FALSE)
json6_7 <- makeJson(sectionn = 6, graphn = 7, dt = fig6_7, graphtype = "bar",
                    series = c("0-25th percentile", "25th-50th percentile", "50th-75th percentile"),
                    categories = fig6_7$field, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)


#Figure 6-21

fig6_21 <- read.csv(paste(textpath, "Breaking even/06_0210.csv", sep=""),stringsAsFactors=FALSE)
json6_21 <- makeJson(sectionn = 6, graphn = 21, dt = fig6_21, graphtype = "line",
                    series = c("High School Graduate","Associate Degree", "Bachelor's Degree"),
                    categories = fig6_21$age, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

