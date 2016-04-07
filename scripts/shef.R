# Hannah Recht 04-07-16
# Get data from SHEEO's SHEF State Higher Education Finance
# http://www.sheeo.org/resources/publications/shef-%E2%80%94-state-higher-education-finance-fy14
# Excel file emailed to Martha from source

library(readxl)
library(dplyr)

states <- read.csv("data/states.csv", stringsAsFactors = F, colClasses = "character")
states <- states %>% select(-abbrev)

# HECA - not sure if needed
heca <- read_excel("data/original/SHEF nominal data by state.xlsx", sheet = 2)

# Main SHEF data
shef <- read_excel("data/original/SHEF nominal data by state.xlsx", sheet = 1)
shef <- left_join(shef, states, by=c("State" = "state"))

# Make national rows
national <- shef %>% group_by(FY) %>%
	summarize_each(funs(sum), -fips, -State) %>%
	mutate(fips = "00", State = "United States")
shef <- rbind(shef, national)

# Give some usable colnames
colnames(shef)
colnames(shef) <- c('state', 'year', 'arra', 'appropriations_tax', 'support_nontax', 'support_nonapprop', 
										'earnings_statefundendow', 'other', 'funds_na', 'appropriations_local', 'researchagmed', 
										'studentaid_public', 'studentaid_indepndent', 'studentaid_oos', 'institutions_indep', 'ncce', 
										'operations_public', 'tuitionrevenue_net', 'fte_net', 'appropriations_net', 'revenue_total', 'fips')

# Calculated variables
shef <- shef %>% select(fips, everything()) %>%
	mutate(appropriations_fte = appropriations_net/fte_net,
												appropriations_state = appropriations_net - appropriations_local)

write.csv(shef, "data/shef.csv", row.names = F, na="")