
library(dplyr)
library(tidyr)
library(jsonlite)
library(openxlsx)


source('~/Documents/Urban/ed-data/scripts/createJsons.R')
#source('~/Projects/ed-data/scripts/createJsons.R')

# Path to Excel file with graph metadata - change to your file path

#textpath <- "/Users/vivhou/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) Project/**Production/"
textpath <- "/Users/vhou/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) Project/**Production/"
#textpath <- "/Users/bchartof/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) Project/**Production/"
graphtext <- readWorkbook(paste(textpath, "GraphText.xlsx", sep=""),sheet = 1)
graphtext$section_number <- as.numeric(graphtext$section_number)
graphtext$multiples <- as.numeric(graphtext$multiples)
graphtext$toggle <- as.numeric(graphtext$toggle)

#Figure 4-1
fig4_1 <- read.csv(paste(textpath, "Financial aid_financial need/04_00100.csv", sep=""),stringsAsFactors=FALSE)
json4_1 <- makeJson(sectionn = 4, graphn = 1, dt = fig4_1$MedianEFCbyParentsIncome, graphtype = "bar", series="Median EFC",
                    xlabel="Income", ylabel="EFC",categories = fig4_1$IncomeRange, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)

#Figure 4-2
# add `"padding": {"bottom": 60}` to outermost tick
fig4_2 <- read.csv(paste(textpath, "Financial aid_financial need/04_0020.csv", sep=""),stringsAsFactors=FALSE)
json4_2 <- makeJson(sectionn = 4, graphn = 2, dt = fig4_2, graphtype = "bar", series= c("Independent, no dependents, single", "Independent, no dependents, married",	"Independent with dependents"),
                    xlabel="Income", ylabel="EFC", categories = fig4_2$category, tickformat = "$.2s", rotated = TRUE, directlabels = TRUE)

#Figure 4-3
fig4_3 <- read.csv(paste(textpath, "Financial aid_financial need/04_0030.csv", sep=""),stringsAsFactors=FALSE)
json4_3 <- makeJson(sectionn = 4, graphn = 3, dt = fig4_3$Percent0EFC, graphtype = "bar", series="Undergraduate Student Percentage",
                    categories = fig4_3$DependencyStatus, tickformat = "percent", rotated = FALSE, directlabels = TRUE)


