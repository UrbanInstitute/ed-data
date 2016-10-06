# Process and format data for higher education site graphs

## Requirements
* R
* Python 3
* Access to Box production folder

## Detailed documentation
* [Setting up your machine](setup.md)
* [Working with IPEDS data](ipedsdata.md)
* [Creating graph jsons](graphcreation.md)

## Data sources
Most of the data in this project is calculated using the Integrated Postsecondary Education System, or [IPEDS](http://nces.ed.gov/ipeds/datacenter/DataFiles.aspx). IPEDS data is downloaded using a  [scraper](https://github.com/UrbanInstitute/ipeds-scraper) for 1990-latest year available. The data is divided into several hundred CSVs, each covering a topic area for one year. See the scraper repo for more info.

We also use various other data sources, listed and linked below.

| Source 		| Source type | Script | Content | Sections |
| -------------| -------------  | ------------- | ------------- | ------------- |
| Integrated Postsecondary Education Data System 		| CSV files from scraper | [Scraper repo](https://github.com/UrbanInstitute/ipeds-scraper)  | Institution-level data | Various |
| Bureau of Economic Analysis  | [API](http://www.bea.gov/API/signup/index.cfm) | [bea.R](scripts/get-data/bea.R)  | Per capita personal income, by state and year |  |
| Bureau of Labor Statistics | [API](http://www.bls.gov/developers/) | [bls.R](scripts/get-data/bls.R) | Consumer price index by year | Various |
| State Higher Education Officers Association | [Excel](http://www.sheeo.org/sites/default/files/Unadjusted_Nominal_Data_FY15.xlsx) | [shef.R](scripts/get-data/shef.R) | Appropriations by state and year | Appropriations |
| State and Local Finance Initiative (SLFI) | [Data download tool](http://slfdqs.taxpolicycenter.org/) | [slfi.R](scripts/get-data/slfi.R) | State and local tax totals, by state and year | Appropriations |
| National Post-Secondary Aid Study (NPSAS) | [Data download tool](https://nces.ed.gov/datalab/) | [processingExistingDatasets.R](scripts/processingExistingDatasets.R) | | Various |
