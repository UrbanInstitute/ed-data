# Create data jsons for graphs

library(dplyr)
library(tidyr)
library(jsonlite)
library(openxlsx)

# Path to Excel file with graph titles, notes, data sources
textpath <- "/Users/hrecht/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) Project/Getting data for Phase2/GraphText.xlsx"
graphtext <- readWorkbook(textpath, sheet = 1)
graphtext$section_number <- as.numeric(graphtext$section_number)

# sectionn and graphn correspond to the location of the graph, specifically in the row in the Excel file that contains text attributes
# subn is graph subnumber - so small multiples, or graphs added later, etc. 0 unless needed
makeJson <- function(sectionn, graphn, subn = 0, dt, graphtype = "bar", series, categories, tickformat = "number", 
                     directlabels = FALSE, rotated = FALSE, xtype = "category", xlabel = NULL, ylabel = NULL) {
  # Init json and attributes
  graphjson <- NULL
  metadata <- NULL
  graphdata <- NULL
  axis <- NULL
  xaxis <- NULL
  yaxis <- NULL
  
  graphdata$type <- graphtype
  # Organize data series into "columns" for c3 specs
  # This assumes that the first column is the category names/axis values and the other columns are the values for each series
  columns <- list()
  for (s in seq_along(series)) {
    columns[[s]] <- c(series[s], dt[,s+1])
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
    labels$format <- labeldf
    
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
  xaxis$type <- xtype
  xaxis$categories <- categories
  axis$x <- xaxis
  axis$y <- yaxis
  graphjson$axis <- axis
  
  # Text attributes - title, source, notes
  row <- graphtext[graphtext$section_number==sectionn & graphtext$graph_number==graphn,]
  graphjson$title <- row$title
  metadata$sources <- row$sources
  metadata$notes <- row$notes
  graphjson$metadata <- metadata
  
  json <- toJSON(graphjson, auto_unbox=T)
  
  write(json, paste("graph-json/",sprintf("%02s",sectionn), "/", sprintf("%02s",sectionn), "_", sprintf("%03s",graphn), subn, ".json", sep=""))
  return(json)
}

########################################################################################################
# Costs and subsidies (Section 2)
########################################################################################################

# Figure 6 - local support for higher education has grown in recent years relative to state support
# State and local support for higher education: use appropriations_tax (state) and appropriations_local
# Use cpi to age dollar amounts to latest data year
shef <- read.csv("data/shef.csv", stringsAsFactors = F, colClasses = c("fips" = "character"))

fig6 <- shef %>% filter(fips=="00") %>% 
  mutate(approp_state_aged = appropriations_state * cpi_multiplier,
         approp_local_aged = appropriations_local * cpi_multiplier)

# Get 2000 values to compare with value by year
state2000 <- fig6$approp_state_aged[fig6$year_fiscal==2000]
local2000 <- fig6$approp_local_aged[fig6$year_fiscal==2000]
fig6$approp_state_change <- (fig6$approp_state_aged - state2000)/state2000
fig6$approp_local_change <- (fig6$approp_local_aged - local2000)/local2000

# Save data as json
fig6_min <- fig6 %>% select(year_axis, approp_state_change, approp_local_change)

json2_6 <- makeJson(sectionn = 2, graphn = 6, dt = fig6_min, graphtype = "line", series = c("State", "Local"), 
                    categories = fig6_min$year_axis, tickformat = "percent", directlabels = FALSE, rotated = FALSE, xtype = "category",
                    xlabel = NULL, ylabel = NULL)