# PURPOSE Create data jsons for graphs

# load packages
library(dplyr)
library(tidyr)
library(jsonlite)
library(openxlsx)
library(lintr)

# C3 CONSTANTS
X_AXIS_TYPE <- "category"
LINE <- "line"
BAR <- "bar"
AREA <- "area"

# variables for graphing parameters
JSON_NEEDS_GROUPS <- c("stacked bar", "horizontal stacked bar", "stacked area")
ROTATE_TYPE <- "horizontal"

# controls verbosity of output
DEBUG_FLAG <- FALSE

# ---- MAIN FUNCTION ---- #
makeJson <- function (snumber, subsnumber, gnumber, 
                      text_file_path, data_path,
                      gt_file, debug = DEBUG_FLAG) {

  # print(paste(snumber, subsnumber, gnumber,".csv start",sep=""))
  # Purpose: to create a json file with all graphing parameters as specified
  #
  # Args:
  #   snumber (int): section number (e.g., 2) 
  #   subsnumber (int): subsection number 
  #   gnumber (int): graph number (e.g., 71)
  #   text_file_path (str): path to the graphtext file
  #   data_path (str): path to all data files
  #   output_path (str): path where you want output to go
  #   gt_file (str): name of the graphtext file
  #   debug (bool): whether to print out the JSON to the console or not
  
  # identify row for the graph

  output_path = paste(section_output_base_path, section_subsection_paths[subsnumber + 1],sep = "")

  current_row <- get_row(snumber, subsnumber, gnumber, text_file_path, gt_file)
  
  
  if(current_row$type == "table") {
    print('table skip')
    return ("skip")
  }

  # load dataset
  dataset <- load_data(current_row, data_path)
  
  # get all graphing parameters 
  graphing_params <- get_all_graphing_data(current_row, dataset)
  
  # convert all graphing parameters to JSON
  graphing_params_json <- toJSON(graphing_params, auto_unbox=T, na = "null", 
                                 pretty=TRUE)

  print(paste(snumber, subsnumber, gnumber,".csv is done",sep=""))
  # write out a JSON file
  write_JSON(current_row, output_path, graphing_params_json)
  
  # return JSON if debugging is on
  if (debug) {
    return (graphing_params_json)
  }
  
}


# ---- HELPER FUNCTIONS ---- #

defined <- function (val) {
  
  # Purpose: check if a value is defined, where defined means not null or na
  #
  # Args: val (any 1d item)
  #
  # Returns: boolean - is it defined or not?
  
  if (is.null(val)) {
    return (FALSE)
  } else {
    return (! is.na(val))
  }
}

defined_and_true <- function(val) {
  
  # Purpose: check if a value is defined, and if it is, if it is true (e.g., 1)
  #
  # Args: val (any 1d item)
  #
  # Returns: boolean (truth value of the value)
  
  if (defined(val)) {
    return (val)
  } else {
    return (0)
  }
}

parse_comma_delimited_list_in_xslx_cell <- function(cell_value) {
  
  # Purpose: parse a string (contained in an xslx cell) into a list, separating on
  #   commas. Allows for flexibility - if a user included quotation marks or 
  #   leading / trailing whitespace, this will eliminate that 
  #
  # Args: cell_value (str): ideally a comma separated list
  #
  # Returns: list of strings, where each string is an item in the original list
  
  no_quote_cell_value <- gsub("\"", "", cell_value) # removes straggler quotes
  removed_spaces <- trimws(gsub(", ", ",", no_quote_cell_value)) # removes space
  return_value  <- unlist(strsplit(removed_spaces, ","))
  return (return_value)
}

return_colors_list <- function(cell_value) {
  
  # Purpose: from a k:v list of strings in a xslx cell (e.g., "blue: sad, red: mad"), 
  #   return a list of the form $k$v (e.g., $blue$sad, $red$mad) for printing to json
  #
  # Args: cell_value (str): ideally a comma separated list with : separating keys, values
  #
  # Returns: list of kv pairs
  
  kv_list <- parse_comma_delimited_list_in_xslx_cell(cell_value)
  
  # make character vectors for each kv pair
  kv_vector_list <- lapply(kv_list, function(i) {
    temp_split <- unlist(strsplit(i, ":"))
    temp_vec <- c(trimws(temp_split[1]), trimws(temp_split[2]))
    return (temp_vec)
  })
  
  temp_list <- list()
  split_pairs <- lapply(kv_vector_list, function(i) {
    temp_list <- i[2]
    return(temp_list)
  })
  
  names(split_pairs) <- lapply(kv_vector_list, function(i) i[1])
  return(split_pairs)
}

