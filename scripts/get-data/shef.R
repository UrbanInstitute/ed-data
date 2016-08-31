# Get data from the State Higher Education Officers Association SHEF (State Higher Education Finance)
# http://www.sheeo.org/projects/shef-fy15

library(openxlsx)
library(dplyr)
library(stringr)

# OLD DATA
# Excel file emailed to Martha from source
# shef <- read_excel("data/original/SHEF nominal data by state.xlsx", sheet = 1)

states <- read.csv("data/states.csv", stringsAsFactors = F, colClasses = "character")
states <- states %>% select(-abbrev)

# Download FY 2015 report data (released May 2016)
download.file("http://www.sheeo.org/sites/default/files/Unadjusted_Nominal_Data_FY15.xlsx","data/original/SHEF_Unadjusted_Nominal_Data_FY15.xlsx")
# Excel file uses multi-row merged col heads...when new data is released, make sure to double check col heads and rows needed
shef <- readWorkbook("data/original/SHEF_Unadjusted_Nominal_Data_FY15.xlsx", startRow = 8)
# Column names
shef <- shef %>% rename(appropriations_local = X10, appropriations_net = X12, enrollment_fte = X16, state = State, year_fiscal = FY) %>%
  select(state, year_fiscal, appropriations_local, appropriations_net, enrollment_fte) %>%
  # Calculated variable - state appropriations. Shef has a similar column but they subtract some research money, which we don't want to do.
  mutate(appropriations_state = appropriations_net - appropriations_local) %>%
  # Note: 2015 version of file contains US rows but calculates them differently
  filter(state != "US")
  
# Join to fips codes
shef <- left_join(shef, states, by="state")

# Make national rows
national <- shef %>% group_by(year_fiscal) %>%
	summarize_each(funs(sum), -fips, -state) %>%
	mutate(fips = "00", state = "United States")

shef <- rbind(shef, national)

# Fiscal year 2010 = 2009-2010: so based on our income inflation rules we'll be using the 2009 CPI for FY 2010
# We'll want axis ticks to be labelled as '09-'10
shef <- shef %>% mutate(year_cpi = year_fiscal - 1, 
                        year_axis = paste("'", str_sub(year_cpi, start = -2), "–'", str_sub(year_fiscal, start = -2), sep=""))

########################################################################################################
# Add cpi to age dollar amounts to latest data year
########################################################################################################
cpi <- read.csv("data/cpi_bls.csv", stringsAsFactors = F)
cpi <- cpi %>% select(year, cpi_all)

cpi2014 <- cpi$cpi_all[cpi$year==2014]
shef <- left_join(shef, cpi, by=c("year_cpi" = "year"))
shef$cpi_multiplier = cpi2014/shef$cpi_all

# Use cpi to age dollar amounts to latest data year

shef <- shef %>% mutate(approp_state_aged = appropriations_state * cpi_multiplier,
                        approp_local_aged = appropriations_local * cpi_multiplier)
# State and local ppropriations per FTE student
shef <- shef %>% mutate(approp_perstudent_aged = (approp_state_aged + approp_local_aged)/enrollment_fte,
                        approp_statelocal_aged = approp_state_aged + approp_local_aged)

shef <- shef %>% arrange(fips, year_fiscal)
write.csv(shef, "data/shef.csv", row.names = F, na="")

########################################################################################################
# Section 2 - producing education, appropriations page
# Graph data
########################################################################################################
source("scripts/createJsons.R")
shef <- read.csv("data/shef.csv", stringsAsFactors = F, colClasses = c("fips" = "character"))

# Change in X since 2000 - national level
changedt <- shef %>% filter(fips=="00")

# Get 2000 values to compare with value by year
# Figure 1: Change in appropriations, enrollment, and appropriations per student over time
approp2000 <- changedt$approp_statelocal_aged[changedt$year_fiscal==2000]
appps2000 <- changedt$approp_perstudent_aged[changedt$year_fiscal==2000]
fte2000 <- changedt$enrollment_fte[changedt$year_fiscal==2000]
changedt$approp_statelocal_change <- (changedt$approp_statelocal_aged - approp2000)/approp2000
changedt$approp_perstudent_change <- (changedt$approp_perstudent_aged - appps2000)/appps2000
changedt$approp_fte_change <- (changedt$enrollment_fte - fte2000)/fte2000

fig1_min <- changedt %>% select(year_axis, approp_statelocal_change, approp_perstudent_change, approp_fte_change)

json2_1 <- makeJson(sectionn = 2, graphn = 1, dt = fig1_min, graphtype = "line", 
                    series = c("State and local appropriations", "State and local appropriations per FTE student", "Public FTE enrollment"), 
                    categories = fig1_min$year_axis, tickformat = "percent", directlabels = FALSE, rotated = FALSE, xtype = "category",
                    xlabel = NULL, ylabel = NULL)

# Figure 3: Changes from FY 2000 in state and local support for higher education
state2000 <- changedt$approp_state_aged[changedt$year_fiscal==2000]
local2000 <- changedt$approp_local_aged[changedt$year_fiscal==2000]
changedt$approp_state_change <- (changedt$approp_state_aged - state2000)/state2000
changedt$approp_local_change <- (changedt$approp_local_aged - local2000)/local2000

# State and local support for higher education: use appropriations_tax (state) and appropriations_local
fig3_min <- changedt %>% select(year_axis, approp_state_change, approp_local_change)

json2_3 <- makeJson(sectionn = 2, graphn = 3, dt = fig3_min, graphtype = "line", series = c("State", "Local"), 
                    categories = fig3_min$year_axis, tickformat = "percent", directlabels = FALSE, rotated = FALSE, xtype = "category",
                    xlabel = NULL, ylabel = NULL)

########################################################################################################
# Figure 2: Tax appropriations for higher education as a percentage of state and local tax revenues
# Tax revenues from SLFI data
########################################################################################################

slfi <- read.csv("data/taxes_slfi.csv", stringsAsFactors = F, colClasses = c("fips" = "character"))
slfi <- slfi %>% filter(fips=="00")

# Join to shef data to get appropriations/taxes - don't need aged bc just percent
fig2 <- shef %>% filter(fips=="00") %>% select(-fips)
fig2 <- left_join(fig2, slfi, by = c("year_fiscal" = "year"))

fig2 <- fig2 %>% mutate(approp_pertax = (appropriations_local + appropriations_state)/(taxes_local + taxes_state)) %>%
  filter(year_fiscal <= 2013)

json2_2 <- makeJson(sectionn = 2, graphn = 2, dt = fig2$approp_pertax, graphtype = "line", series = "Appropriations per tax revenue", 
                    categories = fig2$year_axis, tickformat = "percent", directlabels = FALSE, rotated = FALSE, xtype = "category",
                    xlabel = NULL, ylabel = NULL)


########################################################################################################
# Figure 4: State and Local Appropriations for Public Higher Education per Public FTE Student, latest year
# Horizontal bar chart by state
########################################################################################################

fig4 <- shef %>% filter(year_fiscal == 2015) %>%
  arrange(-desc(approp_perstudent_aged))

json2_4 <- makeJson(sectionn = 2, graphn = 4, dt = fig4$approp_perstudent_aged, graphtype = "bar", series = "Appropriations per FTE", 
                    categories = fig4$state, tickformat = "dollar", directlabels = TRUE, rotated = TRUE, xtype = "category",
                    xlabel = NULL, ylabel = NULL)