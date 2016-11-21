
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

#Figure 5-19
fig5_19<- read.csv(paste(textpath, "Covering Expenses_time to degree/05_0190.csv", sep=""),stringsAsFactors=FALSE)
json5_19<- makeJson(sectionn = 5, graphn = 19, dt = fig5_19, graphtype = "bar",
                    series = c("Average years enrolled", "Average years elasped"),
                    categories = fig5_19$category, tickformat = "number", rotated = FALSE, directlabels = TRUE)


#Figure 5-24
fig5_24<- read.csv(paste(textpath, "Covering Expenses_time to degree/05_0240.csv", sep=""),stringsAsFactors=FALSE)
json5_24<- makeJson(sectionn = 5, graphn = 24, dt = fig5_24$foregone, graphtype = "bar",
                    series = "Forgone earnings",
                    categories = fig5_24$category, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)


#Figure 5-22
fig5_22<- read.csv(paste(textpath, "Covering Expenses_time to degree/05_0220-revised.csv", sep=""),stringsAsFactors=FALSE)
json5_22<- makeJson(sectionn = 5, graphn = 22, dt = fig5_22, graphtype = "bar",
                     series = c("4 years", "5 years", "6 years"),
                     categories = fig5_22$category, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 5-23

fig5_23 <- read.csv(paste(textpath, "Covering expenses_time to degree/05_0230.csv", sep=""),stringsAsFactors=FALSE)
json5_23 <- makeJson(sectionn = 5, graphn = 23, dt = fig5_23, graphtype = "bar",
                     series = c("No debt", "Less than $10,000", "$10,000–$19,999", "$20,000–$29,999", "$30,000–$39,000", "$40,000 or More"),
                     categories = fig5_23$time_between_enroll_completion, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 5-21

fig5_21 <- read.csv(paste(textpath, "Covering expenses_time to degree/05_0210.csv", sep=""),stringsAsFactors=FALSE)
json5_21 <- makeJson(sectionn = 5, graphn = 21, dt = fig5_21, graphtype = "bar",
                     series = c("2 years or less", "3 years", "4 to 5 years", "6 years or more"),
                     categories = fig5_21$Sector, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 5-20

fig5_20 <- read.csv(paste(textpath, "Covering expenses_time to degree/05_0200.csv", sep=""),stringsAsFactors=FALSE)
json5_20 <- makeJson(sectionn = 5, graphn = 20, dt = fig5_20, graphtype = "bar",
                     series = c("4 years or less", "5 years", "6 to 7 years", "8 years or more"),
                     categories = fig5_20$Sector, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 5-11
fig5_11 <- read.csv(paste(textpath, "Covering expenses_working/05_0110.csv", sep=""),stringsAsFactors=FALSE)
fig5_11$category <- gsub("-", "–", fig5_11$category) 
json5_11 <- makeJson(sectionn = 5, graphn = 11, dt = fig5_11, graphtype = "bar", series=c("Total", "Public four-year", "Private nonprofit four-year", "Public two-year", "For-profit"), set1=fig5_11[,c("all")], set2=fig5_11[,c("publicfour")],
                     set3=fig5_11[,c("publictwo")], set4=fig5_11[,c("privatenonprofit")], set5=fig5_11[,c("forprofit")], categories = fig5_11$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 5-10

fig5_10 <- read.csv(paste(textpath, "Covering expenses_working/05_0100.csv", sep=""),stringsAsFactors=FALSE)
json5_10 <- makeJson(sectionn = 5, graphn = 10, dt = fig5_10, graphtype = "bar",
                     series = c("No earnings", "$1–$2,999", "$3,000–$5,999", "$6,000–$8,999", "$9,000–$11,999", "$12,000–$14,999", "$15,000 or more"),
                     categories = fig5_10$hours, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 5-9

fig5_9 <- read.csv(paste(textpath, "Covering expenses_working/05_0090.csv", sep=""),stringsAsFactors=FALSE)
json5_9 <- makeJson(sectionn = 5, graphn = 9, dt = fig5_9, graphtype = "bar",
                     series = c("No work", "1–5", "6–10", "11–15", "16–20", "21–30", "31–40", "41 or more"),
                     categories = fig5_9$hours, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 5-8
fig5_8<- read.csv(paste(textpath, "Covering expenses_working/05_0080.csv", sep=""),stringsAsFactors=FALSE)
json5_8 <- makeJson(sectionn = 5, graphn = 8, dt = fig5_8$minwage, graphtype = "bar", series="State minimum wage",
                    categories = fig5_8$state, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)

#Figure 5-7
fig5_7<- read.csv(paste(textpath, "Covering expenses_working/05_0070.csv", sep=""),stringsAsFactors=FALSE)
json5_7 <- makeJson(sectionn = 5, graphn = 7, dt = fig5_7$fed_min_wage, graphtype = "line", series="Federal minimum wage",
                    categories = fig5_7$year, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 5-6
fig5_6<- read.csv(paste(textpath, "Covering expenses_working/05_0060.csv", sep=""),stringsAsFactors=FALSE)
json5_6 <- makeJson(sectionn = 5, graphn = 6, dt = fig5_6, graphtype = "line", series=c("800 hours at minimum wage", "Tuition, fees, room, and board", "Tuition and fees"),
                    categories = fig5_6$year, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 5-2
fig5_2<- read.csv(paste(textpath, "Covering expenses_income/05_0020.csv", sep=""),stringsAsFactors=FALSE)
json5_2 <- makeJson(sectionn = 5, graphn = 2, dt = fig5_2$Median.Income, graphtype = "bar", series="Median Income",
                    categories = fig5_2$Ed.level, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)

#Figure 5-1

fig5_1a <- read.csv(paste(textpath, "Covering expenses_income/05_0011.csv", sep=""),stringsAsFactors=FALSE)
fig5_1b <- read.csv(paste(textpath, "Covering expenses_income/05_0012.csv", sep=""),stringsAsFactors=FALSE)
fig5_1c <- read.csv(paste(textpath, "Covering expenses_income/05_0013.csv", sep=""),stringsAsFactors=FALSE)
fig5_1d <- read.csv(paste(textpath, "Covering expenses_income/05_0014.csv", sep=""),stringsAsFactors=FALSE)

json5_1a <- makeJson(sectionn = 5, graphn = 1, subn= 1, dt = fig5_1a$income, graphtype = "bar",
                      series = "Income",
                      categories = fig5_1a$category,  xlabel = "All",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, ymax=100000, directlabels = TRUE)
json5_1b <- makeJson(sectionn = 5, graphn = 1, subn= 2, dt = fig5_1b$income, graphtype = "bar",
                      series = "Income",
                      categories = fig5_1b$category,  xlabel = "Race",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, ymax=100000, directlabels = TRUE)
json5_1c <- makeJson(sectionn = 5, graphn = 1, subn= 3, dt = fig5_1c$income, graphtype = "bar",
                      series = "Income",
                      categories = fig5_1c$category,  xlabel = "Geographical region",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, ymax=100000, directlabels = TRUE)
json5_1d <- makeJson(sectionn = 5, graphn = 1, subn= 4, dt = fig5_1d$income, graphtype = "bar",
                      series = "Income",
                      categories = fig5_1d$category,  xlabel = "Age",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, ymax=100000, directlabels = TRUE)