return_kv_list_boolean <- function(cell_value) {
  
  # Purpose: parse a comma delimited list of boolean flags included in an xslx cell such that
  #   a list of flags all set to true is returned. All booleans must be TRUE.  
  #
  # Args: cell_value (str): ideally a comma separated list of boolean flags, e.g., 
  #    "hideToolTip, imageOverride"
  #
  # Returns: flag_list_bools (list) list of lists set to TRUE
  
  list_of_flags <- parse_comma_delimited_list_in_xslx_cell(cell_value)
  
  temp_list <- list()
  flag_list_bools <- lapply(list_of_flags, function(i) {
    temp_list <- TRUE
    return (temp_list)
  })
  
  names(flag_list_bools) <- list_of_flags
  return(flag_list_bools)
  
}

write_JSON <- function(current_row, file_path, graphing_params_json) {
  
  # Purpose: Write a JSON file given a JSON to the same file name as the csv input, 
  #     but with json instead (e.g., HELLO.csv will print a json to HELLO.json)
  #
  # Args: 
  #   current_row (df row): the row for the graph as needed 
  #   file_path (path to the data files)
  
  json_file_path <- paste(file_path, sub("csv", "json", current_row$data_source), sep = "")
  write(graphing_params_json, json_file_path)
}

get_row <- function (snumber, subsnumber, gnumber, 
                     file_path, gt_file) {
  
  # Purpose: Retrieve the graphing parameters for a given section number, figure number 
  #
  # Args:
  #   file_path (str): path to the graphtext xslx file
  #   snumber (int): the section number corresponding to the graph
  #   subsnumber (int): the subsection number
  #   gnumber (int): the graph number for the graph 
  #
  # Returns:
  #   current_row (df row): holds all graphing parameters
  
  graphtext_file <- paste(file_path, gt_file, sep = "")
  tryCatch ({graphtext <- readWorkbook(graphtext_file, sheet = 1)
  }, error = function (e) {
    print(paste("ERROR: cannot load graphtext file ", graphtext_file))
    print(paste("Original error: ", e))
  })
  current_row = graphtext[ which(( graphtext$section_number == snumber 
                                  & graphtext$graph_number == gnumber) &
                                   graphtext$subsection_number == subsnumber), ]  
  # print(which(( graphtext$section_number == snumber 
  #                                 & graphtext$graph_number == gnumber) &
  #                                  graphtext$subsection_number == subsnumber) )
  # print(graphtext[1,])
  return (current_row)
}

load_data <- function(current_row, file_path) {
  
  # Purpose: Retrieve the dataset for a given figure (specified by the row of graphtext) 
  #
  # Args:
  #   current_row (df): the row of graphtext that is currently being constructed
  #   file_path (str): path to the data section directory
  #
  # Returns:
  #   dataset (df): data to be used in the graph
  
  dataset <- tryCatch({read.csv(paste(file_path, current_row$data_source, sep = ""),
                                check.names = FALSE, stringsAsFactors = FALSE)
  }, error = function (e) {
    print(paste("ERROR: cannot load file ", current_row$data_source, "found in", file_path))
    print(paste("Original error: ", e))
  })
  return (dataset)
}

get_all_graphing_data <- function (current_row, dataset) {
  
  # Purpose: populate all graphing parameters in structure to be converted into a json
  #
  # Args:
  #   current_row (df row): row of graphtext with specified parameters
  #   dataset (df): dataframe with all data to graph
  # 
  # Returns: all_graphing_data (list): graphing parameters
  
  all_graphing_data <- list()
  
  # add all top-level flags
  all_graphing_data <- add_top_level(current_row, all_graphing_data)
  
  # create series names depending on whether the graph TOGGLES or not
  # this should catch toggle errors
  
  if (current_row$toggle) {
    tryCatch({all_graphing_data$series <- colnames(dataset[, c(3:ncol(dataset))])
    }, error = function(e) { 
      print("ERROR: graph has toggle on but csv file is not formatted appropriately.")
      print(paste("Original error:", e))
    })
    
  } else {
    all_graphing_data$series <- colnames(dataset[-1])
  }
  
  # get data :{}
  all_graphing_data$data <- get_graph_param_data(current_row, dataset)
  
  # get axis: {}
  all_graphing_data$axis <- get_axis_parameters(current_row, dataset)

  
  if (length(all_graphing_data$axis$x$categories)) {
    # print(all_graphing_data$axis$x$categories)  
    # all_graphing_data$axis$x$categories[0][0] <- all_graphing_data$axis$x$categories
  }
  
  # get metadata: {}
  all_graphing_data$metadata <- get_metadata(current_row)
  
  return (all_graphing_data)
}

