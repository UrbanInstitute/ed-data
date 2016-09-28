# Prices and Expenses: Tuition and Fees - IPEDS data
# Logic by Martha Johnson - original Stata code in "IPEDS_Sticker prices_clean.do"

library(dplyr)
library(Hmisc)

source("scripts/ipedsFunctions.R")
source("scripts/createJsons.R")

institutions <- read.csv("data/ipeds/institutions.csv", stringsAsFactors = F)