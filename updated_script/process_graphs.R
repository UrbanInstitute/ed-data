# PURPOSE Create data jsons for graphs

# load packages
library(dplyr)
library(tidyr)
library(jsonlite)
library(openxlsx)


## UPDATE ME!!!! ##
# read in source code
source('updated_script/makejsons_update.R')

# controls verbosity of output
DEBUG_FLAG <- TRUE

# Metadata...this is the list of the sections and their subsections. They are tied together by index. 
sections <- c(
    "what-is-college/",
    "cost-of-educating/",
    "prices-and-expenses/",
    "financial-aid/",
    "covering-expenses/",
    "after-college/",
    "breaking-even/",
    "student-profiles/"
  )

# After College for some reason has a "breaking even" column even though there isn't one at that subpage on the site...i have removed. 
# order of these folders matters!

subSections <- list(
    c("json/","institutions/json/","students/json/"),
    c("json/","subsidies/json/","appropriations/json/","endowments/json/"),
    c("json/","tuition-and-fees/json/","room-and-board/json/","student-budgets/json/","forgone-earnings/json/","net-price/json/"),
    c("json/","financial-need/json/","grant-aid/json/","federal/json/","state/json/","institutional/json/","other/json/","tax-benefits/json/"),
    c("json/","pre-college-income/json/","savings/json/","working-during-college/json/","borrowing/json/","time-to-degree/json/","state-policies/json/"),
    c("json/","employment-after-college/json/","variation-in-earnings/json/","student-debt/json/","loan-repayment-and-default/json/"),
    c("json/"),
    c("json/")
  )

# path to all files and xlsx file name (xlsx in the SAME directory)
GRAPH_TEXT_PATH <- "updated_script/"
GRAPHTEXT_FILENAME <- "Graphtext_062119_dw.xlsm"
# GRAPHTEXT_FILENAME <- "testGroup_section2.xlsx"
data_folder <- "csv-active/"

########### Important #################
# Pick which section you want to generate
selectedSection <- 8
#######################################

sections[selectedSection]

# path to each of the data folders
section_data_path <- paste("graph-data/",data_folder,sep="")
section_output_base_path <- paste("../college-affordability.urban.org/pages/",sections[selectedSection],sep="")
section_subsection_paths <- subSections[[selectedSection]]

# read in graph df
graph_text_df <- read.xlsx(paste(GRAPH_TEXT_PATH, GRAPHTEXT_FILENAME, sep=""))


stringSelection <- paste("0",selectedSection,sep="")


# filter to section selected
section_graph_text_df <- graph_text_df  %>% 
  filter(section_number == selectedSection)

# output_path = paste(section_output_base_path, section_subsection_paths[section_graph_text_df$subsection_number],sep = "")

temp <- mapply(makeJson, 
       section_graph_text_df$section_number, 
       section_graph_text_df$subsection_number, 
       section_graph_text_df$graph_number, 
       text_file_path = GRAPH_TEXT_PATH, 
       data_path = section_data_path, 
       gt_file = GRAPHTEXT_FILENAME, 
       debug = DEBUG_FLAG)