get_metadata <- function(current_row) {
  
  # Purpose: populate all metadata parameters in structure to be converted into a json
  #
  # Args: current_row (df row): row of graphtext with specified parameters
  # 
  # Returns: metadata (list): graphing parameters
  
  metadata <- list()
  
  # add boolean flags. this must come FIRST or the metadata will be overwritten!
  if (defined(current_row$metadata_flags)) {
    metadata <- return_kv_list_boolean(current_row$metadata_flags)
  } 
  
  # add source from graphtext
  metadata$source <- current_row$sources
  
  # add notes from graphtext
  metadata$notes <- current_row$notes
  
  # add subtitle in metadata if needed 
  if (defined_and_true(strtoi(current_row$metadata_subtitle))) {
    metadata$subtitle <- current_row$subtitle 
  }
  
  return (metadata)
}

get_graph_param_data <- function (current_row, dataset) {
  
  # Purpose: Create and update graph data section for json file 
  #
  # Args: dataset (df): the data  to graph
  #
  # Returns: graph_data (list): to be translated into json "data" section
  
  data_to_graph <- dataset[-1]
  series_names <- colnames(data_to_graph) # assumes first is category
  
  graph_data <- list()
  
  # get graph type
  graph_data <- add_graph_type(current_row, graph_data)
  
  # get sets or columns
  graph_data <- add_sets_or_columns(current_row, graph_data, dataset, data_to_graph)
  
  # groups if needed 
  if (is.element(current_row$type, JSON_NEEDS_GROUPS)){
    if (current_row$toggle){
      graph_data$groups <- list(series_names[-1])
    } else {
      # print(list(series_names))
      graph_data$groups <- list(series_names)
    }
  }
  
  # labels if needed 
  if (current_row$direct_labels) {
    labels <- list()
    labels$format <- current_row$y_tick_format
    graph_data$labels <- labels
  }
  
  # colors if needed 
  if (defined(current_row$colors_dictionary)) {
    graph_data$colors <- return_colors_list(current_row$colors_dictionary)
  }
  
  return (graph_data)
}

add_graph_type <- function(current_row, graph_data) {
  
  # Purpose: get the type of the graph from the xslx spreadsheet. The type
  #   should either be a bar or a line, and so this will grep for 'bar' and 'line'
  #   in the graphtext excel sheet. Of course, this will mess up if for some reason
  #   you're making a mixed chart that has both bar and line in the string name of its type.
  #
  # Args: 
  #   current_row (df row) of graph text
  #   graph_data (list) structure to add graph information to 
  # 
  # Returns: updated graph_data (list)
  
  if (any(grep(LINE, current_row$type))){
    graph_type <- LINE
  } else if (any(grep(BAR, current_row$type))) {
    graph_type <- BAR
  } else if (any(grep(AREA, current_row$type))) {
  graph_type <- AREA
  } else {
    stop('ERROR: graph type not defined; update graphtext excel sheet')
  }
  
  graph_data$type <- graph_type
  
  return (graph_data) 
}

add_sets_or_columns <- function(current_row, graph_data, dataset, data_to_graph) {
  
  # Purpose: add sets or columns to the graph_data list. 
  #
  # Args: 
  #   current_row (df row) of graph text
  #   graph_data (list) structure to add graph information to 
  # 
  # Returns: updated graph_data (list)
  
  if (current_row$toggle) { # add sets for a toggled graph
    graph_data$sets <- add_sets(current_row, data_to_graph)
  } else { # add columns for a non-toggled graph
    graph_data$columns <- get_columns(current_row, data_to_graph)
  } 
  return (graph_data)
}

add_sets <- function(current_row, data_to_graph) {
  
  # Purpose: get sets for the JSON file. 
  #
  # Args: 
  #   current_row (df row) of graph text
  #   data_to_graph (df) the dataset for ALL graph information
  # 
  # Returns: sets (list)
  
  # categories for the sets -> we will need to filter our graph data on these
  set_categories <- unique(data_to_graph[1])[, 1]
  # print(set_categories)

  # creates a vector of set1, set2, etc... 
  set_list_names <- paste(rep("set", length(set_categories)), 
                          1:length(set_categories), sep = "")
  
  # renames a column so that we can easily filter
  colnames(data_to_graph)[1] <- "tempcat"
  
  # initializes an empty list of lists
  sets <- rep(list(), length(set_categories))
  
  # so this is a clear area for improvement - there has to be a way to do this
  # with maps and applys, but... it escapes me
  for (i in 1:length(set_categories)) { # loop through categories
    new_data_to_graph <- data_to_graph %>% # filter data based on what category we are on
      filter(tempcat == set_categories[i]) %>% 
      select(- (tempcat)) # get rid of category column
    # print(current_row)
    # print(new_data_to_graph)
    temp_cols <- get_columns(current_row, new_data_to_graph) # get columns for each    
    sets[[i]] <- list(set_categories[i], temp_cols) # store as a list for the set name    
  }
  
  names(sets) <- set_list_names # rename the sets as set1, set2, etc...
  return (sets)
}

