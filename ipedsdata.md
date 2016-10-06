# Working with IPEDS data

## Getting data
In this project, we use institution-level data from the Integrated Postsecondary Education Data System (IPEDS), grabbed from the IPEDS Complete Data Files. There isn't a direct link to that page, but go to [http://nces.ed.gov/ipeds/datacenter/login.aspx?gotoReportId=7](http://nces.ed.gov/ipeds/datacenter/login.aspx?gotoReportId=7) and press "Continue". Then press "Continue" again and you'll see a table of data file information appear.

To get all this data onto your computer, we use the [IPEDS scraper](https://github.com/UrbanInstitute/ipeds-scraper). This will need to be run after IPEDS data updates. A developer with Python on their computer (Alex or Ben) will run this scraper when needed and put the data on to a shared drive. Copy that data on to your machine.

## Retrieving data
To use the IPEDS complete data files, you'll use a set of functions stored in [ipedsFunctions.R](scripts/ipedsFunctions.R). The functions in this script are used to read in IPEDS dataset metadata (what datasets exist and what's in them) and to read in and join IPEDS data for analysis.
First, go to line 10 of that file and change `ipedspath` to be the location of your IPEDS data folder.
```R
# Change the right-hand side!
ipedspath <- "/Users/hrecht/Documents/ipeds-scraper/"
```
Then, when writing a new R script to use IPEDS data, source ipedsFunctions.R at the top of your script.
```R
source("scripts/ipedsFunctions.R")
```
This will run through the whole ipedsFunctions script and load the functions and datasets into your R environment.

## Analyzing data

## Changes from draft graphs

### Deciles
Many charts in the draft text use weighted means within weighted deciles. We will instead report weighted decile cutoffs in the site - 10th percentile, 20th percentile, etc.

## Weights
Various sections using IPEDS data weight institutions by FTE enrollment - total, undergrad, or graduate. Some Stata code drafts use IPEDS "derived" variables that are unavailable in the complete data files. For weighting consistency, and to use available variables, use `fte12mn`, `fteug`, or `ftegd` unless a compelling reason exists to use the derived variables. These variables are retrieved and saved in [ipeds12monthenrollment.R](scripts/get-data/ipeds12monthenrollment.R)

### CPI adjustments and year ranges
Throughout this project, we'll be using dollar amounts over time and aging nominal dollars using the [Consumer Price Index](www.bls.gov/cpi/). The CPI is retrieved via API in [bls.R](scripts/get-data/bls.R). We use the annual average CPI for all items `(CUUS0000SA0)` when aging dollar amounts.
For data such as income, which is reported for a calendar year, use that calendar year's CPI. For data that crosses two years, for example 2000-2001 academic year data, use the CPI for the first year in the range: in this case, 2000 CPI. Always label data accordingly in graphs: axis ticks should say '00-'01, not 2000 or 2001. Fiscal year data, mainly used for appropriations, labels 2000-2001 as fiscal year 2001. In this case, we would use the 2000 CPI and label the data point as '00-'01.

Note about IPEDS years: "2014" data files can contain 2013-2014 or 2014-2015 data depending on subject matter. Check the dictionary created with [the IPEDS scraper](https://github.com/UrbanInstitute/ipeds-scraper) for variable labels, which often specify academic years.

### Sector names
Formatted college groups to use in graph labels:
#### Carnegie classifications
* Public research
* Public master's
* Public associate's
* Private nonprofit research
* Private nonprofit master's
* Private nonprofit bachelor's
* For profit
* Small groups

#### Sector classifications
* Public two-year
* Public four-year
* Private nonprofit four-year
* For profit
* Other
* Non-degree-granting