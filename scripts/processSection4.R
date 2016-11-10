
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

#Figure 4-2
fig4_2 <- read.csv(paste(textpath, "Financial aid_financial need/04_0020.csv", sep=""),stringsAsFactors=FALSE)
json4_2 <- makeJson(sectionn = 4, graphn = 2, dt = fig4_2, graphtype = "bar", series= c("Independent, No Dependents Unmarried", "Independent, No Dependents Married",	"Independent with Dependents"),
                     categories = fig4_2$category, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)

#Figure 4-3
fig4_3 <- read.csv(paste(textpath, "Financial aid_financial need/04_0030.csv", sep=""),stringsAsFactors=FALSE)
json4_3 <- makeJson(sectionn = 4, graphn = 3, dt = fig4_3$Percent0EFC, graphtype = "bar", series=FALSE,
                    categories = fig4_3$DependencyStatus, tickformat = "percent", rotated = FALSE, directlabels = TRUE)


#Figure 4-4
fig4_4 <- read.csv(paste(textpath, "Financial aid_financial need/04_0040.csv", sep=""),stringsAsFactors=FALSE)
json4_4 <- makeJson(sectionn = 4, graphn = 4, dt = fig4_4, graphtype = "bar",
                    series = c("$0", "$1-$4,999", "$5,000-$9,999", "$10,000-$14,999", "$15,000 or higher"),
                    categories = fig4_4$column, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 4-5
fig4_5 <- read.csv(paste(textpath, "Financial aid_grant aid/CSVs/04_0050.csv", sep=""),stringsAsFactors=FALSE)
json4_5 <- makeJson(sectionn = 4, graphn = 5, dt = fig4_5$grant, graphtype = "bar", series=FALSE,
                    categories = fig4_5$category, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)


#Figure 4-6
fig4_6 <- read.csv(paste(textpath, "Financial aid_grant aid/CSVs/04_0060.csv", sep=""),stringsAsFactors=FALSE)
json4_6 <- makeJson(sectionn = 4, graphn = 6, dt = fig4_6, graphtype = "bar",
                    series = c("Federal (Nonmilitary)","Veterans/Department of Defense","State","Institutional","Private and Employer"),
                    categories = fig4_6$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)


#Figure 4-7
fig4_7a <- read.csv(paste(textpath, "Financial aid_grant aid/CSVs/040071.csv", sep=""),stringsAsFactors=FALSE)
fig4_7b <- read.csv(paste(textpath, "Financial aid_grant aid/CSVs/040072.csv", sep=""),stringsAsFactors=FALSE)


json4_7a <- makeJson(sectionn = 4, graphn = 7, subn= 1, dt = fig4_7a, graphtype = "bar",
                    series = c("Federal Grants", "Veterans' and Military", "State Grants", "Institutional Grants", "Employer or Private Grants"),
                    categories = fig4_7a$column, graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)
json4_7b <- makeJson(sectionn = 4, graphn = 7, subn=2, dt = fig4_7b, graphtype = "bar",
                    series = c("Federal Grants", "Veterans' and Military", "State Grants", "Institutional Grants", "Employer or Private Grants"),
                    categories = fig4_7b$column, graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)

#Figure 4-8
fig4_8 <- read.csv(paste(textpath, "Financial aid_grant aid/CSVs/04_0080.csv", sep=""),stringsAsFactors=FALSE)
json4_8<- makeJson(sectionn = 4, graphn = 8, dt = fig4_8, graphtype = "bar",
                    series = c("Federal", "Veterans", "State", "Institutional", "Private", "Total"),
                    categories = fig4_8$category, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)

#Figure 4-10
fig4_10 <- read.csv(paste(textpath, "Financial aid_federal/04_0100.csv", sep=""),stringsAsFactors=FALSE)
json4_10 <- makeJson(sectionn = 4, graphn = 10, dt = fig4_10, graphtype = "line", series=c("Max Pell (2015 dollars)", "Average Pell (2015 dollars)"),
                    categories = fig4_10$year, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 4-11
fig4_11 <- read.csv(paste(textpath, "Financial aid_federal/04_0110.csv", sep=""),stringsAsFactors=FALSE)
json4_11 <- makeJson(sectionn = 4, graphn = 11, dt = fig4_11$recipients, graphtype = "bar", series=FALSE,
                    categories = fig4_11$year, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)


#Figure 4-13
fig4_13 <- read.csv(paste(textpath, "Financial aid_state/04_0130.csv", sep=""),stringsAsFactors=FALSE)
json4_13 <- makeJson(sectionn = 4, graphn = 13, dt = fig4_13$GrantAid, graphtype = "bar", series=FALSE,
                    categories = fig4_13$state, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)

#Figure 4-14
fig4_14 <- read.csv(paste(textpath, "Financial aid_state/04_0140.csv", sep=""),stringsAsFactors=FALSE)
json4_14 <- makeJson(sectionn = 4, graphn = 14, dt = fig4_14$stategrants, graphtype = "bar", series=FALSE,
                     categories = fig4_14$state, tickformat = "percent", rotated = TRUE, directlabels = TRUE)


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

#Figure 4-17
fig4_17 <- read.csv(paste(textpath, "Financial aid_state/04_0170-no_percent.csv", sep=""),stringsAsFactors=FALSE)
json4_17 <- makeJson(sectionn = 4, graphn = 17, dt = fig4_17, graphtype = "area",
                    series = c("Need-based", "Non Need-based"),
                    categories = fig4_17$year, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 4-24
fig4_24 <- read.csv(paste(textpath, "Financial aid_tax benefits/04_0240-dollars.csv", sep=""),stringsAsFactors=FALSE)
json4_24 <- makeJson(sectionn = 4, graphn = 24, dt = fig4_24, graphtype = "area",
                     series = c("Total Credits", "Total Deduction"),
                     categories = fig4_24$year, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 4-25
fig4_25 <- read.csv(paste(textpath, "Financial aid_tax benefits/04_0250.csv", sep=""),stringsAsFactors=FALSE)
json4_25 <- makeJson(sectionn = 4, graphn = 25, dt = fig4_25, graphtype = "bar",
                     series = FALSE,
                     categories = fig4_25$range, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

