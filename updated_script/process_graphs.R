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

subSections <- list(
    c("institutions/json/","students/json/"),
    c("appropriations/json/","endowments/json/","subsidies/json/"),
    c("forgone-earnings/json/","net-price/json/","room-and-board/json/","student-budgets/json/","tuition-and-fees/json/"),
    c("federal/json","financial-need/json","grant-aid/json","institutional/json","other/json","state/json","tax-benefits/json"),
    c("borrowing/json/","pre-college-income/json/","savings/json/","state-policies/json/","time-to-degree/json/","working-during-college/json/"),
    c("breaking-even/json/","employment-after-college/json/","loan-repayment-and-default/json/","student-debt/json/","variation-in-earnings/json/"),
    c("json/"),
    c("json/")
  )

# path to all files and xlsx file name (xlsx in the SAME directory)
GRAPH_TEXT_PATH <- "updated_script/"
GRAPHTEXT_FILENAME <- "Graphtext_test.xlsx"
data_folder <- "csv-021919/"

########### Important #################
# Pick which section you want to generate
selectedSection <- 2
#######################################

sections[selectedSection]

# path to each of the data folders
section_data_path <- paste("graph-data/",data_folder,sep="")
section_output_base_path <- paste("../college-affordability.urban.org_tester/pages/",sections[selectedSection],sep="")
section_subsection_paths <- subSections[[selectedSection]]

# read in graph df
graph_text_df <- read.xlsx(paste(GRAPH_TEXT_PATH, GRAPHTEXT_FILENAME, sep=""))

# section 1
section_graph_text_df <- graph_text_df %>% 
  filter(section_number == 1)

temp <- mapply(makeJson, section_graph_text_df$section_number, section_graph_text_df$subsection_number, 
       section_graph_text_df$graph_number, text_file_path = GRAPH_TEXT_PATH, 
       data_path = section_data_path, gt_file = GRAPHTEXT_FILENAME, debug = DEBUG_FLAG, 
       output_path = paste(section_output_base_path, section_subsection_paths[section_graph_text_df$subsection_number],sep = ""))