get_columns <- function(current_row, data_to_graph) {
  
  # Purpose: get columns for the JSON file. 
  #
  # Args: 
  #   current_row (df row) of graph text
  #   data_to_graph (df) the dataset for ALL graph information
  # 
  # Returns: graph_columns (list)
  
  # check first to see if we have to add nulls to the beginning and end of our 
  # data (could be a separate function for readability - will update if I have time).
  # If we have nulls to add to the beginning, add them as NaN. These will be updated
  # when the JSON is made from NA to null. 
  if (defined(current_row$add_nulls_beginning)) {
    nulls_beginning <- data.frame(matrix(NaN, ncol = ncol(data_to_graph), 
                              nrow = current_row$add_nulls_beginning))
    colnames(nulls_beginning) <- colnames(data_to_graph)
    data_to_graph <- rbind(nulls_beginning, data_to_graph)
  }
  
  if (defined(current_row$add_nulls_end)) {
    nulls_end <- data.frame(matrix(NaN, ncol = ncol(data_to_graph), 
                              nrow = current_row$add_nulls_end))
    colnames(nulls_end) <- colnames(data_to_graph)
    data_to_graph <- rbind(data_to_graph, nulls_end)
  }
  
  # Once we've modified our graph data, we add the data to our column
  # lists. 
  graph_cols <- list()
  for ( i in 1:ncol(data_to_graph)) {
    curr_data <- data_to_graph[i]
    
    # What is about to happen is super gross code, but I can't figure a way to 
    # add the data from the columns as.numeric -- any non-loop option (e.g., lapply with c)
    # will coerce the data into strings. If this doesn't matter to graph, then there are 
    # prettier and faster ways to do this. Otherwise, we can add the information one 
    # item at a time. Gross. 
    temp_list <- list()
    temp_list[1] <- colnames(curr_data)
    for ( j in 1:nrow(curr_data) ) {
      temp_list[j + 1] <- curr_data[j, ]
    }
    graph_cols[[i]] <- temp_list
  } 
  return (graph_cols)
}

get_axis_parameters <- function(current_row, dataset) {

  # Purpose: get a list of lists for all axis parameters 
  #
  # Args: 
  #   current_row (df row) of graph text
  #   dataset (df) the full dataset 
  # 
  # Returns: axis_data (list)
  
  axis_data <- list()

  # if ROTATE_TYPE string is in the graph type, graph will have rotated axes 
  axis_data$rotated <- any(grep(ROTATE_TYPE, current_row$type)) 
  
  # get x and y axis parameters 
  axis_data$x <- get_x_axis_data(current_row, dataset)
  axis_data$y <- get_y_axis_data(current_row, dataset)
  
  return (axis_data)
}

get_categories <- function(current_row, dataset) {
  
  # Purpose: get a list of categories in the data. Will automatically add
  #   empty strings where indicated in graphtext.xslx. Automatically selects
  #   the first column of the xslx sheet to be the category list.
  #
  # Args: 
  #   current_row (df row) of graph text
  #   dataset (df) the full dataset 
  # 
  # Returns: categories (list)
  
  categories <- gsub("-", "-", dataset[[1]]) 
  #this is from Vivian's code - it's how she replaced the unicode string
  
  if (defined(current_row$add_nulls_beginning)) {
    add_cat_before <- rep("", current_row$add_nulls_beginning)
    categories <- append(categories, add_cat_before, 0)
  }
  if (defined(current_row$add_nulls_end)) {
    add_cat_end <- rep("", current_row$add_nulls_end)
    categories <- append(add_cat_end, categories, 0)
  }

  return (categories)
}

get_x_axis_data <- function(current_row, dataset) {
  
  # Purpose: get all x_axis parameters for graphing
  #
  # Args: 
  #   current_row (df row) of graph text
  #   dataset (df) the full dataset 
  # 
  # Returns: x (list)
  
  x <- list()

  x$categories <- get_categories(current_row, dataset)

  if(current_row$toggle | current_row$type == "grouped bar") {
    x$categories <- unique(get_categories(current_row, dataset))
  }

  if (defined(current_row$x_label)) {
    x$label <- current_row$x_label
  }
  if (defined(current_row$x_tick_count)) {
    x$tick$count <- current_row$x_tick_count
  }

  # Gets the value from urrent_row$axis_x_tick_not_multiline 
  # to set the boolean. This is not automated -- always FALSE when
  # the boolean is set to 1. 
  if (defined_and_true(current_row$axis_x_tick_not_multiline)) {
    x$tick$multiline <- FALSE 
  }
  x$type <- X_AXIS_TYPE
  return (x)
}

