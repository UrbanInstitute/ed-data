
library(dplyr)
library(tidyr)
library(jsonlite)
library(openxlsx)
 

source('~/Documents/ed-data/scripts/createJsons.R')
textpath <- "/Users/vivhou/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) Project/**Production/"
# textpath <- "/Users/bchartof/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) 
# Project/**Production/"
# source('~/Projects/ed-data/scripts/createJsons.R')

graphtext <- readWorkbook(paste(textpath, "GraphText.xlsx", sep=""),sheet = 1)
graphtext$section_number <- as.numeric(graphtext$section_number)
graphtext$multiples <- as.numeric(graphtext$multiples)
graphtext$toggle <- as.numeric(graphtext$toggle)

#Figure 7-1
fig7_1<- read.csv(paste(textpath, "Personas/07_0010.csv", sep=""),stringsAsFactors=FALSE)
json7_1<- makeJson(sectionn = 7, graphn = 1, dt = fig7_1$percent, graphtype = "bar", series= "Enrollment",
                    categories = fig7_1$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)


#Figure 7-3 

#1) change 0 to "NA" with regex
#[0]{1}[,]  --> replace with "NA",
#[0]{1}\n  --> replace with "NA"\n

#2) edit groups array
#"groups": [
#[
#"Private loans", 
#"Institutional grant aid", 
#"Tuition and fees", 
#"State grant aid",
#"Federal grant aid", 
#"Budget beyond tuition and fees", 
#"Expected family contribution", 
#"Military and veterans grant aid", 
#"Private and employer grant aid", 
#"Federal parent loans", 
#"Federal student loans", 
#"Earnings and other resources"
#]
#],

#3) add colors array
#"colors": {
#"Expected family contribution": "#848081",
#"Federal grant aid": "#cfe8f3",
#"Military and veterans grant aid": "#a2d4ec",
#"State grant aid": "#73bfe2",
#"Institutional grant aid":"#1696d2",
#"Private and employer grant aid": "#1696d2",
#"Federal student loans": "#fccb41",
#"Federal parent loans": "#fdbf11",
#"Private loans": "#fce39e",
#"Earnings and other resources": "#d5d5d4",
#"Tuition and fees": "#ec008b",
#"Budget beyond tuition and fees": "#000000"
#},


fig7_3<- read.csv(paste(textpath, "Personas/07_0030-ALL.csv", sep=""),stringsAsFactors=FALSE, check.names= FALSE)
fig7_json7_3<- makeJson(sectionn = 7, graphn = 3, dt = fig7_3, graphtype = "bar", set1= fig7_3[grep("Public four-year in-state", fig7_3$category), c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")], set2= fig7_3[grep("Public four-year out-of-state", fig7_3$category),  c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")],
                   set3= fig7_3[grep("Private nonprofit four-year", fig7_3$category),  c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")], set4= fig7_3[grep("For-profit", fig7_3$category), c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")],
                   set5= fig7_3[grep("Public two-year", fig7_3$category),  c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")],
                   series = c("Public four-year in-state","Public four-year out-of-state","Private nonprofit four-year","For-profit", "Public two-year"),
                   categories = fig7_3$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)
