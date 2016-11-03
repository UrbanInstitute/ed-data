
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
