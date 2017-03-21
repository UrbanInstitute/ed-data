
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
fig2_1$academicyear <- gsub("-", "–", fig2_1$academic.year) 
json2_1 <- makeJson(sectionn = 2, graphn = 1, dt = fig2_1, graphtype = "line", series=c("Public-sector FTE student enrollment", "State and local public higher education appropriations", "State and local public higher education appropriations per public-sector FTE student"),
                     categories = fig2_1$academic.year, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

##Figure 2-2


#Figure 2-3
fig2_3 <- read.csv(paste(textpath, "Cost of educating_appropriations/02_0030.csv", sep=""),stringsAsFactors=FALSE)
fig2_3$year <- gsub("-", "–", fig2_3$year) 
json2_3 <- makeJson(sectionn = 2, graphn = 3, dt = fig2_3, graphtype = "line", series=c("State support", "Local support"),
                    categories = fig2_3$year, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 2-4
fig2_4 <- read.csv(paste(textpath, "Cost of educating_appropriations/02_0040.csv", sep=""),stringsAsFactors=FALSE)
json2_4 <- makeJson(sectionn = 2, graphn = 4, dt = fig2_4$public, graphtype = "bar", series="State and local appropriations per public FTE student",
                    categories = fig2_4$state, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)
#Figure 2-61
fig2_61 <- read.csv(paste(textpath, "Cost of educating_endowments/02_0061.csv", sep=""),stringsAsFactors=FALSE)
json2_61 <- makeJson(sectionn = 2, graphn = 61, dt = fig2_61$endowinc_median, graphtype = "bar", series="Applicants Admitted by Percentage",
                   categories = fig2_61$category, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)

#Figure 2-62
fig2_62 <- read.csv(paste(textpath, "Cost of educating_endowments/02_0062.csv", sep=""),stringsAsFactors=FALSE)
json2_62 <- makeJson(sectionn = 2, graphn = 62, dt = fig2_62$endowinc_median, graphtype = "bar", series="Applicants Admitted by Percentage",
                     categories = fig2_62$category, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)
#Figure 2-7: 
fig2_7a <- read.csv(paste(textpath, "Cost of educating_subsidies/02-0071.csv", sep=""),stringsAsFactors=FALSE)
fig2_7a$column <- gsub("-", "–", fig2_7a$column) 
fig2_7b <- read.csv(paste(textpath, "Cost of educating_subsidies/02-0072.csv", sep=""),stringsAsFactors=FALSE)
fig2_7b$column <- gsub("-", "–", fig2_7b$column) 

json2_7a <- makeJson(sectionn = 2, graphn = 7, subn= 1, dt = fig2_7a, graphtype = "bar",
                     series = c("Average net tuition revenue per FTE student", "Average subsidy per FTE student"),
                    categories = fig2_7a$column, graphtitle="Bachelor's", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json2_7b <- makeJson(sectionn = 2, graphn = 7, subn= 2, dt = fig2_7b, graphtype = "bar",
                     series = c("Average net tuition revenue per FTE student", "Average subsidy per FTE student"),
                    categories = fig2_7b$column, graphtitle="Associate", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 2-8
fig2_8a <- read.csv(paste(textpath, "Cost of educating_subsidies/02-0081.csv", sep=""),stringsAsFactors=FALSE)
fig2_8a$category <- gsub("-", "–", fig2_8a$category) 
fig2_8b <- read.csv(paste(textpath, "Cost of educating_subsidies/02-0082.csv", sep=""),stringsAsFactors=FALSE)
fig2_8b$category <- gsub("-", "–", fig2_8b$category) 
fig2_8c <- read.csv(paste(textpath, "Cost of educating_subsidies/02-0083.csv", sep=""),stringsAsFactors=FALSE)
fig2_8c$category <- gsub("-", "–", fig2_8c$category) 

json2_8a <- makeJson(sectionn = 2, graphn = 8, subn= 1, dt = fig2_8a, graphtype = "bar",
                     series = c("Average net tuition revenue per FTE student", "Average subsidy per FTE student"),
                     categories = fig2_8a$category, graphtitle="Research", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

json2_8b <- makeJson(sectionn = 2, graphn = 8, subn= 2, dt = fig2_8b, graphtype = "bar",
                     series = c("Average net tuition revenue per FTE student", "Average subsidy per FTE student"),
                     categories = fig2_8b$category, graphtitle="Master's", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
json2_8c <- makeJson(sectionn = 2, graphn = 8, subn= 3, dt = fig2_8c, graphtype = "bar",
                     series = c("Average net tuition revenue per FTE student", "Average subsidy per FTE student"),
                     categories = fig2_8c$category, graphtitle="Bachelor's", tickformat = "dollar", rotated = FALSE, directlabels = TRUE)




 