#Figure 7-4
#- had to manually set order of years for each toggle category so that years are ascending
#-for example: 
#
#``` 
#"For-profit",
#[
#[
#"2 years",
#28295.96,
#18434.976
#],
#[
#"3 years",
#42443.94,
#27652.464
#],
#[
#"4 years",
#56591.92,
#36869.952
#],
#[
#"5 years",
#70739.9,
#46087.44
#],
#[
#"6 years",
#84887.88,
#55304.928
#]
#
#]
#],
#```
fig7_4<- read.csv(paste(textpath, "Personas/07_0040.csv", sep=""),stringsAsFactors=FALSE, check.names=FALSE)
json7_4<- makeJson(sectionn = 7, graphn = 4, dt = fig7_4, graphtype = "bar", set1= fig7_4[grep("Public four-year in-state", fig7_4$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")], set2= fig7_4[grep("Public four-year out-of-state", fig7_4$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],
                   set3= fig7_4[grep("Private nonprofit four-year", fig7_4$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],set4= fig7_4[grep("For-profit", fig7_4$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")], set5= fig7_4[grep("Public two-year", fig7_4$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],
                   series = c("Public four-year in-state", "Public four-year out-of-state", "Private nonprofit four-year", "For-profit", "Public two-year"),
                   categories = fig7_4$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 7-5
fig7_5<- read.csv(paste(textpath, "Personas/07_0050.csv", sep=""),stringsAsFactors=FALSE)
json7_5<- makeJson(sectionn = 7, graphn = 5, dt = fig7_5$percent, graphtype = "bar", series= "Enrollment",
                   categories = fig7_5$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 7-7 haddata:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAJCAYAAAD6reaeAAAAN0lEQVR42mNggIJJ02f+Z0AGE6fN/A8ShEvAOAg86z/DfyyAASvA1D4Toh1ZAK4dIjEL0zxkAQAPeFlrV0HzRgAAAABJRU5ErkJggg== to change groups array and manually set colors
#1) change 0 to "NA" with regex
#[0]{1}[,]  --> replace with "NA",
#[0]{1}\n  --> replace with "NA"\n

#2) edit groups array
#"groups": [
#[
#"Private loans", 
#"Institutional grant aid", 
#"Tuition and fees", 
#"State grant aid",
#"Federal grant aid", 
#"Budget beyond tuition and fees", 
#"Expected family contribution", 
#"Military and veterans grant aid", 
#"Private and employer grant aid", 
#"Federal parent loans", 
#"Federal student loans", 
#"Earnings and other resources"
#]
#],

#3) add colors array
#"colors": {
  #"Expected family contribution": "#848081",
  #"Federal grant aid": "#cfe8f3",
  #"Military and veterans grant aid": "#a2d4ec",
  #"State grant aid": "#73bfe2",
  #"Institutional grant aid":"#1696d2",
  #"Private and employer grant aid": "#1696d2",
  #"Federal student loans": "#fccb41",
  #"Federal parent loans": "#fdbf11",
  #"Private loans": "#fce39e",
  #"Earnings and other resources": "#d5d5d4",
  #"Tuition and fees": "#ec008b",
  #"Budget beyond tuition and fees": "#000000"
  #},

fig7_7<- read.csv(paste(textpath, "Personas/07_0070-ALL.csv", sep=""),stringsAsFactors=FALSE, check.names=FALSE)
json7_7<- makeJson(sectionn = 7, graphn = 7, dt = fig7_7, graphtype = "bar", set1= fig7_7[grep("Public four-year in-state", fig7_7$category), c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")], set2= fig7_7[grep("Public four-year out-of-state", fig7_7$category),  c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")],
                   set3= fig7_7[grep("Private nonprofit four-year", fig7_7$category),  c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")], set4= fig7_7[grep("For-profit", fig7_7$category), c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")],
                   set5= fig7_7[grep("Public two-year", fig7_7$category),  c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")],
                   series = c("Public four-year in-state","Public four-year out-of-state","Private nonprofit four-year","For-profit", "Public two-year"),
                   categories = fig7_7$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 7-8 
#had to manually set order of years for each toggle category so that years are ascending

fig7_8<- read.csv(paste(textpath, "Personas/07_0080.csv", sep=""),stringsAsFactors=FALSE, check.names=FALSE)
json7_8<- makeJson(sectionn = 7, graphn = 8, dt = fig7_8, graphtype = "bar", set1= fig7_8[grep("Public four-year in-state", fig7_8$category), c("2 years", "3 years", "4 years", "5 years", "6 years")], set2= fig7_8[grep("Public four-year out-of-state", fig7_8$category), c("2 years", "3 years", "4 years", "5 years", "6 years")],
                    set3= fig7_8[grep("Private nonprofit four-year", fig7_8$category), c("2 years", "3 years", "4 years", "5 years", "6 years")],set4= fig7_8[grep("For-profit", fig7_8$category), c("2 years", "3 years", "4 years", "5 years", "6 years")], set5= fig7_8[grep("Public two-year", fig7_8$category), c("2 years", "3 years", "4 years", "5 years", "6 years")],
                   series = c("Public four-year in-state", "Public four-year out-of-state", "Private nonprofit four-year", "For-profit", "Public two-year"),
                   categories = fig7_8$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 7-9
fig7_9<- read.csv(paste(textpath, "Personas/07_0090.csv", sep=""),stringsAsFactors=FALSE)
json7_9<- makeJson(sectionn = 7, graphn = 9, dt = fig7_9$percent, graphtype = "bar", series= "Enrollment",
                   categories = fig7_9$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 7-11

#1) change 0 to "NA" with regex
#[0]{1}[,]  --> replace with "NA",
#[0]{1}\n  --> replace with "NA"\n

#2) edit groups array
#"groups": [
#[
#"Private loans", 
#"Institutional grant aid", 
#"Tuition and fees", 
#"State grant aid",
#"Federal grant aid", 
#"Budget beyond tuition and fees", 
#"Expected family contribution", 
#"Military and veterans grant aid", 
#"Private and employer grant aid", 
#"Federal parent loans", 
#"Federal student loans", 
#"Earnings and other resources"
#]
#],

#3) add colors array
#"colors": {
#"Expected family contribution": "#848081",
#"Federal grant aid": "#cfe8f3",
#"Military and veterans grant aid": "#a2d4ec",
#"State grant aid": "#73bfe2",
#"Institutional grant aid":"#1696d2",
#"Private and employer grant aid": "#1696d2",
#"Federal student loans": "#fccb41",
#"Federal parent loans": "#fdbf11",
#"Private loans": "#fce39e",
#"Earnings and other resources": "#d5d5d4",
#"Tuition and fees": "#ec008b",
#"Budget beyond tuition and fees": "#000000"
#},


fig7_11<- read.csv(paste(textpath, "Personas/07_0110-ALL.csv", sep=""),stringsAsFactors=FALSE, check.names= FALSE)
json7_11<- makeJson(sectionn = 7, graphn = 11, dt = fig7_11, graphtype = "bar", set1= fig7_11[grep("Public four-year in-state", fig7_11$category), c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")], set2= fig7_11[grep("Public four-year out-of-state", fig7_11$category),  c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")],
                   set3= fig7_11[grep("Private nonprofit four-year", fig7_11$category),  c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")], set4= fig7_11[grep("For-profit", fig7_11$category), c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")],
                   set5= fig7_11[grep("Public two-year", fig7_11$category),  c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")],
                   series = c("Public four-year in-state","Public four-year out-of-state","Private nonprofit four-year","For-profit", "Public two-year"),
                   categories = fig7_11$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 7-12
#had to manually set order of years for each toggle category so that years are ascending
fig7_12<- read.csv(paste(textpath, "Personas/07_0120-ALL.csv", sep=""),stringsAsFactors=FALSE, check.names=FALSE)
json7_12<- makeJson(sectionn = 7, graphn = 12, dt = fig7_12, graphtype = "bar", set1= fig7_12[grep("Public four-year in-state", fig7_12$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")], set2= fig7_12[grep("Public four-year out-of-state", fig7_12$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],
                   set3= fig7_12[grep("Private nonprofit four-year", fig7_12$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],set4= fig7_12[grep("For-profit", fig7_12$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")], set5= fig7_12[grep("Public two-year", fig7_12$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],
                   series = c("Public four-year in-state", "Public four-year out-of-state", "Private nonprofit four-year", "For-profit", "Public two-year"),
                   categories = fig7_12$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 7-13
fig7_13<- read.csv(paste(textpath, "Personas/07_0090.csv", sep=""),stringsAsFactors=FALSE)
json7_13<- makeJson(sectionn = 7, graphn = 13, dt = fig7_13$percent, graphtype = "bar", series= "Enrollment",
                   categories = fig7_13$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 7-15 
#1) change 0 to "NA" with regex
#[0]{1}[,]  --> replace with "NA",
#[0]{1}\n  --> replace with "NA"\n

#2) edit groups array
#"groups": [
#[
#"Private loans", 
#"Institutional grant aid", 
#"Tuition and fees", 
#"State grant aid",
#"Federal grant aid", 
#"Budget beyond tuition and fees", 
#"Expected family contribution", 
#"Military and veterans grant aid", 
#"Private and employer grant aid", 
#"Federal parent loans", 
#"Federal student loans", 
#"Earnings and other resources"
#]
#],

#3) add colors array
#"colors": {
#"Expected family contribution": "#848081",
#"Federal grant aid": "#cfe8f3",
#"Military and veterans grant aid": "#a2d4ec",
#"State grant aid": "#73bfe2",
#"Institutional grant aid":"#1696d2",
#"Private and employer grant aid": "#1696d2",
#"Federal student loans": "#fccb41",
#"Federal parent loans": "#fdbf11",
#"Private loans": "#fce39e",
#"Earnings and other resources": "#d5d5d4",
#"Tuition and fees": "#ec008b",
#"Budget beyond tuition and fees": "#000000"
#},
fig7_15<- read.csv(paste(textpath, "Personas/07_0150-ALL.csv", sep=""),stringsAsFactors=FALSE, check.names= FALSE)

json7_15<- makeJson(sectionn = 7, graphn = 15, dt = fig7_15, graphtype = "bar", set1= fig7_15[grep("Public four-year in-state", fig7_15$category), c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")], set2= fig7_15[grep("Public four-year out-of-state", fig7_15$category),  c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")],
                    set3= fig7_15[grep("Private nonprofit four-year", fig7_15$category),  c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")], set4= fig7_15[grep("For-profit", fig7_15$category), c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")],
                    set5= fig7_15[grep("Public two-year", fig7_15$category),  c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Earnings and other resources", "Tuition and fees", "Budget beyond tuition and fees")],
                    series = c("Public four-year in-state","Public four-year out-of-state","Private nonprofit four-year","For-profit", "Public two-year"),
                    categories = fig7_15$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 7-16
#had to manually set order of years for each toggle category so that years are ascending
fig7_16<- read.csv(paste(textpath, "Personas/07_0160-ALL.csv", sep=""),stringsAsFactors=FALSE, check.names=FALSE)
json7_16<- makeJson(sectionn = 7, graphn = 16, dt = fig7_16, graphtype = "bar", set1= fig7_16[grep("Public four-year in-state", fig7_16$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")], set2= fig7_16[grep("Public four-year out-of-state", fig7_16$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],
                    set3= fig7_16[grep("Private nonprofit four-year", fig7_16$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],set4= fig7_16[grep("For-profit", fig7_16$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")], set5= fig7_16[grep("Public two-year", fig7_16$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],
                    series = c("Public four-year in-state", "Public four-year out-of-state", "Private nonprofit four-year", "For-profit", "Public two-year"),
                    categories = fig7_16$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 7-17
fig7_17<- read.csv(paste(textpath, "Personas/07_0170.csv", sep=""),stringsAsFactors=FALSE)
json7_17<- makeJson(sectionn = 7, graphn = 17, dt = fig7_17$percent, graphtype = "bar", series= "Enrollment",
                    categories = fig7_17$category, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 7-19 
#1) change 0 to "NA" with regex
#[0]{1}[,]  --> replace with "NA",\n
#[0]{1}\n  --> replace with "NA"

#2) edit groups array
#"groups": [
#[
#"Private loans", 
#"Institutional grant aid", 
#"Tuition and fees", 
#"State grant aid",
#"Federal grant aid", 
#"Budget beyond tuition and fees", 
#"Expected family contribution", 
#"Military and veterans grant aid", 
#"Private and employer grant aid", 
#"Federal parent loans", 
#"Federal student loans", 
#"Earnings and other resources"
#]
#],

#3) add colors array
#"colors": {
#"Expected family contribution": "#848081",
#"Federal grant aid": "#cfe8f3",
#"Military and veterans grant aid": "#a2d4ec",
#"State grant aid": "#73bfe2",
#"Institutional grant aid":"#1696d2",
#"Private and employer grant aid": "#1696d2",
#"Federal student loans": "#fccb41",
#"Federal parent loans": "#fdbf11",
#"Private loans": "#fce39e",
#"Earnings and other resources": "#d5d5d4",
#"Tuition and fees": "#ec008b",
#"Budget beyond tuition and fees": "#000000"
#},
fig7_19<- read.csv(paste(textpath, "Personas/07_0190-ALL.csv", sep=""),stringsAsFactors=FALSE, check.names= FALSE)
json7_19<- makeJson(sectionn = 7, graphn = 19, dt = fig7_19, graphtype = "bar", set1= fig7_19[grep("Public four-year in-state", fig7_19$category), c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Tuition and fees", "Budget beyond tuition and fees")], set2= fig7_19[grep("Public four-year out-of-state", fig7_19$category),  c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans","Tuition and fees", "Budget beyond tuition and fees")],
                    set3= fig7_19[grep("Private nonprofit four-year", fig7_19$category),  c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Tuition and fees", "Budget beyond tuition and fees")], set4= fig7_19[grep("For-profit", fig7_19$category), c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Tuition and fees", "Budget beyond tuition and fees")],
                    set5= fig7_19[grep("Public two-year", fig7_19$category),  c("Expected family contribution", "Federal grant aid", "Military and veterans grant aid", "State grant aid", "Institutional grant aid", "Private and employer grant aid", "Federal student loans", "Federal parent loans", "Private loans", "Tuition and fees", "Budget beyond tuition and fees")],
                    series = c("Public four-year in-state","Public four-year out-of-state","Private nonprofit four-year","For-profit", "Public two-year"),
                    categories = fig7_19$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 7-20
#had to manually set order of years for each toggle category so that years are ascending
fig7_20<- read.csv(paste(textpath, "Personas/07_0200-ALL.csv", sep=""),stringsAsFactors=FALSE, check.names=FALSE)
json7_20<- makeJson(sectionn = 7, graphn = 20, dt = fig7_20, graphtype = "bar", set1= fig7_20[grep("Public four-year in-state", fig7_20$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")], set2= fig7_20[grep("Public four-year out-of-state", fig7_20$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],
                    set3= fig7_20[grep("Private nonprofit four-year", fig7_20$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")],set4= fig7_20[grep("Public two-year", fig7_20$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")], set5= fig7_20[grep("For-profit", fig7_20$category), c("1 year", "2 years", "3 years", "4 years", "5 years", "6 years")], 
                    series = c("Public four-year in-state", "Public four-year out-of-state", "Private nonprofit four-year", "Public two-year"),
                    categories = fig7_20$category_label, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

