
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


#Figure 2-1
fig2_1 <- read.csv(paste(textpath, "Cost of educating_appropriations/02_0010.csv", sep=""),stringsAsFactors=FALSE)
json2_1 <- makeJson(sectionn = 2, graphn = 1, dt = fig2_1, graphtype = "line", series=c("Change from 2000 in state and local public higher education appropriations", "Change from 2000 in public student enrollment", "Change from 2000 in state and local public higher education appropriations per public student"),
                     categories = fig2_1$year, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 2-3
fig2_3 <- read.csv(paste(textpath, "Cost of educating_appropriations/02_0030.csv", sep=""),stringsAsFactors=FALSE)
json2_3 <- makeJson(sectionn = 2, graphn = 3, dt = fig2_3, graphtype = "line", series=c("Local support", "State support for public"),
                    categories = fig2_3$year, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 2-4
fig2_4 <- read.csv(paste(textpath, "Cost of educating_appropriations/02_0040.csv", sep=""),stringsAsFactors=FALSE)
json2_4 <- makeJson(sectionn = 2, graphn = 4, dt = fig2_4$public, graphtype = "bar", series=FALSE,
                    categories = fig2_4$state, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)