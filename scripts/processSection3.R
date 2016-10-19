
library(dplyr)
library(tidyr)
library(jsonlite)
library(openxlsx)
source('~/Documents/ed-data/scripts/createJsons.R')

# Path to Excel file with graph metadata - change to your file path
textpath <- "/Users/vhou/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) Project/**Production/"
graphtext <- readWorkbook(paste(textpath,"GraphText.xlsx", sep=""), sheet = 1)
graphtext$section_number <- as.numeric(graphtext$section_number)
graphtext$multiples <- as.numeric(graphtext$multiples)
graphtext$toggle <- as.numeric(graphtext$toggle)
fig3_17 <- read.csv(paste(textpath, "Prices and expenses_forgone earnings/03_0170.csv", sep=""),stringsAsFactors=FALSE)
fig3_17 <- as.data.frame(fig3_17)

json3_17 <- makeJson(sectionn = 3, graphn = 17, dt = fig3_17, graphtype = "bar",
                     series = c("Did not work last year", "Part year or part time", "Full year full time"),
                     categories = fig3_17$age, tickformat = "percent", rotated = TRUE, directlabels = TRUE)


