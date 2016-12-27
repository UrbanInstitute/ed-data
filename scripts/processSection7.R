
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


#Figure 7-3 had to tweak groups array:
"groups": [
  [
    "Expected family contribution", 
    "Federal grants", 
    "Military/Veterans", 
    "State grants", 
    "Institutional grants", 
    "Private and employer aid", 
    "Federal student loans", 
    "Federal  parent loans", 
    "Private loans", 
    "Earnings and other resources", 
    "Tuition and fees", 
    "NonTF budget"
    ]
  ]

#fig7_3<- read.csv(paste(textpath, "Personas/07_0030-ALL.csv", sep=""),stringsAsFactors=FALSE, check.names= FALSE)
#json7_3<- makeJson(sectionn = 7, graphn = 3, dt = fig7_3, graphtype = "bar", set1= fig7_3[grep("Public four-year in-state", fig7_3$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "NonTF budget")], set2= fig7_3[grep("Public four-year out-of-state", fig7_3$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "NonTF budget")],
#                   set3= fig7_3[grep("Private nonprofit four-year", fig7_3$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "NonTF budget")], set4= fig7_3[grep("For-profit", fig7_3$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "NonTF budget")], 
#                   set5= fig7_3[grep("Public two-year", fig7_3$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "NonTF budget")],
#                   series = c("Public four-year in-state", "Public four-year out-of-state", "Private nonprofit four-year", "For-profit", "Public two-year" ),
#                   categories = fig7_3$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 7-4
fig7_4<- read.csv(paste(textpath, "Personas/07_0040.csv", sep=""),stringsAsFactors=FALSE, check.names=FALSE)
json7_4<- makeJson(sectionn = 7, graphn = 4, dt = fig7_4, graphtype = "bar", set1= fig7_4[grep("Public four-year in-state", fig7_4$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")], set2= fig7_4[grep("Public four-year out-of-state", fig7_4$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],
                   set3= fig7_4[grep("Private nonprofit four-year", fig7_4$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],set4= fig7_4[grep("For-profit", fig7_4$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")], set5= fig7_4[grep("Public two-year", fig7_4$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],
                   series = c("Public four-year in-state", "Public four-year out-of-state", "Private nonprofit four-year", "For-profit", "Public two-year"),
                   categories = fig7_4$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

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
json7_8<- makeJson(sectionn = 7, graphn = 8, dt = fig7_8, graphtype = "bar", set1= fig7_8[grep("Public four-year in-state", fig7_8$category), c("2 years", "3 years", "4 years", "5 years", "6 years")], set2= fig7_8[grep("Public four-year out-of-state", fig7_8$category), c("2 years", "3 years", "4 years", "5 years", "6 years")],
                    set3= fig7_8[grep("Private nonprofit four-year", fig7_8$category), c("2 years", "3 years", "4 years", "5 years", "6 years")],set4= fig7_8[grep("For-profit", fig7_8$category), c("2 years", "3 years", "4 years", "5 years", "6 years")], set5= fig7_8[grep("Public two-year", fig7_8$category), c("2 years", "3 years", "4 years", "5 years", "6 years")],
                   series = c("Public four-year in-state", "Public four-year out-of-state", "Private nonprofit four-year", "For-profit", "Public two-year"),
                   categories = fig7_8$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 7-9
fig7_9<- read.csv(paste(textpath, "Personas/07_0090.csv", sep=""),stringsAsFactors=FALSE)
json7_9<- makeJson(sectionn = 7, graphn = 9, dt = fig7_9$percent, graphtype = "bar", series= "Enrollment",
                   categories = fig7_9$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 7-11 need to change groups array to:
"groups": [
  [
    "Expected family contribution", 
    "Federal grants", 
    "Military/Veterans", 
    "State grants", 
    "Institutional grants", 
    "Private and employer aid", 
    "Federal student loans", 
    "Federal  parent loans", 
    "Private loans", 
    "Earnings and other resources",
    "Budget beyond tuition and fees", 
    "Tuition and fees"
    ]
  ],
fig7_11<- read.csv(paste(textpath, "Personas/07_0110-ALL.csv", sep=""),stringsAsFactors=FALSE, check.names= FALSE)
json7_11<- makeJson(sectionn = 7, graphn = 11, dt = fig7_11, graphtype = "bar", set1= fig7_11[grep("Public four-year in-state", fig7_15$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Earnings and other resources", "Budget beyond tuition and fees", "Tuition and fees")], set2= fig7_11[grep("Public four-year out-of-state", fig7_11$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Earnings and other resources", "Budget beyond tuition and fees", "Tuition and fees")],
                    set3= fig7_11[grep("Private nonprofit four-year", fig7_11$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Earnings and other resources", "Budget beyond tuition and fees", "Tuition and fees")], set4= fig7_11[grep("For-profit", fig7_11$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Earnings and other resources", "Budget beyond tuition and fees", "Tuition and fees")], 
                    set5= fig7_11[grep("Public two-year", fig7_11$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Earnings and other resources", "Budget beyond tuition and fees", "Tuition and fees")],
                    series = c("Public four-year in-state", "Public four-year out-of-state", "Private nonprofit four-year", "For-profit", "Public two-year" ),
                    categories = fig7_11$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 7-12
fig7_12<- read.csv(paste(textpath, "Personas/07_0120-ALL.csv", sep=""),stringsAsFactors=FALSE, check.names=FALSE)
json7_12<- makeJson(sectionn = 7, graphn = 12, dt = fig7_12, graphtype = "bar", set1= fig7_12[grep("Public four-year in-state", fig7_12$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")], set2= fig7_12[grep("Public four-year out-of-state", fig7_12$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],
                   set3= fig7_12[grep("Private nonprofit four-year", fig7_12$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],set4= fig7_12[grep("For-profit", fig7_12$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")], set5= fig7_12[grep("Public two-year", fig7_12$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],
                   series = c("Public four-year in-state", "Public four-year out-of-state", "Private nonprofit four-year", "For-profit", "Public two-year"),
                   categories = fig7_12$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 7-13
fig7_13<- read.csv(paste(textpath, "Personas/07_0090.csv", sep=""),stringsAsFactors=FALSE)
json7_13<- makeJson(sectionn = 7, graphn = 13, dt = fig7_13$percent, graphtype = "bar", series= "Enrollment",
                   categories = fig7_13$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 7-15 need to change groups array to:
"groups": [
  [
    "Expected family contribution", 
    "Federal grants", 
    "Military/Veterans", 
    "State grants", 
    "Institutional grants", 
    "Private and employer aid", 
    "Federal student loans", 
    "Federal  parent loans", 
    "Private loans", 
    "Earnings and other resources",
    "Budget beyond tuition and fees", 
    "Tuition and fees"
    ]
  ],
fig7_15<- read.csv(paste(textpath, "Personas/07_0150-ALL.csv", sep=""),stringsAsFactors=FALSE, check.names= FALSE)
json7_15<- makeJson(sectionn = 7, graphn = 15, dt = fig7_15, graphtype = "bar", set1= fig7_15[grep("Public four-year in-state", fig7_15$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Earnings and other resources", "Budget beyond tuition and fees", "Tuition and fees")], set2= fig7_15[grep("Public four-year out-of-state", fig7_19$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Earnings and other resources", "Budget beyond tuition and fees", "Tuition and fees")],
                    set3= fig7_15[grep("Private nonprofit four-year", fig7_15$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Earnings and other resources", "Budget beyond tuition and fees", "Tuition and fees")], set4= fig7_15[grep("For-profit", fig7_15$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Earnings and other resources", "Budget beyond tuition and fees", "Tuition and fees")], 
                    set5= fig7_15[grep("Public two-year", fig7_15$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Earnings and other resources", "Budget beyond tuition and fees", "Tuition and fees")],
                    series = c("Public four-year in-state", "Public four-year out-of-state", "Private nonprofit four-year", "For-profit", "Public two-year" ),
                    categories = fig7_15$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 7-16
fig7_16<- read.csv(paste(textpath, "Personas/07_0160-ALL.csv", sep=""),stringsAsFactors=FALSE, check.names=FALSE)
json7_16<- makeJson(sectionn = 7, graphn = 16, dt = fig7_16, graphtype = "bar", set1= fig7_16[grep("Public four-year in-state", fig7_16$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")], set2= fig7_16[grep("Public four-year out-of-state", fig7_16$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],
                    set3= fig7_16[grep("Private nonprofit four-year", fig7_16$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],set4= fig7_16[grep("For-profit", fig7_16$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")], set5= fig7_16[grep("Public two-year", fig7_16$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],
                    series = c("Public four-year in-state", "Public four-year out-of-state", "Private nonprofit four-year", "For-profit", "Public two-year"),
                    categories = fig7_16$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 7-17
fig7_17<- read.csv(paste(textpath, "Personas/07_0170.csv", sep=""),stringsAsFactors=FALSE)
json7_17<- makeJson(sectionn = 7, graphn = 17, dt = fig7_17$percent, graphtype = "bar", series= "Enrollment",
                    categories = fig7_17$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 7-19 need to change groups array to:
"groups": [
  [
    "Expected family contribution", 
    "Federal grants", 
    "Military/Veterans", 
    "State grants", 
    "Institutional grants", 
    "Private and employer aid", 
    "Federal student loans", 
    "Federal  parent loans", 
    "Private loans", 
    "Budget beyond tuition and fees", 
    "Tuition and fees"
    ]
  ],
fig7_19<- read.csv(paste(textpath, "Personas/07_0190-ALL.csv", sep=""),stringsAsFactors=FALSE, check.names= FALSE)
json7_19<- makeJson(sectionn = 7, graphn = 19, dt = fig7_19, graphtype = "bar", set1= fig7_19[grep("Public four-year in-state", fig7_19$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Budget beyond tuition and fees", "Tuition and fees")], set2= fig7_19[grep("Public four-year out-of-state", fig7_19$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Budget beyond tuition and fees", "Tuition and fees")],
                   set3= fig7_19[grep("Private nonprofit four-year", fig7_19$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Budget beyond tuition and fees", "Tuition and fees")], set4= fig7_19[grep("For-profit", fig7_19$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Budget beyond tuition and fees", "Tuition and fees")], 
                   set5= fig7_19[grep("Public two-year", fig7_19$category), c("Expected family contribution", "Federal grants", "Military/Veterans", "State grants", "Institutional grants", "Private and employer aid", "Federal student loans", "Federal  parent loans", "Private loans", "Budget beyond tuition and fees", "Tuition and fees")],
                   series = c("Public four-year in-state", "Public four-year out-of-state", "Private nonprofit four-year", "For-profit", "Public two-year" ),
                   categories = fig7_19$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
#Figure 7-20
fig7_20<- read.csv(paste(textpath, "Personas/07_0200-ALL.csv", sep=""),stringsAsFactors=FALSE, check.names=FALSE)
json7_20<- makeJson(sectionn = 7, graphn = 20, dt = fig7_20, graphtype = "bar", set1= fig7_20[grep("Public four-year in-state", fig7_20$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")], set2= fig7_20[grep("Public four-year out-of-state", fig7_20$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],
                    set3= fig7_20[grep("Private nonprofit four-year", fig7_20$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],set4= fig7_20[grep("Public two-year", fig7_20$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")], 
                    series = c("Public four-year in-state", "Public four-year out-of-state", "Private nonprofit four-year", "Public two-year"),
                    categories = fig7_20$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
