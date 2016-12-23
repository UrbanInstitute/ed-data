
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

#Figure 7-1
fig7_1<- read.csv(paste(textpath, "Personas/07_0010.csv", sep=""),stringsAsFactors=FALSE)
json7_1<- makeJson(sectionn = 7, graphn = 1, dt = fig7_1$percent, graphtype = "bar", series= "Enrollment",
                    categories = fig7_1$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 7-3
fig7_3<- read.csv(paste(textpath, "Personas/07_0030-ALL.csv", sep=""),stringsAsFactors=FALSE)
json7_3<- makeJson(sectionn = 7, graphn = 3, dt = fig7_3, graphtype = "bar", series=c("Public four-year in-state","Public four-year out-of-state", "Private nonprofit four-year", "For-profit", "Public two-year"),
                   categories = fig7_3$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 7-4
fig7_4<- read.csv(paste(textpath, "Personas/07_0040.csv", sep=""),stringsAsFactors=FALSE, check.names=FALSE)
json7_4<- makeJson(sectionn = 7, graphn = 4, dt = fig7_4, graphtype = "bar", series=c("Public four-year out-of-state","Public four-year in-state", "Private", "For-profit", "Public two-year"), set1= fig7_4[,c("Public four-year out-of-state, 4 years", "Public four-year out-of-state, 5 years", "Public four-year out-of-state, 6 years")], set2= fig7_4[,c("Public four-year in-state, 1 year", "Public four-year in-state, 2 years", "Public four-year in-state, 3 years", "Public four-year in-state, 4 years", "Public four-year in-state, 5 years", "Public four-year in-state, 6 years")], set3= fig7_4[,c("Private, 4 years", "Private, 5 years", "Private, 6 years")],  set4= fig7_4[,c("For-profit, 2 years", "For-profit, 3 years", "For-profit, 4 years", "For-profit, 5 years", "For-profit, 6 years")],  set5= fig7_4[,c("Public two-year, 2 years", "Public two-year, 3 years", "Public two-year, 4 years")], 
                   categories = fig7_4$category, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 7-5
fig7_5<- read.csv(paste(textpath, "Personas/07_0050.csv", sep=""),stringsAsFactors=FALSE)
json7_5<- makeJson(sectionn = 7, graphn = 5, dt = fig7_5$percent, graphtype = "bar", series= "Enrollment",
                   categories = fig7_5$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 7-7 ##had to change groups array:

"groups": [
  [
    "Private loans", 
    "Institutional grants", 
    "Tuition and fees", 
    "State public grants",
    "Federal grants", 
    "NonTF budget", 
    "EFC", 
    "Military/Veterans", 
    "Private and employer aid", 
    "Federal parent loans", 
    "Federal student loans", 
    "Earnings and other resources"
    ]
  ],
#fig7_7<- read.csv(paste(textpath, "Personas/07_0070.csv", sep=""),stringsAsFactors=FALSE)
#json7_7<- makeJson(sectionn = 7, graphn = 7, dt = fig7_7, graphtype = "bar", series=c("Public four-year in-state", "Public four-year out-of-state"),
#                   set1= fig7_7[,c("EFC_public_in","federal_public_in","military_public_in","state_public_in","inst_public_in","private_public_in","student_loans_public_in","parent_loans_public_in","private_loans_public_in","earnings_public_in","budget_public_in","tuition_public_in")], 
#                   set2= fig7_7[,c("EFC_public_out","federal_public_out","military_public_out","state_public_out","inst_public_out","private_public_out","student_loans_public_out","parent_loans_public_out","private_loans_public_out","earnings_public_out","budget_public_out","tuition_public_out")], 
#                   categories = fig7_7$category, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 7-8 
fig7_8<- read.csv(paste(textpath, "Personas/07_0080.csv", sep=""),stringsAsFactors=FALSE, check.names=FALSE)
json7_8<- makeJson(sectionn = 7, graphn = 8, dt = fig7_8, graphtype = "bar", series=c("Public four-year in-state", "Public four-year out-of-state", "Private", "For-profit", "Public two-year"),  set1= fig7_8[,c("Public four-year in-state, 4 years", "Public four-year in-state, 5 years", "Public four-year in-state, 6 years")], set2= fig7_8[,c("Public four-year out-of-state, 4 years", "Public four-year out-of-state, 5 years", "Public four-year out-of-state, 6 years")],  set3= fig7_8[,c("Private, 4 years", "Private, 5 years", "Private, 6 years")],  set4= fig7_8[,c("For-profit, 2 years", "For-profit, 2 years", "For-profit, 3 years", "For-profit, 4 years", "For-profit, 5 years")],  set5= fig7_8[,c("Public two-year, 2 years", "Public two-year, 3 years", "Public two-year, 4 years")], 
                   categories = fig7_8$category, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 7-9
fig7_9<- read.csv(paste(textpath, "Personas/07_0090.csv", sep=""),stringsAsFactors=FALSE)
json7_9<- makeJson(sectionn = 7, graphn = 9, dt = fig7_9$percent, graphtype = "bar", series= "Enrollment",
                   categories = fig7_9$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 7-13
fig7_13<- read.csv(paste(textpath, "Personas/07_0090.csv", sep=""),stringsAsFactors=FALSE)
json7_13<- makeJson(sectionn = 7, graphn = 13, dt = fig7_13$percent, graphtype = "bar", series= "Enrollment",
                   categories = fig7_13$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 7-17
fig7_17<- read.csv(paste(textpath, "Personas/07_0170.csv", sep=""),stringsAsFactors=FALSE)
json7_17<- makeJson(sectionn = 7, graphn = 17, dt = fig7_17$percent, graphtype = "bar", series= "Enrollment",
                    categories = fig7_17$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

