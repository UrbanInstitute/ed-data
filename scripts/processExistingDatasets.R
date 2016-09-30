# Make jsons from preprocessed csv/excel datasets - numbers from various sources collected by Martha Johnson, Victoria Lee, Sandy Baum

library(dplyr)
library(stringr)
source("scripts/createJsons.R")

boxpath <- "/Users/hrecht/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) Project/**Production/"

########################################################################################################
# Prices and Expenses
########################################################################################################
# Room and Board
# Stacked horizontal bars
fig3_5 <- read.csv(paste(boxpath, "Prices and expenses_room and board/Section3_LivingArrangementofFTUG.csv", sep = ""), stringsAsFactors = F)

json3_5 <- makeJson(sectionn = 3, graphn = 5, dt = fig3_5, graphtype = "bar", 
										 series = c("On campus", "Off campus", "Living with parents"), 
										 graphtitle = "Research institutions", categories = fig3_5$Sector, tickformat = "percent", rotated = TRUE, directlabels = TRUE, xtype = "category")

# Net price - small multiples separated by toggle
# Stacked horizontal bars
fig3_21a <- read.csv(paste(boxpath, "Prices and expenses_net price/Section3_NetTFandLivingExpen.csv", sep = ""), stringsAsFactors = F)
fig3_21b <- read.csv(paste(boxpath, "Prices and expenses_net price/Section3_NetTFandLivingExpen-Percent.csv", sep = ""), stringsAsFactors = F)
fig3_21 <- left_join(fig3_21a, fig3_21b, by="group")
colnames(fig3_21) <- tolower(colnames(fig3_21))

# Split labels
fig3_21  <- fig3_21 %>% separate(group, sep="_", c("carnegie", "label"), extra = "merge") %>%
	mutate(label = str_replace_all(label, "_", " "))
