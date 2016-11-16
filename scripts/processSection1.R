
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


#Figure 1-1
fig1_1 <- read.csv(paste(textpath, "What is college_institutions/01_0010.csv", sep=""),stringsAsFactors=FALSE)
json1_1 <- makeJson(sectionn = 1, graphn = 1, dt = fig1_1$number, graphtype = "bar",
                    series = "Number of Institutions",
                    categories = fig1_1$carnegie, tickformat = "number", rotated = TRUE, directlabels = TRUE)

#Figure 1-2
fig1_2 <- read.csv(paste(textpath, "What is college_institutions/01_0020.csv", sep=""),stringsAsFactors=FALSE)
json1_2 <- makeJson(sectionn = 1, graphn = 2, dt = fig1_2, graphtype = "bar",
                    series = c("0-499", "500-999", "1,000-1,499", "5,000-9,999", "10,000-19,999", "20,000+"),
                    categories = fig1_2$carnegie_label, tickformat = "percent", rotated = TRUE, directlabels = TRUE)


#Figure 1-5
fig1_5 <- read.csv(paste(textpath, "What is college_students/01_0050.csv", sep=""),stringsAsFactors=FALSE)
json1_5 <- makeJson(sectionn = 1, graphn = 5, dt = fig1_5, graphtype = "bar",
                     series = c("Public 4-year", "Private 4-year", "Public 2-year", "For-profit", "Other or non-degree-granting"),
                     categories = fig1_5$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 1-6
fig1_6 <- read.csv(paste(textpath, "What is college_students/01_0060.csv", sep=""),stringsAsFactors=FALSE)
json1_6 <- makeJson(sectionn = 1, graphn = 6, dt = fig1_6, graphtype = "bar",
                    series = c("Public 4-year", "Private 4-year", "Public 2-year", "For-profit", "Other or non-degree-granting"),
                    categories = fig1_6$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 1-7
fig1_7 <- read.csv(paste(textpath, "What is college_students/01_0070.csv", sep=""),stringsAsFactors=FALSE)
json1_7 <- makeJson(sectionn = 1, graphn = 7, dt = fig1_7, graphtype = "bar",
                    series = c("Public 4-year", "Private 4-year", "Public 2-year", "For-profit", "Other or non-degree-granting"),
                    categories = fig1_7$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 1-8
fig1_8 <- read.csv(paste(textpath, "What is college_students/01_0080.csv", sep=""),stringsAsFactors=FALSE)
json1_8 <- makeJson(sectionn = 1, graphn = 8, dt = fig1_8, graphtype = "bar",
                    series = c("Public 4-year", "Private 4-year", "Public 2-year", "For-profit", "Other or non-degree-granting"),
                    categories = fig1_8$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 1-9
fig1_9 <- read.csv(paste(textpath, "What is college_students/01_0090.csv", sep=""),stringsAsFactors=FALSE)
json1_9 <- makeJson(sectionn = 1, graphn = 9, dt = fig1_9, graphtype = "bar",
                    series = c("Public 4-year", "Private 4-year", "Public 2-year", "For-profit", "Other or non-degree-granting"),
                    categories = fig1_9$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 1-10
fig1_10 <- read.csv(paste(textpath, "What is college_students/01_0100.csv", sep=""),stringsAsFactors=FALSE)
json1_10 <- makeJson(sectionn = 1, graphn = 10, dt = fig1_10, graphtype = "bar",
                    series = c("Public 4-year", "Private 4-year", "Public 2-year", "For-profit", "Other or non-degree-granting"),
                    categories = fig1_10$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 1-11
fig1_11 <- read.csv(paste(textpath, "What is college_students/01_0110.csv", sep=""),stringsAsFactors=FALSE)
json1_11 <- makeJson(sectionn = 1, graphn = 11, dt = fig1_11, graphtype = "bar",
                     series = c("Public 4-year", "Private 4-year", "Public 2-year", "For-profit", "Other or non-degree-granting"),
                     categories = fig1_11$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 1-12
fig1_12 <- read.csv(paste(textpath, "What is college_students/01_0120.csv", sep=""),stringsAsFactors=FALSE)
json1_12 <- makeJson(sectionn = 1, graphn = 12, dt = fig1_12, graphtype = "bar",
                     series = c("Public 4-year", "Private 4-year", "Public 2-year", "For-profit", "Other or non-degree-granting"),
                     categories = fig1_12$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 1-13
fig1_13 <- read.csv(paste(textpath, "What is college_students/01_0130.csv", sep=""),stringsAsFactors=FALSE)
json1_13 <- makeJson(sectionn = 1, graphn = 13, dt = fig1_13, graphtype = "bar",
                    series = c("Public 4-year", "Private 4-year", "Public 2-year", "For-profit", "Other or non-degree-granting"),
                    categories = fig1_13$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 1-14
fig1_14 <- read.csv(paste(textpath, "What is college_students/01_0140.csv", sep=""),stringsAsFactors=FALSE)
json1_14 <- makeJson(sectionn = 1, graphn = 14, dt = fig1_14, graphtype = "bar",
                     series = c("Public 4-year", "Private 4-year", "Public 2-year", "For-profit", "Other or non-degree-granting"),
                     categories = fig1_14$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)


