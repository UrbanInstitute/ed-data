# Process and format data for higher education site graphs

## Requirements
* R
* Python 3
* IPEDS data downloaded from [scraper] - 1990-latest year

## Graph json creation
For each graph, 1 .json containing data and metadata is needed. These files are stored in [graph-json/](graph-json/) in subfolders organized by main section. The data are retrieved from various sources in [scripts/get-data/](scripts/get-data/) and formatted for particular graphs. To create a formatted json, use the function `makeJson`, found in [scripts/createJsons.R](scripts/createJsons.R).

## Changes from drafts

### Deciles
Many charts in the draft text use weighted means within weighted deciles. We will instead report weighted decile cutoffs in the site - 10th percentile, 20th percentile, etc.

### CPI adjustments and year ranges
Throughout this project, we'll be using dollar amounts over time and aging nominal dollars using the [Consumer Price Index](www.bls.gov/cpi/). The CPI is retrieved via API in [bls.R](scripts/get-data/bls.R). We use the annual average CPI for all items `(CUUS0000SA0)` when aging dollar amounts.
For data such as income, which is reported for a calendar year, use that calendar year's CPI. For data that crosses two years, for example 2000-2001 academic year data, use the CPI for the first year in the range: in this case, 2000 CPI. Always label data accordingly in graphs: axis ticks should say '00-'01, not 2000 or 2001. Fiscal year data, mainly used for appropriations, labels 2000-2001 as fiscal year 2001. In this case, we would use the 2000 CPI and label the data point as '00-'01.

Note about IPEDS years: "2014" data files can contain 2013-2014 or 2014-2015 data depending on subject matter. Check the dictionary created with [the IPEDS scraper](https://github.com/UrbanInstitute/ipeds-scraper) for variable labels, which often specify academic years.

## Data sources
| Source 		| Source type | Script | Content | Sections |
| -------------| -------------  | ------------- | ------------- | ------------- |
| Integrated Postsecondary Education Data System 		| CSV files from scraper | [Scraper repo](https://github.com/UrbanInstitute/ipeds-scraper)  | Institution-level data | Various |
| Bureau of Economic Analysis  | [API](http://www.bea.gov/API/signup/index.cfm) | [bea.R](scripts/get-data/bea.R)  | Per capita personal income, by state and year |  |
| Bureau of Labor Statistics | [API](http://www.bls.gov/developers/) | [bls.R](scripts/get-data/bls.R) | Consumer price index by year | Various |
| State Higher Education Officers Association | [Excel](http://www.sheeo.org/sites/default/files/Unadjusted_Nominal_Data_FY15.xlsx) | [shef.R](scripts/get-data/shef.R) | Appropriations by state and year | Appropriations |
| State and Local Finance Initiative (SLFI) | [Data download tool](http://slfdqs.taxpolicycenter.org/) | [slfi.R](scripts/get-data/slfi.R) | State and local tax totals, by state and year | Appropriations |

### Additional
* PowerStats
