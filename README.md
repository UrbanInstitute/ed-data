# Higher education site - data collection and processiong

## Data sources
* IPEDS data from [scraper](https://github.com/UrbanInstitute/ipeds-scraper)

### APIs
* [Bureau of Economic Analysis](scripts/bea.R): per capita personal income, by state and year - [incomepc_bea.csv](data/incomepc_bea.csv)
* [BLS](scripts/bls.R): consumer price index by year - [cpi_bls.csv](data/cpi_bls.csv)

### Data download tools
* [SLFI](scripts/slfi.R): state and local tax totals, by state and year - [taxes_slfi.csv](data/taxes_slfi.csv)
* PowerStats

### Direct data (received via email, etc)
* [SHEF](scripts/shef.R): appropriations by state and year - [shef.csv](data/shef.csv)

