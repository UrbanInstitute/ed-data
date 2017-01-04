# Create data jsons for graphs

library(dplyr)
library(tidyr)
library(jsonlite)
library(openxlsx)

# Path to Excel file with graph metadata - change to your file path
# textpath <- "/Users/vhou/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) Project/**Production/GraphText.xlsx"
# textpath <- "/Users/bchartof/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) Project/**Production/GraphText.xlsx"
 textpath <- "/Users/vivhou/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) Project/**Production/GraphText.xlsx"

graphtext <- readWorkbook(textpath, sheet = 1)
graphtext$section_number <- as.numeric(graphtext$section_number)
graphtext$multiples <- as.numeric(graphtext$multiples)
graphtext$toggle <- as.numeric(graphtext$toggle)

makeJson <- function(
  # sectionn and graphn correspond to the location of the graph, specifically in the row in the Excel file that contains text attributes
  sectionn, graphn, 
  # subn is graph subnumber - so small multiples, or graphs added later, etc. 0 unless needed
  subn = 0, 
  # data to use - this can be a data frame or a list or a column (dataset$column)
  dt, 
  # this can be "bar", "line", or "area". Stacked bar charts, grouped bar charts etc are all "bar"
  graphtype = "bar", 
  # Series is a string or list of strings that label the data series - this is a c3 thing. Ex: "In-district tuition" or c("Tuition", "Fees", "Room and board")
  series, 
  # Category names (c3 syntax) aka axis labels. You can use a list but generally want a data frame column. http://c3js.org/reference.html#axis-x-categories
  categories, 
  # Format for ticks. You can use "number", "dollar", "percent" or a d3 formatting string.
  tickformat = "number",
  # TRUE/FALSE show labels directly on data points.
  directlabels = FALSE, 
  # c3 syntax - is this a horizontal (bar) chart? If TRUE, you don't need to swap x and y parameters - just set this to TRUE. Always use false for line charts. http://c3js.org/reference.html#axis-rotated
  rotated = FALSE, 
  # This is specifically for small multiples. In all other cases, the title from GraphText.xlsx will be inserted. In small multiples, list the title for the multiple.
  graphtitle = NULL,
  # c3 syntax - should always be category. http://c3js.org/reference.html#axis-x-type
  xtype = "category", 
  # Strings for X and Y axis labels - rarely needed
  xlabel = NULL, ylabel = NULL,
  # Maximum y value. If none entered, it'll use the max of the dataset. Sometimes you'll want to set it manually, particularly with small multiples or toggles. http://c3js.org/reference.html#axis-y-max
  ymax = NULL,
  # Data to use for toggle graphs. These can be columns of data frames, etc.
  set1 = NULL, set2 = NULL, set3 = NULL, set4 = NULL, set5 = NULL) {
  
  
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
  if (row$type == "stacked bar" | row$type == "horizontal stacked bar") {
    # c3 needs this to be a list of lists - nest it in Python script
    graphdata$groups <- series
  }
  
  graphdata$type <- graphtype
  # Organize data series into "columns" for c3 specs
  # This assumes that the first column is the category names/axis values and the other columns are the values for each series
  # For c3, "columns" need to have first the series names and then the values - mixing string and numeric
  # R does not like to mix types, so make a list - but this will need to be flatted
  # scripts/flattenJsonColumns.py accomplishes that
  
  # Nest "sets" in data if toggle chart
  if (row$toggle == 1) {
    sets <- list()
    sets$set1 <- list(series[1], set1)
    sets$set2 <- list(series[2], set2)
    # Refactor this someday
    if (!(is.null(set3))) {
      sets$set3 <- list(series[3], set3)
    }
    if (!(is.null(set4))) {
      sets$set4 <- list(series[4], set4)
    }
    if (!(is.null(set5))) {
      sets$set5 <- list(series[5], set5)
    }
    graphdata$sets <- sets
  } else {
    columns <- list()
    # Otherwise "columns" if not toggle chart
    if (is.data.frame(dt)) {
      for (s in seq_along(series)) {
        columns[[s]] <- list(series[s], dt[,s+1])
      } 
    } else {
      columns <- list(series, dt)
    }
    graphdata$columns <- columns  
  }
  
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
  if (row$multiples == 1) {
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

