
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


#Figure 6-3

fig6_3 <- read.csv(paste(textpath, "After college_employment/06_0030.csv", sep=""),stringsAsFactors=FALSE)
json6_3 <- makeJson(sectionn = 6, graphn = 3, dt = fig6_3, graphtype = "bar",
                     series = c("No work last year", "Part year or part time", "Full year full time"),
                     categories = fig6_3$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 6-15

fig6_15 <- read.csv(paste(textpath, "After college_debt/06_0150.csv", sep=""),stringsAsFactors=FALSE)
json6_15 <- makeJson(sectionn = 6, graphn = 15, dt = fig6_15, graphtype = "bar",
                     series = c("No debt", "Less than $10,000", "$10,000-$19,999", "$20,000-$29,999", "$30,000-$39,000", "$40,000 or More"),
                     categories = fig6_15$race, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 6-14
fig6_14 <- read.csv(paste(textpath, "After college_debt/06_0140.csv", sep=""),stringsAsFactors=FALSE)
json6_14 <- makeJson(sectionn = 6, graphn = 14, dt = fig6_14, graphtype = "bar",
                     series = c("No debt", "$1-$9,999", "$10,000-$19,999", "$20,000-$29,999", "$30,000-$39,000", "$40,000 or more"),
                     categories = fig6_14$column, tickformat = "percent", rotated = TRUE, directlabels = TRUE)


#Figure 6-13

fig6_13 <- read.csv(paste(textpath, "After college_debt/06_0130.csv", sep=""),stringsAsFactors=FALSE)
json6_13 <- makeJson(sectionn = 6, graphn = 13, dt = fig6_13, graphtype = "bar",
                     series = c("No debt", "Less than $10,000", "$10,000-$19,999", "$20,000-$29,999", "$30,000-$39,000", "$40,000 or More"),
                     categories = fig6_13$dependency, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 6-12

fig6_12 <- read.csv(paste(textpath, "After college_debt/06_0120.csv", sep=""),stringsAsFactors=FALSE)
json6_12 <- makeJson(sectionn = 6, graphn = 12, dt = fig6_12, graphtype = "bar",
                     series = c("No debt", "Less than $10,000", "$10,000-$19,999", "$20,000-$29,999", "$30,000-$39,000", "$40,000 or More"),
                     categories = fig6_12$Sector, tickformat = "percent", rotated = TRUE, directlabels = TRUE)
#Figure 6-11

fig6_11 <- read.csv(paste(textpath, "After college_debt/06_0110.csv", sep=""),stringsAsFactors=FALSE)
json6_11 <- makeJson(sectionn = 6, graphn = 11, dt = fig6_11, graphtype = "bar",
                     series = c("No debt", "Less than $10,000", "$10,000-$19,999", "$20,000-$29,999", "$30,000-$39,000", "$40,000 or More"),
                     categories = fig6_11$Sector, tickformat = "percent", rotated = TRUE, directlabels = TRUE)


