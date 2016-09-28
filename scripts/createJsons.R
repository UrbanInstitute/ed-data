# Create data jsons for graphs

library(dplyr)
library(tidyr)
library(jsonlite)
library(openxlsx)

# Path to Excel file with graph titles, notes, data sources
textpath <- "/Users/hrecht/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) Project/**Production/GraphText.xlsx"
graphtext <- readWorkbook(textpath, sheet = 1)
graphtext$section_number <- as.numeric(graphtext$section_number)
graphtext$multiples <- as.numeric(graphtext$multiples)
graphtext$toggle <- as.numeric(graphtext$toggle)

# sectionn and graphn correspond to the location of the graph, specifically in the row in the Excel file that contains text attributes
# subn is graph subnumber - so small multiples, or graphs added later, etc. 0 unless needed
makeJson <- function(sectionn, graphn, subn = 0, dt, graphtype = "bar", series, categories, tickformat = "number", 
                     directlabels = FALSE, rotated = FALSE, graphtitle = NULL, xtype = "category", xlabel = NULL, ylabel = NULL, ymax = NULL) {
  # Init json and attributes
  graphjson <- NULL
  metadata <- NULL
  graphdata <- NULL
  axis <- NULL
  xaxis <- NULL
  yaxis <- NULL
  
  # Attributes from graphtext spreadsheet
  row <- graphtext[which(graphtext$section_number==sectionn & graphtext$graph_number==graphn),]
  
  # Internally use full type of graph for stacking, grouping needs - but the json type will be "line" or "bar"
  if (row$type == "stacked bar") {
    # c3 needs this to be a list of lists - nest it in Python script
    graphdata$groups <- series
  }
  
  graphdata$type <- graphtype
  # Organize data series into "columns" for c3 specs
  # This assumes that the first column is the category names/axis values and the other columns are the values for each series
  # For c3, "columns" need to have first the series names and then the values - mixing string and numeric
  # R does not like to mix types, so make a list - but this will need to be flatted
  # scripts/flattenJsonColumns.py accomplishes that
  columns <- list()
  if (is.data.frame(dt)) {
    for (s in seq_along(series)) {
      columns[[s]] <- list(series[s], dt[,s+1])
    } 
  } else {
    columns <- list(series, dt)
  }
  graphdata$columns <- columns  
  
  # If we're using direct labels:
  # c3 needs format to be repeated for each series
  # example: "labels": {"format": {"First": "dollar","Second": "dollar","Third": "dollar"} }
  if (directlabels != FALSE) {
    labels <- NULL
    # Make an object with key value pairs with each series name as the key and the format as the value
    # Not super elegant but it works
    labeldf <- data.frame(t(replicate(length(series), tickformat, simplify=",")))
    colnames(labeldf) <- series
    labels$format <- tickformat
    
    graphdata$labels <- labels
  }
  
  graphjson$data <- graphdata
  
  # Axis attributes
  axis$rotated <- rotated
  yaxis$tick$format <- tickformat
  
  if (!is.null(xlabel)) {
    xaxis$label <- xlabel
  }
  if (!is.null(ylabel)) {
    yaxis$label <- ylabel
  }
  if (!is.null(ymax)) {
    yaxis$max <- ymax
  }
  xaxis$type <- xtype
  xaxis$categories <- categories
  axis$x <- xaxis
  axis$y <- yaxis
  graphjson$axis <- axis
  
  # Number of series - for error checking
  graphjson$series <- series
  
  # Text attributes - title, source, notes
  if (row$multiples == "1") {
    graphjson$title <- graphtitle
  } else {
  graphjson$title <- row$title
  }
  metadata$source <- row$sources
  metadata$notes <- row$notes
  graphjson$metadata <- metadata
  
  # Write json
  json <- toJSON(graphjson, auto_unbox=T)
  jsonpath <- paste("graph-json/",sprintf("%02s",sectionn), "/", sprintf("%02s",sectionn), "_", sprintf("%03s",graphn), subn, ".json", sep="")
  write(json, jsonpath)
  # As noted above, flatten "columns" arrays
  system(paste("python3 scripts/flattenJsonColumns.py", jsonpath, sep=" "))
  
  return(json)
}