#Figure 4-4
fig4_4 <- read.csv(paste(textpath, "Financial aid_financial need/04_0040.csv", sep=""),stringsAsFactors=FALSE)
json4_4 <- makeJson(sectionn = 4, graphn = 4, dt = fig4_4, graphtype = "bar",
                    series = c("$0", "$1–$4,999", "$5,000–$9,999", "$10,000–$14,999", "$15,000 or higher"),
                    categories = fig4_4$column, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 4-4
fig4_4a <- read.csv(paste(textpath, "Financial aid_financial need/04_0041.csv", sep=""),stringsAsFactors=FALSE)
fig4_4b <- read.csv(paste(textpath, "Financial aid_financial need/04_0042.csv", sep=""),stringsAsFactors=FALSE)
fig4_4c <- read.csv(paste(textpath, "Financial aid_financial need/04_0043.csv", sep=""),stringsAsFactors=FALSE)
fig4_4d <- read.csv(paste(textpath, "Financial aid_financial need/04_0044.csv", sep=""),stringsAsFactors=FALSE)
fig4_4e <- read.csv(paste(textpath, "Financial aid_financial need/04_0045.csv", sep=""),stringsAsFactors=FALSE)


json4_4a <- makeJson(sectionn = 4, graphn = 4, subn= 1, dt = fig4_4a, graphtype = "bar",
                     series = c("$0", "$1–$4,999", "$5,000–$9,999", "$10,000–$14,999", "$15,000 or higher"),
                     categories = fig4_4a$column, tickformat = "percent", rotated = TRUE, directlabels = TRUE, graphtitle="Total")
json4_4b <- makeJson(sectionn = 4, graphn = 4, subn= 2, dt = fig4_4b, graphtype = "bar",
                     series = c("$0", "$1–$4,999", "$5,000–$9,999", "$10,000–$14,999", "$15,000 or higher"),
                     categories = fig4_4b$column, tickformat = "percent", rotated = TRUE, directlabels = TRUE, graphtitle="Public four-year")
json4_4c <- makeJson(sectionn = 4, graphn = 4, subn= 3, dt = fig4_4c, graphtype = "bar",
                     series = c("$0", "$1–$4,999", "$5,000–$9,999", "$10,000–$14,999", "$15,000 or higher"),
                     categories = fig4_4c$column, tickformat = "percent", rotated = TRUE, directlabels = TRUE, graphtitle="Private four-year")
json4_4d <- makeJson(sectionn = 4, graphn = 4, subn= 4, dt = fig4_4d, graphtype = "bar",
                     series = c("$0", "$1–$4,999", "$5,000–$9,999", "$10,000–$14,999", "$15,000 or higher"),
                     categories = fig4_4d$column, tickformat = "percent", rotated = TRUE, directlabels = TRUE, graphtitle="Public two-year")
json4_4e <- makeJson(sectionn = 4, graphn = 4, subn= 5, dt = fig4_4e, graphtype = "bar",
                     series = c("$0", "$1–$4,999", "$5,000–$9,999", "$10,000–$14,999", "$15,000 or higher"),
                     categories = fig4_4e$column, tickformat = "percent", rotated = TRUE, directlabels = TRUE, graphtitle="For-profit")



#Figure 4-5
fig4_5 <- read.csv(paste(textpath, "Financial aid_grant aid/CSVs/04_0050.csv", sep=""),stringsAsFactors=FALSE)
json4_5 <- makeJson(sectionn = 4, graphn = 5, dt = fig4_5$grant, graphtype = "bar", series="Grant aid",
                    ylabel = "Grant aid in billions", categories = fig4_5$category, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)


#Figure 4-6
fig4_6 <- read.csv(paste(textpath, "Financial aid_grant aid/CSVs/04_0060.csv", sep=""),stringsAsFactors=FALSE)
json4_6 <- makeJson(sectionn = 4, graphn = 6, dt = fig4_6, graphtype = "bar",
                    series = c("Federal (Nonmilitary)","Veterans/Department of Defense","State","Institutional","Private and Employer"),
                    categories = fig4_6$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)


#Figure 4-7
#set max y value and ticks
#"y": {
#  "padding": {"top": 0, "bottom": 0},
#  "max": 20000,
#  "tick": {
#    "format": "dollar",
#    "count": 5
#  }
#}
#insert space to x-values after Indepedent or Dependent so that x-values are two lines total

fig4_7a <- read.csv(paste(textpath, "Financial aid_grant aid/CSVs/040071.csv", sep=""),stringsAsFactors=FALSE)
fig4_7b <- read.csv(paste(textpath, "Financial aid_grant aid/CSVs/040072.csv", sep=""),stringsAsFactors=FALSE)


json4_7a <- makeJson(sectionn = 4, graphn = 7, subn= 1, dt = fig4_7a, graphtype = "bar",
                    series = c("Federal Grants", "Veterans' and Military", "State Grants", "Institutional Grants", "Employer or Private Grants"),
                    xlabel="Independent", categories = fig4_7a$column, graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)
json4_7b <- makeJson(sectionn = 4, graphn = 7, subn=2, dt = fig4_7b, graphtype = "bar",
                    series = c("Federal Grants", "Veterans' and Military", "State Grants", "Institutional Grants", "Employer or Private Grants"),
                    xlabel="Dependent", categories = fig4_7b$column, graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)

#Figure 4-8 
#had to manually change the ordering of the sets and had to replace "groups" aray with     
#"groups": [
#[
#"Federal",
#"State",
#"Veterans",
#"Institutional",
#"Private"
#]

#fig4_8 <- read.csv(paste(textpath, "Financial aid_grant aid/CSVs/04_0080.csv", sep=""),stringsAsFactors=FALSE)
#json4_8<- makeJson(sectionn = 4, graphn = 8, dt = fig4_8, graphtype = "bar", set1= fig4_8[grep("Less than \\$30,00", fig4_8$category), c("Federal", "Veterans", "State", "Institutional", "Private")], set2= fig4_8[grep("\\$30,000\\:\\$64,999", fig4_8$category),c("Federal", "Veterans", "State", "Institutional", "Private")],
#                    set3= fig4_8[grep("\\$65,000\\:\\$105,999", fig4_8$category),c("Federal", "Veterans", "State", "Institutional", "Private")], set4= fig4_8[grep("\\$106,000\\:\\$154,999", fig4_8$category),c("Federal", "Veterans", "State", "Institutional", "Private")],
#                    set5=fig4_8[grep("\\$155,000", fig4_8$category),c("Federal", "Veterans", "State", "Institutional", "Private")],
#                    series = c("Less than $30,000", "$30,000–$64,999", "$65,000–$105,999","$106,000–$154,999", "$155,000 or higher"),
#                    categories = fig4_8$category_labels, tickformat = "$s", rotated = TRUE, directlabels = TRUE)

#Figure 4-9

fig4_9a <- read.csv(paste(textpath, "Financial aid_federal/04_00901.csv", sep=""),stringsAsFactors=FALSE)
fig4_9b <- read.csv(paste(textpath, "Financial aid_federal/04_00902.csv", sep=""),stringsAsFactors=FALSE)
fig4_9c <- read.csv(paste(textpath, "Financial aid_federal/04_00903.csv", sep=""),stringsAsFactors=FALSE)

#FIRST SET
#1) for graph 1, add bracket to single category "All..."
#2)for graph 2, add spaces to x-labels to create two lines, for example: "Less than         $30,000" "$30,000 –       $64,999"
#3) for graphs 1-3, change number of ticks
#"y": {
#  "max": 8000,
#  "padding": {"top": 0, "bottom": 0},
#  "tick": {
#    "format": "$s",
#    "count": 5
#  }
#},
#4)for graphs 1-3, added top level attribute `"wideSmallMultiple": true`
json4_91a <- makeJson(sectionn = 4, graphn = 91, subn= 3, dt = fig4_9a$grant_per_recip, graphtype = "bar",
                     series = "Pell-Grant",
                     categories = fig4_9a$dependency_income, tickformat = "$s", rotated = TRUE, directlabels = TRUE, graphtitle="Dependency status")
json4_92b <- makeJson(sectionn = 4, graphn = 91, subn= 2, dt = fig4_9b$grant_per_recip, graphtype = "bar",
                     series = "Pell-Grant",
                     categories = fig4_9b$dependency_income, tickformat = "$s", rotated = TRUE, directlabels = TRUE, graphtitle="Dependent students' family income")
json4_93c <- makeJson(sectionn = 4, graphn = 91, subn= 1, dt = fig4_9c$grant_per_recip, graphtype = "bar",
                     series = "Pell-Grant",
                     categories = fig4_9c$dependency_income, tickformat = "$s", rotated = TRUE, directlabels = TRUE, graphtitle="All")
#SECOND SET
#5) for graph 1, add bracket to single category "All..."
#6) for graph 2, add spaces to x-labels to create two lines, for example: "Less than         $30,000" "$30,000 –       $64,999"

#7) for graphs 1-3, change number of ticks
"y": {
  "max": 6000,
  "padding": {"top": 0, "bottom": 0},
  "tick": {
    "format": "$s",
    "count": 4
  }
},
#8)for graphs 1-3, added top level attribute `"wideSmallMultiple": true`
json4_92a <- makeJson(sectionn = 4, graphn = 92, subn= 3, dt = fig4_9a$pell_per_student, graphtype = "bar",
                     series = "Pell-Grant",
                     categories = fig4_9a$dependency_income, tickformat = "$s", rotated = TRUE, directlabels = TRUE, graphtitle="Dependency status")
json4_92b <- makeJson(sectionn = 4, graphn = 92, subn= 2, dt = fig4_9b$pell_per_student, graphtype = "bar",
                      series = "Pell-Grant",
                      categories = fig4_9b$dependency_income, tickformat = "$s", rotated = TRUE, directlabels = TRUE, graphtitle="Dependent students' family income")
json4_92c <- makeJson(sectionn = 4, graphn = 92, subn= 1, dt = fig4_9c$pell_per_student, graphtype = "bar",
                      series = "Pell-Grant",
                      categories = fig4_9c$dependency_income, tickformat = "$s", rotated = TRUE, directlabels = TRUE, graphtitle="All")


#Figure 4-10
fig4_10 <- read.csv(paste(textpath, "Financial aid_federal/04_0100.csv", sep=""),stringsAsFactors=FALSE)
fig4_10$year <- gsub("&ndash", "–", fig4_10$year) 
fig4_10
json4_10 <- makeJson(sectionn = 4, graphn = 10, dt = fig4_10, graphtype = "line", series=c("Maximum Pell (2015 dollars)", "Average Pell (2015 dollars)"),
                    categories = fig4_10$year, tickformat = "$.2s", rotated = FALSE, directlabels = TRUE)

#Figure 4-11
fig4_11 <- read.csv(paste(textpath, "Financial aid_federal/04_0110.csv", sep=""),stringsAsFactors=FALSE)
fig4_11$year <- gsub("\x96", "–", fig4_11$year) 
fig4_11
json4_11 <- makeJson(sectionn = 4, graphn = 11, dt = fig4_11$recipients, graphtype = "bar", series="Amount",
                    categories = fig4_11$year, tickformat = "number", rotated = FALSE, directlabels = TRUE)

#Figure 4-12
fig4_12 <- read.csv(paste(textpath, "Financial aid_federal/04_0120.csv", sep=""),stringsAsFactors=FALSE)
fig4_12$year <- gsub("-", "–", fig4_12$year) 
json4_12 <- makeJson(sectionn = 4, graphn = 12, dt = fig4_12, graphtype = "line", series=c("Pell per FTE undergraduate", "Military and veterans aid per FTE undergraduate"),
                     categories = fig4_12$Year, tickformat = "$.2s", rotated = FALSE, directlabels = TRUE)

#Figure 4-13
# add "highlightIndex" : 18 to outermost bracket
fig4_13 <- read.csv(paste(textpath, "Financial aid_state/04_0130.csv", sep=""),stringsAsFactors=FALSE)
json4_13 <- makeJson(sectionn = 4, graphn = 13, dt = fig4_13$GrantAid, graphtype = "bar", series="State grant aid per FTE undergraduate",
                    categories = fig4_13$state, tickformat = "$.2s", rotated = TRUE, directlabels = TRUE)

#Figure 4-14
#add highlightIndex": 20 to outermost bracket
fig4_14 <- read.csv(paste(textpath, "Financial aid_state/04_0140.csv", sep=""),stringsAsFactors=FALSE)
json4_14 <- makeJson(sectionn = 4, graphn = 14, dt = fig4_14$stategrants, graphtype = "bar", series="Percentage of state grants",
                     categories = fig4_14$state, tickformat = "percent", rotated = TRUE, directlabels = TRUE)


#Figure 4-15
# 1) set max y-value and ticks
#"y": {
#  "max": 0.4,
#  "padding": {"top": 0, "bottom": 0},
#  "tick": {
#    "format": "percent",
#    "count": 3
#  }
#},

# 2) add spacing to x-values so two lines, for example: "Public             two-year"
fig4_15a <- read.csv(paste(textpath, "Financial aid_state/04_0151.csv", sep=""),stringsAsFactors=FALSE)
fig4_15b <- read.csv(paste(textpath, "Financial aid_state/04_0152.csv", sep=""),stringsAsFactors=FALSE)
fig4_15c <- read.csv(paste(textpath, "Financial aid_state/04_0153.csv", sep=""),stringsAsFactors=FALSE)
fig4_15d <- read.csv(paste(textpath, "Financial aid_state/04_0154.csv", sep=""),stringsAsFactors=FALSE)
fig4_15e <- read.csv(paste(textpath, "Financial aid_state/04_0155.csv", sep=""),stringsAsFactors=FALSE)

json4_15a <- makeJson(sectionn = 4, graphn = 15, subn= 1, dt = fig4_15a$percent, graphtype = "bar",
                     series = "Undergraduates receiving state aid",
                     categories = fig4_15a$sub_category,  xlabel = "All", graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels = TRUE)
json4_15b <- makeJson(sectionn = 4, graphn = 15, subn=2, dt = fig4_15b$percent, graphtype = "bar",
                     series = "Undergraduates receiving state aid",
                     categories = fig4_15b$sub_category, xlabel = "Dependency Status", graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels = TRUE)
json4_15c <- makeJson(sectionn = 4, graphn = 15, subn=3, dt = fig4_15c$percent, graphtype = "bar",
                      series = "Undergraduates receiving state aid",
                      categories = fig4_15c$sub_category, xlabel = "Dependent Students' Family Income", graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels = TRUE)
json4_15d <- makeJson(sectionn = 4, graphn = 15, subn=4, dt = fig4_15d$percent, graphtype = "bar",
                      series = "Undergraduates receiving state aid",
                      categories = fig4_15d$sub_category, xlabel = "Residency", graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels = TRUE)
json4_15e <- makeJson(sectionn = 4, graphn = 15, subn=5, dt = fig4_15e$percent, graphtype = "bar",
                      series = "Undergraduates receiving state aid",
                      categories = fig4_15e$sub_category, xlabel = "Sector", graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 4-16

# 1) add space for x-axis labels in graphs 3 and 5 to make two lines, for example:
# "Public        two-year"   "$106,000           or more"

# 2) set max y-value and number of ticks
#"y": {
#  "max": 6000,
#  "padding": {"top": 0, "bottom": 0},
#  "tick": {
#    "format": "$s",
#    "count": 4
#  }
#}
fig4_16a <- read.csv(paste(textpath, "Financial aid_state/04_0161.csv", sep=""),stringsAsFactors=FALSE)
fig4_16b <- read.csv(paste(textpath, "Financial aid_state/04_0162.csv", sep=""),stringsAsFactors=FALSE)
fig4_16c <- read.csv(paste(textpath, "Financial aid_state/04_0163.csv", sep=""),stringsAsFactors=FALSE)
fig4_16d <- read.csv(paste(textpath, "Financial aid_state/04_0164.csv", sep=""),stringsAsFactors=FALSE)
fig4_16e <- read.csv(paste(textpath, "Financial aid_state/04_0165.csv", sep=""),stringsAsFactors=FALSE)

json4_16a <- makeJson(sectionn = 4, graphn = 16, subn= 1, dt = fig4_16a$grant, graphtype = "bar",
                      series = "Average state grant aid per recipient",
                      categories = fig4_16a$sub_category,  xlabel = "All",graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)
json4_16b <- makeJson(sectionn = 4, graphn = 16, subn=2, dt = fig4_16b$grant, graphtype = "bar",
                      series = "Average state grant aid per recipient",
                      categories = fig4_16b$sub_category, xlabel = "Dependency Status", graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)
json4_16c <- makeJson(sectionn = 4, graphn = 16, subn=3, dt = fig4_16c$grant, graphtype = "bar",
                      series = "Average state grant aid per recipient",
                      categories = fig4_16c$sub_category, xlabel = "Dependent Students' Family Income", graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)
json4_16d <- makeJson(sectionn = 4, graphn = 16, subn=4, dt = fig4_16d$grant, graphtype = "bar",
                      series = "Average state grant aid per recipient",
                      categories = fig4_16d$sub_category, xlabel = "Residency", graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)
json4_16e <- makeJson(sectionn = 4, graphn = 16, subn=5, dt = fig4_16e$grant, graphtype = "bar",
                      series = "Average state grant aid per recipient",
                      categories = fig4_16e$sub_category, xlabel = "Sector", graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels = TRUE)

#Figure 4-17
fig4_17 <- read.csv(paste(textpath, "Financial aid_state/04_0170-no_percent.csv", sep=""),stringsAsFactors=FALSE)
fig4_17$year <- gsub("-", "–", fig4_17$year) 
json4_17 <- makeJson(sectionn = 4, graphn = 17, dt = fig4_17, graphtype = "area",
                    series = c("Need-based", "Non need-based"),
                    categories = fig4_17$year, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 4-18
fig4_18 <- read.csv(paste(textpath, "Financial aid_institutional/04_0180.csv", sep=""),stringsAsFactors=FALSE)
json4_18 <- makeJson(sectionn = 4, graphn = 18, dt = fig4_18$percent, graphtype = "bar", series="Percentage receiving institutional grant aid", xlabel="Institution type",
                     categories = fig4_18$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)


#Figure 4-19: had to manually change groups array to:
#  "groups": [
#    [
#      "Institutional grant aid per full-time student", 
#      "Remaining (net) tuition and fees per full-time student",
#      "Institutional grant aid per recipient", 
#      "Remaining (net) tuition and fees per recipient"
#      ]
#    ]
fig4_19 <- read.csv(paste(textpath, "Financial aid_institutional/04_0190-revised.csv", sep=""),stringsAsFactors=FALSE, check.names = FALSE)
json4_19 <- makeJson(sectionn = 4, graphn = 19, dt = fig4_19, graphtype = "bar", series=c("Per first-time full-time student", "Per recipient"), set1=fig4_19[,c("Institutional grant aid per full-time student", "Remaining (net) tuition and fees per full-time student")], set2=fig4_19[,c("Institutional grant aid per recipient", "Remaining (net) tuition and fees per recipient")],
                     categories = fig4_19$category, tickformat = "$s", rotated = TRUE, directlabels = TRUE)
  
  

#Figure 4-20 : 
#1) had to manually change group array to: "groups": ["Need-based", "Non-need-based"]
#  2) had to manually change order of sets

#fig4_20 <- read.csv(paste(textpath, "Financial aid_institutional/04_0200-ALL.csv", sep=""),stringsAsFactors=FALSE, check.names = FALSE)
#json4_20<- makeJson(sectionn = 4, graphn = 20, dt = fig4_20, graphtype = "bar", set1= fig4_20[grep("Lowest", fig4_20$category), c("Need-based", "Non-need-based")], set2= fig4_20[grep("Second", fig4_20$category), c("Need-based", "Non-need-based")],
#                    set3= fig4_20[grep("Third", fig4_20$category), c("Need-based", "Non-need-based")],set4= fig4_20[grep("Highest", fig4_20$category), c("Need-based", "Non-need-based")],
#                   series = c("Lowest tuition group", "Second tuition group", "Third tuition group", "Highest tuition group"),
#                   categories = fig4_20$category_label, tickformat = "$s", rotated = TRUE, directlabels = TRUE)

#Figure 4-21
#1)add brackets to single x-categories in 4-211 and 4-212
#2)change y tick values
#"y": {
#  "padding": {"top": 0, "bottom": 0},
#  "max": 1800,
#  "tick": {
#    "format": "dollar",
#    "count": 3
#  }
#3) make x label two lines, in first two graphs of multiple, in order to widen the graph

fig4_21a <- read.csv(paste(textpath, "Financial aid_institutional/04_0211.csv", sep=""),stringsAsFactors=FALSE, check.names = FALSE)
fig4_21b <- read.csv(paste(textpath, "Financial aid_institutional/04_0212.csv", sep=""),stringsAsFactors=FALSE, check.names = FALSE)
fig4_21c <- read.csv(paste(textpath, "Financial aid_institutional/04_0213.csv", sep=""),stringsAsFactors=FALSE, check.names = FALSE)

#add brackets to single x category
json4_21a<- makeJson(sectionn = 4, graphn = 21, subn= 1, dt = fig4_21a, graphtype = "bar", series = c("Institutional need-based", "Institutional non-need-based"),
                     categories = fig4_21a$category,  xlabel = "All dependent students", graphtitle=NULL, tickformat = "$s", rotated = TRUE, directlabels = TRUE)
#add brackets to single x category
json4_21b<- makeJson(sectionn = 4, graphn = 21, subn= 2, dt = fig4_21b, graphtype = "bar", series = c("Institutional need-based", "Institutional non-need-based"),
                     categories = fig4_21b$category,  xlabel = "Independent students", graphtitle=NULL, tickformat = "$s", rotated = TRUE, directlabels = TRUE)
json4_21c<- makeJson(sectionn = 4, graphn = 21, subn= 3, dt = fig4_21c, graphtype = "bar", series = c("Institutional need-based", "Institutional non-need-based"),
                     categories = fig4_21c$category,  xlabel = "Dependent students' family income quartile", graphtitle=NULL, tickformat = "$s", rotated = TRUE, directlabels = TRUE)

#Figure 4-22
fig4_22a <- read.csv(paste(textpath, "Financial aid_other/04_022a.csv", sep=""),stringsAsFactors=FALSE)
fig4_22b <- read.csv(paste(textpath, "Financial aid_other/04_022b.csv", sep=""),stringsAsFactors=FALSE)
fig4_22c <- read.csv(paste(textpath, "Financial aid_other/04_022c.csv", sep=""),stringsAsFactors=FALSE)
fig4_22d <- read.csv(paste(textpath, "Financial aid_other/04_022d.csv", sep=""),stringsAsFactors=FALSE)
fig4_22d$sub_category <- gsub("-", "–", fig4_22d$sub_category) 

#for first set of multiples:
# 1) set y max value and ticks
#    "y": {
#  "padding": {"top":0, "bottom":0},
#  "max": 0.15,
#  "tick": {
#    "count": 4,
#    "format": "percent"
#  }
#}

# 2) adding spacing to x values in third and fourth graphs to create two lines , for example: 
#"Public          four-year"         "Less than           $30,000"

#3) add brackets to single category in first graph

json4_22a <- makeJson(sectionn = 4, graphn = 221, subn= 1, dt = fig4_22a$percent_employer, graphtype = "bar", series="Employer aid", categories = fig4_22a$sub_category, 
                      xlabel= "Total", graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels=TRUE)
json4_22b <- makeJson(sectionn = 4, graphn = 221, subn= 2,  dt = fig4_22b$percent_employer, graphtype = "bar", series="Employer aid", categories = fig4_22b$sub_category, 
                      xlabel = "Dependency Status", graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels=TRUE)
json4_22c <- makeJson(sectionn = 4, graphn = 221,  subn= 3, dt = fig4_22c$percent_employer, graphtype = "bar", series="Employer aid", categories = fig4_22c$sub_category, 
                      xlabel = "Sector", graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels=TRUE)
json4_22d <- makeJson(sectionn = 4, graphn = 221, subn= 4, dt = fig4_22d$percent_employer, graphtype = "bar", series="Employer aid", categories = fig4_22d$sub_category, 
                      xlabel = "Dependent students' parents' income", graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels=TRUE)

fig4_221a <- read.csv(paste(textpath, "Financial aid_other/04_0221a.csv", sep=""),stringsAsFactors=FALSE)
fig4_221b <- read.csv(paste(textpath, "Financial aid_other/04_0221b.csv", sep=""),stringsAsFactors=FALSE)
fig4_221c <- read.csv(paste(textpath, "Financial aid_other/04_0221c.csv", sep=""),stringsAsFactors=FALSE)
fig4_221d <- read.csv(paste(textpath, "Financial aid_other/04_0221d.csv", sep=""),stringsAsFactors=FALSE)
fig4_221d$sub_category <- gsub("-", "–", fig4_221d$sub_category) 

#for second set of multiples:
# 1) set y max value and ticks
#"y": {
#  "padding": {
#    "top": 0, "bottom": 0
#  },
#  "max": 0.3,
#  "tick": {
#    "format": "percent",
#    "count": 4
#  }
#},

# 2) adding spacing to x values in third and fourth graphs to create two lines , for example: 
#"Public          four-year"         "Less than           $30,000"

#3) add brackets to single category in first graph

json4_221a <- makeJson(sectionn = 4, graphn = 222, subn=1, dt = fig4_221a$percent_private, graphtype = "bar", series="Private Grants", categories = fig4_221a$sub_category, 
                      graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels=TRUE)
json4_221b <- makeJson(sectionn = 4, graphn = 222, subn= 2,  dt = fig4_221b$percent_private, graphtype = "bar",series="Private Grants", categories = fig4_221b$sub_category, 
                      xlabel = "Dependency Status", graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels=TRUE)
json4_221c <- makeJson(sectionn = 4, graphn = 222,  subn= 3, dt = fig4_221c$percent_private, graphtype = "bar", series="Private Grants", categories = fig4_221c$sub_category, 
                      xlabel = "Sector", graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels=TRUE)
json4_221d <- makeJson(sectionn = 4, graphn = 222, subn= 4, dt = fig4_221d$percent_private, graphtype = "bar", series="Private Grants", categories = fig4_221d$sub_category, 
                      xlabel = "Dependent students' parents' income", graphtitle=NULL, tickformat = "percent", rotated = TRUE, directlabels=TRUE)



#Figure 4-23
fig4_23a <- read.csv(paste(textpath, "Financial aid_other/04_023a.csv", sep=""),stringsAsFactors=FALSE)
fig4_23b <- read.csv(paste(textpath, "Financial aid_other/04_023b.csv", sep=""),stringsAsFactors=FALSE)
fig4_23c <- read.csv(paste(textpath, "Financial aid_other/04_023c.csv", sep=""),stringsAsFactors=FALSE)
fig4_23d <- read.csv(paste(textpath, "Financial aid_other/04_023d.csv", sep=""),stringsAsFactors=FALSE)
fig4_23d$sub_category <- gsub("-", "–", fig4_23d$sub_category) 

#for first set of multiples:
# 1) set y max value and ticks
#"y": {
#  "padding": {"top": 0, "bottom":0},
#  "max": 15000,
#  "tick": {
#    "format": "dollar",
#    "count": 4
#  }
#}
# 2) adding spacing to x values in third and fourth graphs to create two lines , for example: 
"Public          four-year"         "Less than           $30,000"

#3) add brackets to single category in first graph

json4_23a <- makeJson(sectionn = 4, graphn = 231, subn= 1, dt = fig4_23a$average_employer_aid, graphtype = "bar", series="Employer aid", categories = fig4_23a$sub_category, 
                       graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels=TRUE)
json4_23b <- makeJson(sectionn = 4, graphn = 231, subn= 2, dt = fig4_23b$average_employer_aid, graphtype = "bar", series="Employer aid", categories = fig4_23b$sub_category, 
                      xlabel = "Dependency Status", graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels=TRUE)
json4_23c <- makeJson(sectionn = 4, graphn = 231, subn= 3, dt = fig4_23c$average_employer_aid, graphtype = "bar", series="Employer aid", categories = fig4_23c$sub_category, 
                      xlabel = "Sector", graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels=TRUE)
json4_23d <- makeJson(sectionn = 4, graphn = 231, subn= 4, dt = fig4_23c$average_employer_aid, graphtype = "bar", series="Employer aid", categories = fig4_23c$sub_category, 
                      xlabel = "Dependent students' parents' income", graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels=TRUE)

#for second set of multiples:
# 1) set y max value and ticks
#"y": {
#  "padding": {"top": 0, "bottom": 0},
#  "max": 10000,
#  "tick": {
#    "format": "dollar",
#    "count": 3
#  }
#},
# 2) adding spacing to x values in third and fourth graphs to create two lines , for example: 
#"Public          four-year"         "Less than           $30,000"

#3) add brackets to single category in first graph

fig4_231a <- read.csv(paste(textpath, "Financial aid_other/04_0231a.csv", sep=""),stringsAsFactors=FALSE)
fig4_231b <- read.csv(paste(textpath, "Financial aid_other/04_0231b.csv", sep=""),stringsAsFactors=FALSE)
fig4_231c <- read.csv(paste(textpath, "Financial aid_other/04_0231c.csv", sep=""),stringsAsFactors=FALSE)
fig4_231d <- read.csv(paste(textpath, "Financial aid_other/04_0231d.csv", sep=""),stringsAsFactors=FALSE)

json4_231a <- makeJson(sectionn = 4, graphn = 232, subn= 1, dt = fig4_231a$average_private_grants, graphtype = "bar", series="Private Grants", categories = fig4_231a$sub_category, 
                      graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels=TRUE)
json4_231b <- makeJson(sectionn = 4, graphn = 232, subn= 2, dt = fig4_231b$average_private_grants, graphtype = "bar", series="Private Grants", categories = fig4_231b$sub_category, 
                       xlabel = "Dependency Status", graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels=TRUE)
json4_231c <- makeJson(sectionn = 4, graphn = 232, subn= 3, dt = fig4_231c$average_private_grants, graphtype = "bar", series="Private Grants", categories = fig4_231c$sub_category, 
                       xlabel = "Sector", graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels=TRUE)
json4_231d <- makeJson(sectionn = 4, graphn = 232, subn= 4, dt = fig4_231d$average_private_grants, graphtype = "bar", series="Private Grants", categories = fig4_231d$sub_category, 
                       xlabel = "Dependent students' parents' income", graphtitle=NULL, tickformat = "dollar", rotated = TRUE, directlabels=TRUE)

#Figure 4-24
#change y tick values
#"y": {
#  "padding": {"top":0, "bottom": 0},
#  "max": 25,
#  "tick": {
#    "format": "dollar",
#    "count": 6
#  }
#add "overrideTickCount": true to outermost bracket

fig4_24 <- read.csv(paste(textpath, "Financial aid_tax benefits/04_0240-dollars.csv", sep=""),stringsAsFactors=FALSE)
json4_24 <- makeJson(sectionn = 4, graphn = 24, dt = fig4_24, graphtype = "area",
                     series = c("Total Credits", "Total Deduction"),
                     categories = fig4_24$year, tickformat = "dollar", rotated = FALSE, directlabels = TRUE)

#Figure 4-25
fig4_25 <- read.csv(paste(textpath, "Financial aid_tax benefits/04_0250.csv", sep=""),stringsAsFactors=FALSE)
fig4_25$range <- gsub(" to ", "–", fig4_25$range) 
json4_25 <- makeJson(sectionn = 4, graphn = 25, dt = fig4_25$credits_deductions, graphtype = "bar",
                     series = "Percentage",
                     categories = fig4_25$range, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 4-26
fig4_26 <- read.csv(paste(textpath, "Financial aid_tax benefits/04_0260.csv", sep=""),stringsAsFactors=FALSE)
json4_26 <- makeJson(sectionn = 4, graphn = 26, dt = fig4_26, graphtype = "bar",
                     series = c("Less than $30,000", "$30,001–65,000", "$65,0001–106,000", "More than $106,000", "Total"), graphtitle="Institution type",
                     categories = fig4_26$category, tickformat = "percent", rotated = TRUE, directlabels = TRUE)

#Figure 4-27
fig4_27 <- read.csv(paste(textpath, "Financial aid_tax benefits/04_0270.csv", sep=""),stringsAsFactors=FALSE)
json4_27 <- makeJson(sectionn = 4, graphn = 27, dt = fig4_27, graphtype = "bar",
                     series = c("Less than $30,000", "$30,001–65,000", "$65,0001–106,000", "More than $106,000", "Total"), graphtitle="Institution type",
                     categories = fig4_27$category, tickformat = "$s", rotated = TRUE, directlabels = TRUE)