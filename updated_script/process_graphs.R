# PURPOSE Create data jsons for graphs

# load packages
library(dplyr)
library(tidyr)
library(jsonlite)
library(openxlsx)


## UPDATE ME!!!! ##
# read in source code
source('/Users/bchartof/Projects/ed-data/updated_script/makejsons_update.R')

# controls verbosity of output
DEBUG_FLAG <- TRUE


# path to all files and xlsx file name (xlsx in the SAME directory)
GRAPH_TEXT_PATH <- "/Users/bchartof/Projects/ed-data/updated_script/"
GRAPHTEXT_FILENAME <- "Graphtext_test.xlsx"

# path to each of the data folders
section_1_data_path <- "/Users/bchartof/Projects/ed-data/graph-data/test-csv/"
section_1_output_base_path <- "/Users/bchartof/Projects/college-affordability.urban.org/pages/what-is-college/"
section_1_subsection_paths <- c("institutions/json/","students/json/")

section_2_data_path <- "/Users/bchartof/Projects/ed-data/graph-data/test-csv/"
section_2_output_base_path <- "/Users/bchartof/Projects/college-affordability.urban.org/pages/cost-of-educating/"
section_2_subsection_paths <- c("subsidies/json/","appropriations/json/","endowments/json/")

section_3_data_path <- "/Users/bchartof/Projects/ed-data/graph-data/test-csv/"
section_3_output_base_path <- "/Users/bchartof/Projects/college-affordability.urban.org/pages/prices-and-expenses/"
section_3_subsection_paths <- c("tuition-and-fees/json/","room-and-board/json/","student-budgets/json/","forgone-earnings/json/","net-price/json/")


# read in graph df
graph_text_df <- read.xlsx(paste(GRAPH_TEXT_PATH, GRAPHTEXT_FILENAME, sep=""))

# section 1
section_1_graph_text_df <- graph_text_df %>% 
  filter(section_number == 1)

temp <- mapply(makeJson, section_1_graph_text_df$section_number, section_1_graph_text_df$subsection_number, 
       section_1_graph_text_df$graph_number, text_file_path = GRAPH_TEXT_PATH, 
       data_path = section_1_data_path, gt_file = GRAPHTEXT_FILENAME, debug = DEBUG_FLAG, 
       output_path = paste(section_1_output_base_path, section_1_subsection_paths[section_1_graph_text_df$subsection_number],sep = ""))

# section 2
section_2_graph_text_df <- graph_text_df %>% 
  filter(section_number == 2)

temp <- mapply(makeJson, section_2_graph_text_df$section_number, section_2_graph_text_df$subsection_number, 
       section_2_graph_text_df$graph_number, text_file_path = GRAPH_TEXT_PATH, 
       data_path = section_2_data_path, gt_file = GRAPHTEXT_FILENAME, debug = DEBUG_FLAG, 
       output_path = paste(section_2_output_base_path, section_2_subsection_paths[section_2_graph_text_df$subsection_number],sep = ""))


# section 3
section_3_graph_text_df <- graph_text_df %>% 
  filter(section_number == 3)

temp <- mapply(makeJson, section_3_graph_text_df$section_number, section_3_graph_text_df$subsection_number, 
       section_3_graph_text_df$graph_number, text_file_path = GRAPH_TEXT_PATH, 
       data_path = section_3_data_path, gt_file = GRAPHTEXT_FILENAME, debug = DEBUG_FLAG, 
       output_path = paste(section_3_output_base_path, section_3_subsection_paths[section_3_graph_text_df$subsection_number],sep = ""))

