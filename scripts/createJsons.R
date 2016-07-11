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
makeJson <- function(sectionn, graphn, dt, graphtype = "bar", series, categories, tickformat = "number", directlabels = FALSE, rotated = FALSE, xtype = "category", xlabel = NULL, ylabel = NULL) {
  # Init json and attributes
  graphjson <- NULL
  metadata <- NULL
  graphdata <- NULL
  axis <- NULL
  xaxis <- NULL
  yaxis <- NULL
  
  graphdata$type <- graphtype
  # Organize data series into "columns" for c3 specs
  columns <- list()
  for (s in seq_along(series)) {
    columns[[s]] <- c(series[s], dt[,s+1])
  }
  graphdata$columns <- columns  
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
  
  write(json, paste("graph-json/", sectionn, "_", graphn, ".json", sep=""))
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
  select(year, cpi_multiplier, appropriations_state, appropriations_local) %>%
  mutate(approp_state_aged = appropriations_state * cpi_multiplier,
         approp_local_aged = appropriations_local * cpi_multiplier)

# Get 2000 values to compare with value by year
state2000 <- fig6$approp_state_aged[fig6$year==2000]
local2000 <- fig6$approp_local_aged[fig6$year==2000]
fig6$approp_state_change <- (fig6$approp_state_aged - state2000)/state2000
fig6$approp_local_change <- (fig6$approp_local_aged - local2000)/local2000
# write.csv(fig6, "data/section2fig6.csv", row.names = F)

# Save data as json
fig6_min <- fig6 %>% select(year, approp_state_change, approp_local_change)

json2_6 <- makeJson(sectionn = 2, graphn = 6, dt = fig6_min, graphtype = "line", series = c("State", "Local"), categories = fig6_min$year, tickformat = "percent", directlabels = FALSE, rotated = FALSE, xtype = "time", xlabel = NULL, ylabel = NULL) 


