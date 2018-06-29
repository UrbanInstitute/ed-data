# PURPOSE Create data jsons for graphs

# load packages
library(dplyr)
library(tidyr)
library(jsonlite)
library(openxlsx)


## UPDATE ME!!!! ##
# read in source code
source('/Users/ENechamkin/Desktop/for_ben/makejsons_update.R')

# controls verbosity of output
DEBUG_FLAG <- FALSE


## UPDATE ME!!!! ##
# path to all files and xlsx file name (xlsx in the SAME directory)
GRAPH_TEXT_PATH <- "/Users/ENechamkin/Desktop/WIP/gtfile/"
GRAPHTEXT_FILENAME <- "try_graphtext.xlsx"

# path to each of the data folders
section_1_data_path <- "/Users/ENechamkin/Desktop/WIP/"
section_2_output_path <- "/Users/ENechamkin/Desktop/Output1"

section_2_data_path <- "/Users/ENechamkin/Desktop/WIP/"
section_2_output_path <- "/Users/ENechamkin/Desktop/Output2"

section_3_data_path <- "/Users/ENechamkin/Desktop/WIP/"
section_3_output_path <- "/Users/ENechamkin/Desktop/Output3"

section_4_data_path <- "/Users/ENechamkin/Desktop/WIP/"
section_4_output_path <- "/Users/ENechamkin/Desktop/Output4"

section_5_data_path <- "/Users/ENechamkin/Desktop/WIP/"
section_5_output_path <- "/Users/ENechamkin/Desktop/Output5"

section_6_data_path <- "/Users/ENechamkin/Desktop/WIP/"
section_6_output_path <- "/Users/ENechamkin/Desktop/Output6"

section_7_data_path <- "/Users/ENechamkin/Desktop/WIP/"
section_7_output_path <- "/Users/ENechamkin/Desktop/Output7"


# read in graph df
graph_text_df <- read.xlsx(paste(GRAPH_TEXT_PATH, GRAPHTEXT_FILENAME, sep=""))

# section 1
section_1_graph_text_df <- graph_text_df %>% 
  filter(section_number == 1)

temp <- mapply(makeJson, section_1_graph_text_df$section_number, 
       section_1_graph_text_df$graph_number, text_file_path = GRAPH_TEXT_PATH, 
       data_path = section_1_data_path, gt_file = GRAPHTEXT_FILENAME, debug = DEBUG_FLAG, 
       output_path = section_1_output_path)

# section 2
section_2_graph_text_df <- graph_text_df %>% 
  filter(section_number == 2)

temp <- mapply(makeJson, section_2_graph_text_df$section_number, 
       section_2_graph_text_df$graph_number, text_file_path = GRAPH_TEXT_PATH, 
       data_path = section_2_data_path, gt_file = GRAPHTEXT_FILENAME, debug = DEBUG_FLAG,
       output_path = section_2_output_path)

