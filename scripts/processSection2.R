
library(dplyr)
library(tidyr)
library(jsonlite)
library(openxlsx)


source('~/Documents/ed-data/scripts/createJsons.R')
textpath <- "/Users/vivhou/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) Project/**Production/"
graphtext <- readWorkbook(paste(textpath, "GraphText.xlsx", sep=""),sheet = 1)
graphtext$section_number <- as.numeric(graphtext$section_number)
graphtext$multiples <- as.numeric(graphtext$multiples)
graphtext$toggle <- as.numeric(graphtext$toggle)


#Figure 2-1
fig2_1 <- read.csv(paste(textpath, "Cost of educating_appropriations/02_0010.csv", sep=""),stringsAsFactors=FALSE)
fig2_1$year <- gsub("-", "–", fig2_1$year) 
json2_1 <- makeJson(sectionn = 2, graphn = 1, dt = fig2_1, graphtype = "line", series=c("State and local public higher education appropriations", "Public student enrollment", "State and local public higher education appropriations per public student"),
                     categories = fig2_1$year, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

##Figure 2-2
#add blank data point (null) as last x-value and "" to categories
#add "overrideTickCount": true, to topmost bracket
#set tick.count to 8

#Figure 2-3
#add blank data point (null) as last x-value and "" to categories
#add "overrideTickCount": true, to topmost bracket
#set tick.count to 9
fig2_3 <- read.csv(paste(textpath, "Cost of educating_appropriations/02_0030.csv", sep=""),stringsAsFactors=FALSE)
fig2_3$year <- gsub("-", "–", fig2_3$year) 
json2_3 <- makeJson(sectionn = 2, graphn = 3, dt = fig2_3, graphtype = "line", series=c("Local support", "State support"),
                    categories = fig2_3$year, tickformat = "percent", rotated = FALSE, directlabels = TRUE)

#Figure 2-4
#add "highlightIndex" : 36  to outermost bracket
fig2_4 <- read.csv(paste(textpath, "Cost of educating_appropriations/02_0040.csv", sep=""),stringsAsFactors=FALSE)
json2_4 <- makeJson(sectionn = 2, graphn = 4, dt = fig2_4$public, graphtype = "bar", series="State and Local Appropriations per Public FTE Student",
                    categories = fig2_4$state, tickformat = "$s", rotated = TRUE, directlabels = TRUE)
#Figure 2-7: 
#1) for all multiples, add spaces to x-axis labels to create two lines, for example: "'01'–        '02'"
# 2) set max y value and ticks
#"y": {
#"padding": {"top": 0, "bottom": 0},
#"max": 20000,
#"tick": {
#"format": "dollar",
#"count": 5
#}
#},

#Figure 2-51: Change Y-axis properties to adjust ticks:
  #"axis": {
  #"y": {
  #"max": 6000,
  #"padding": {"top": 0, "bottom": 0},
  #"tick": {
  #"format": "dollar",
  #"count": 4
  #}
  #},

#Figure 2-52: Change Y-axis properties to adjust ticks:
  #  "axis": {
  #    "y": {
  #    "max": 1000,
  #    "padding": {"top": 0, "bottom": 0},
  #      "tick": {
  #        "format": "dollar",
  #        "count": 5#
  
  #      }
  #    },
    
#Figure 2-53: Change Y-axis properties to adjust ticks:
  #"y": {
  #"max": 60000,
  #"padding": {"top": 0, "bottom": 0},
  #"tick": {
  #"format": "dollar",
  #"count": 4
  #}
  #}
  
#Figure 2-54: Change Y-axis properties to adjust ticks:
  #"y": {
  #"max": 4000,
  #"padding": {"top": 0, "bottom": 0},
  #"tick": {
  #"format": "dollar",
  #"count": 5
  #}
  #}

#Figure 2-55: Change Y-axis properties to adjust ticks:
  #"y": {
  #"max": 30000,
  #"padding": {"top": 0, "bottom": 0},
  #"tick": {
  #"format": "dollar",
  #"count": 4
  #}
  #},
  
#Figure 2-61: Change Y-axis properties to adjust ticks:
  #"y": {
  #"padding": {"top": 0, "bottom": 0},
  #"max": 25000,
  #"tick": {
  #"format": "dollar",
  #"count": 6
  #}
  #}
#Figure 2-62: Change Y-axis properties to adjust ticks:
  #"y": {
  #"padding": {"top": 0, "bottom": 0},
  #"max": 1200,
  #"tick": {
  #"format": "dollar",
  #"count": 7
  #}
  #}

#Figure 2-7: 
  #1) for all multiples, add spaces to x-axis labels to create two lines, for example: "'01'–        '02'"
  # 2) set max y value and ticks
  #"y": {
  #"padding": {"top": 0, "bottom": 0},
  #"max": 20000,
  #"tick": {
  #"format": "dollar",
  #"count": 5
  #}
  #},