get_y_axis_data <- function(current_row, dataset) {
  
  # Purpose: get all y_axis parameters for graphing
  #
  # Args: 
  #   current_row (df row) of graph text
  #   dataset (df) the full dataset 
  # 
  # Returns: y (list)
  
  y <- list()
  # y <- list() # nesting time
  y$tick$format <- current_row$y_tick_format
  
  # add optional args
  if (defined (current_row$y_label)) {
    y$label <- current_row$y_label
  }

  if (defined (current_row$y_max_value)) {
    y$max <- current_row$y_max_value
  }
  if (defined (current_row$y_tick_count)) {
    y$tick$count <- current_row$y_tick_count
  }
  # this is an improvement area 
  if (any(defined(current_row$y_padding_left), defined(current_row$y_padding_right), 
          defined(current_row$y_padding_top), defined(current_row$y_padding_bottom))) {
    y$padding <- get_padding_in_braces(current_row$y_padding_left, 
                                            current_row$y_padding_right, 
                                            current_row$y_padding_top, 
                                            current_row$y_padding_bottom)
  }

  
  return (y)
}

get_size <- function(height, width) {
  
  # Purpose: create a size object
  #
  # Args: 
  #   height (int): the height param
  #   width (int): the width
  # 
  # Returns: size (list)
  
  size <- list()
  if (defined(height)) {
    size$height <- height
  }
  if (defined(width)) {
    size$width <- width
  }
  return (size)
}

get_padding_in_braces <- function(left_padding, right_padding, 
                                  top_padding, bottom_padding) {
  
  # Purpose: get padding object
  #
  # Args:
  #   left_padding (int or null): the amount of left padding to add
  #   right_padding (int or null): the amount of right padding to add
  #   top_padding (int or null): the amount of top padding to add
  #   bottom_padding (int or null): the amount of bottom padding to add
  #
  # Returns: padding (padding object as a list)
  
  padding <- list()
  if (defined(left_padding)) {
    padding$left <- left_padding
  }
  
  if (defined(right_padding)) {
    padding$right <- right_padding
  }
  
  if (defined(top_padding)) {
    padding$top <- top_padding
  }
  
  if (defined(bottom_padding)) {
    padding$bottom <- bottom_padding
  }
  
  return (padding)
}

add_top_level <- function(current_row, all_graphing_data) {
  
  # Purpose: build top level of the JSON file
  #
  # Args:
  #   current_row (df row) as above
  #   all_graphing_data (list): list of graphing parameters
  #
  # Returns: all_graphing_data (list) updated with all top level flags
  
  # adds bools to top level - MUST HAPPEN FIRST OR WILL OVERWRITE DATA
  if (defined(current_row$top_level_flags)) {
    all_graphing_data <- return_kv_list_boolean(current_row$top_level_flags)
    if (defined(all_graphing_data$connectNull)) {
      all_graphing_data$line$connectNull <- TRUE
    }
  }
  
  # get title
  all_graphing_data$title <- current_row$title
  
  # add subtitle and optional defined arguments
  if (defined(current_row$subtitle)) {
    all_graphing_data$subtitle <- current_row$subtitle
  }
  if (defined(current_row$highlightIndex)) {
    all_graphing_data$highlightIndex <- current_row$highlightIndex
  }
  if (defined(current_row$imageOverride)) {
    all_graphing_data$imageOverride <- paste(
      current_row$title, current_row$subtitle, sep = "__")
  }
  if (any(defined(current_row$top_level_width), defined(current_row$top_level_height))) {
    all_graphing_data$size <- get_size(current_row$top_level_width,
                                       current_row$top_level_height)
  }
  
  #clunky, improvement area
  if (any(defined(current_row$top_level_padding_left), 
          defined(current_row$top_level_padding_right), 
          defined(current_row$top_level_padding_top), 
          defined(current_row$top_level_padding_bottom))) {
    all_graphing_data$padding <- get_padding_in_braces(current_row$top_level_padding_left, 
                                                       current_row$top_level_padding_right,
                                                       current_row$top_level_padding_top,
                                                       current_row$top_level_padding_bottom)
  }
  return (all_graphing_data)
}