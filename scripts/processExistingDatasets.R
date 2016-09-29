# Make jsons from preprocessed csv/excel datasets - numbers from various sources collected by Martha Johnson, Victoria Lee, Sandy Baum

library(dplyr)
source("scripts/createJsons.R")

# Prices and Expenses: Room and Board
# TODO change to Box file path
fig3_5 <- read.csv("/Users/Hannah/Desktop/Section3_LivingArrangementofFTUG.csv", stringsAsFactors = F)

json3_5 <- makeJson(sectionn = 3, graphn = 5, dt = fig3_5, graphtype = "bar", 
										 series = c("On campus", "Off campus", "Living with parents"), 
										 graphtitle = "Research institutions", categories = fig3_5$Sector, tickformat = "percent", rotated = TRUE, directlabels = TRUE, xtype = "category")