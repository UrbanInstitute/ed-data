
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

#Figure 4-1
fig4_1 <- read.csv(paste(textpath, "Financial aid_financial need/04_0010.csv", sep=""),stringsAsFactors=FALSE)
json4_1 <- makeJson(sectionn = 4, graphn = 1, dt = fig4_1, graphtype = "bar", series=FALSE,
                    categories = fig4_1$IncomeRange, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 4-4
fig4_4 <- read.csv(paste(textpath, "Financial aid_financial need/04_0040.csv", sep=""),stringsAsFactors=FALSE)
json4_4 <- makeJson(sectionn = 4, graphn = 4, dt = fig4_4, graphtype = "bar",
                     series = c("$0", "$1-$4,999", "$5,000-$9,999", "$10,000-$14,999", "$15,000 or higher"),
                     categories = fig4_4$column, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 4-7
fig4_71 <- read.csv(paste(textpath, "Financial aid_grant aid/CSVs/040070.csv", sep=""),stringsAsFactors=FALSE)
fig4_72 <- read.csv(paste(textpath, "Financial aid_grant aid/CSVs/040071.csv", sep=""),stringsAsFactors=FALSE)
fig4_7 <- left_join(fig4_71,fig4_72, by="column")

json4_7 <- makeJson(sectionn = 4, graphn = 7, dt = fig4_7, graphtype = "bar",
                    series = c("Federal Grants", "Veterans' and Military", "State Grants", "Institutional Grants", "Employer or Private Grants"),
                    categories = fig4_4$column, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)


