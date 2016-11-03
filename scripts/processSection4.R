
library(dplyr)
library(tidyr)
library(jsonlite)
library(openxlsx)


source('~/Documents/ed-data/scripts/createJsons.R')
#source('~/Projects/ed-data/scripts/createJsons.R')

# Path to Excel file with graph metadata - change to your file path

textpath <- "/Users/vhou/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) Project/**Production/"
#textpath <- "/Users/bchartof/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) Project/**Production/"
graphtext <- readWorkbook(paste(textpath, "GraphText.xlsx", sep=""),sheet = 1)
graphtext$section_number <- as.numeric(graphtext$section_number)
graphtext$multiples <- as.numeric(graphtext$multiples)
graphtext$toggle <- as.numeric(graphtext$toggle)

#Figure 4-1
fig4_1 <- read.csv(paste(textpath, "Financial aid_financial need/04_00100.csv", sep=""),stringsAsFactors=FALSE)
json4_1 <- makeJson(sectionn = 4, graphn = 1, dt = fig4_1$MedianEFCbyParentsIncome, graphtype = "bar", series=FALSE,
                    categories = fig4_1$IncomeRange, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)


#Figure 4-4
fig4_4 <- read.csv(paste(textpath, "Financial aid_financial need/04_0040.csv", sep=""),stringsAsFactors=FALSE)
json4_4 <- makeJson(sectionn = 4, graphn = 4, dt = fig4_4, graphtype = "bar",
                     series = c("$0", "$1-$4,999", "$5,000-$9,999", "$10,000-$14,999", "$15,000 or higher"),
                     categories = fig4_4$column, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 4-7
fig4_7a <- read.csv(paste(textpath, "Financial aid_grant aid/CSVs/040071.csv", sep=""),stringsAsFactors=FALSE)
fig4_7b <- read.csv(paste(textpath, "Financial aid_grant aid/CSVs/040072.csv", sep=""),stringsAsFactors=FALSE)


json4_7a <- makeJson(sectionn = 4, graphn = 7, subn= 1, dt = fig4_7a, graphtype = "bar",
                    series = c("Federal Grants", "Veterans' and Military", "State Grants", "Institutional Grants", "Employer or Private Grants"),
                    categories = fig4_7a$column, graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)
json4_7b <- makeJson(sectionn = 4, graphn = 7, subn=2, dt = fig4_7b, graphtype = "bar",
                    series = c("Federal Grants", "Veterans' and Military", "State Grants", "Institutional Grants", "Employer or Private Grants"),
                    categories = fig4_7b$column, graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)


#Figure 4-15
fig4_15a <- read.csv(paste(textpath, "Financial aid_state/04_0151.csv", sep=""),stringsAsFactors=FALSE)
fig4_15b <- read.csv(paste(textpath, "Financial aid_state/04_0152.csv", sep=""),stringsAsFactors=FALSE)
fig4_15c <- read.csv(paste(textpath, "Financial aid_state/04_0153.csv", sep=""),stringsAsFactors=FALSE)
fig4_15d <- read.csv(paste(textpath, "Financial aid_state/04_0154.csv", sep=""),stringsAsFactors=FALSE)
fig4_15e <- read.csv(paste(textpath, "Financial aid_state/04_0155.csv", sep=""),stringsAsFactors=FALSE)

json4_15a <- makeJson(sectionn = 4, graphn = 15, subn= 1, dt = fig4_15a$percent, graphtype = "bar",
                     series = FALSE,
                     categories = fig4_15a$sub_category,  xlabel = "All", graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels = TRUE)
json4_15b <- makeJson(sectionn = 4, graphn = 15, subn=2, dt = fig4_15b$percent, graphtype = "bar",
                     series = FALSE,
                     categories = fig4_15b$sub_category, xlabel = "Dependency Status", graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels = TRUE)
json4_15c <- makeJson(sectionn = 4, graphn = 15, subn=3, dt = fig4_15c$percent, graphtype = "bar",
                      series = FALSE,
                      categories = fig4_15c$sub_category, xlabel = "Dependent Students' Family Income", graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels = TRUE)
json4_15d <- makeJson(sectionn = 4, graphn = 15, subn=4, dt = fig4_15d$percent, graphtype = "bar",
                      series = FALSE,
                      categories = fig4_15d$sub_category, xlabel = "Residency", graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels = TRUE)
json4_15e <- makeJson(sectionn = 4, graphn = 15, subn=5, dt = fig4_15e$percent, graphtype = "bar",
                      series = FALSE,
                      categories = fig4_15e$sub_category, xlabel = "Sector", graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 4-16
fig4_16a <- read.csv(paste(textpath, "Financial aid_state/04_0161.csv", sep=""),stringsAsFactors=FALSE)
fig4_16b <- read.csv(paste(textpath, "Financial aid_state/04_0162.csv", sep=""),stringsAsFactors=FALSE)
fig4_16c <- read.csv(paste(textpath, "Financial aid_state/04_0163.csv", sep=""),stringsAsFactors=FALSE)
fig4_16d <- read.csv(paste(textpath, "Financial aid_state/04_0164.csv", sep=""),stringsAsFactors=FALSE)
fig4_16e <- read.csv(paste(textpath, "Financial aid_state/04_0165.csv", sep=""),stringsAsFactors=FALSE)

json4_16a <- makeJson(sectionn = 4, graphn = 16, subn= 1, dt = fig4_16a$grant, graphtype = "bar",
                      series = FALSE,
                      categories = fig4_16a$sub_category,  xlabel = "All",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)
json4_16b <- makeJson(sectionn = 4, graphn = 16, subn=2, dt = fig4_16b$grant, graphtype = "bar",
                      series = FALSE,
                      categories = fig4_16b$sub_category, xlabel = "Dependency Status", graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)
json4_16c <- makeJson(sectionn = 4, graphn = 16, subn=3, dt = fig4_16c$grant, graphtype = "bar",
                      series = FALSE,
                      categories = fig4_16c$sub_category, xlabel = "Dependent Students' Family Income", graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)
json4_16d <- makeJson(sectionn = 4, graphn = 16, subn=4, dt = fig4_16d$grant, graphtype = "bar",
                      series = FALSE,
                      categories = fig4_16d$sub_category, xlabel = "Residency", graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)
json4_16e <- makeJson(sectionn = 4, graphn = 16, subn=5, dt = fig4_16e$grant, graphtype = "bar",
                      series = FALSE,
                      categories = fig4_16e$sub_category, xlabel = "Sector", graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)