# Higher ed site graph creation process

Your first encounter with a graph for the site will likely be an embedded Excel graph in a Word draft. Your job is to evaluate graph layout changes if needed, record graph metadata, and put data into a json for site production. Info on data munging, needed for some graphs, will be included in a separate readme.

## GraphText.xlsx
Metadata about every graph is stored in GraphText.xlsx, in the Production folder on Box. You'll absolutely need access to this file. Change [the file path in createJsons.R ](https://github.com/UrbanInstitute/ed-data/blob/master/scripts/createJsons.R#L9) to the correct location on your machine. I highly recommend using Box Sync in general, but especially for this project.

GraphText contains one row per graph, with some fields that are for your own reference and notes, and others that get used in Json creation. Graphs from most sections of the site will already be entered into GraphText, but you may need to enter some yourself in later sections. Once page/section has been workshopped and had text approved, open the latest draft of the page's Word doc. For each graph, add a new row in GraphText with the following information:

### Columns that get used in `makeJson`
* section_number: integer - used for json file name and file path
* graph_number: integer - used for json file name and file path.
 * These numbers should go from 1 to N within each section. You'll see some figure numbers in the Word docs. IGNORE THEM ALL. We won't be displaying figure numbers on the site. These numbers are for your use, site production, and file management. It is fine if a Word doc says "Figure 5" and your spreadsheet says 18.
 * If a graph is added or deleted at a later date, and you've already made the other jsons in the section, it may be easier to not renumber the other graphs. E.g. if 03_0070 gets cut and the graphs skip from 03_0060 to 03_0080, that's fine. If an additional graph gets added at a late stage, you can give it a number that hasn't yet been used in the section - 50/90/whatever. It's okay if it's out of order as long as it's clear where it belongs. Note it for site production. The numbers will not be seen by readers so it shouldn't matter much.
* type: string - valid options include "line", "bar", "horizontal bar", "stacked bar", "grouped bar", "horizontal stacked bar", "horizontal grouped bar", "stacked area"
* multiples: binary 0/1 - used to indicate if the graph has small multiples
* toggle: binary 0/1 - used to indicate if the uses a toggle (dropdown)
* title: string - copy/paste from the Word doc, inserted into the graph json
 * Many will need editing in the quality control phase
* notes: string - copy/paste from the Word doc, inserted into the graph json (leave blank if none)
 * Many will need editing in the quality control phase
* sources: string - copy/paste from the Word doc, inserted into the graph json
 * any text formatting such as italics or adding links in the sources should be coded directly in html form into the source column. For example, if the source is "Trends in Student Aid" and this needs to be italicized, then this should be " `<em>`Trends in Student Aid`<em>` ".
 * You'll see some source notes in Word docs that are inconsistent. A good example is IPEDS - you'll see it written in multiple ways. In general, standardize the main data sources within this spreadsheet. Put "Integrated Postsecondary Education Data System" for IPEDS, "National Postsecondary Student Aid Study 2012" for NPSAS, etc. In the quality control phase, editorial staff may change the formatting. You can then find & replace within this spreadsheet and change all the IPEDS notes at once.

### Columns that are for your reference only
* section: string - name of the section on the site
* page: string - name of the page on the site & Box folder
* needs_data_update: yes/no/unknown - will the data need to be updated before site launch?
* simple_dataset_exists: binary 1/blank - has a researcher made a simple data csv that you'll read in directly to make the json?
 * These CSVs should be placed in the same folder as the Word doc
* submitted: binary 1/blank - change to 1 when you've submitted the json to keep track
 * You may want to add another value once data updates begin.
* comments: string - notes about the graph for yourself

## How to make a graph json
* Once you have your [machine set up](setup.md) and the Box folder synced to your computer, clone this repo.
* Change [the file path in createJsons.R ](https://github.com/UrbanInstitute/ed-data/blob/master/scripts/createJsons.R#L9) to the correct location on your machine.
* Open GraphText.xlsx and find the row corresponding to the graph you want to make.
* On Box, navigate to the folder containing the corresponding draft Word document (section name_page name) and open the latest Word doc.
* Find the graph within the Word document. If the graph title or notes are different than in GraphText.xlsx (they might be newly copyedited) copy and paste the new versions into the corresponding row in GraphText.xlsx
* Open up R and if none exists yet, make a new script for the section or page. Organization is up to you, just be consistent and use lots of comments so you or Ben can find the right code later as needed.
* Read in the data CSV(s) that go with your graph. These should be stored in the same Box folder as the Word document.
* Use the function `makeJson` to create a JSON for the graph. Look at the Word document graph draft and GraphText.xlsx row and note the following things:
	* From GraphText.xlsx - What are the section number and graph number? 
	* From GraphText.xlsx - Is the graph horizontal bars? If yes, `rotated = TRUE`
	* Is the general graph type bar, line or area? `graphtype` is one of those options.
	* What type of number formatting do you need? `tickformat` is "number", "percent", "dollar" or a d3.format string.
	* Should the bars have direct labels on them? If yes, `directlabels = TRUE`. This should not be true for line charts.
	* What are the data series names? These will go into legends (if more than one series) and tooltips.
	* See [createJsons.R](https://github.com/UrbanInstitute/ed-data/blob/master/scripts/createJsons.R) for full options definitions.
* From the data you've read in from the CSV, you'll generally use a column/vector for the `categories` argument. This generally corresponds to the X axis labels. For example, the values might be '03-'04, '04-'05, '05-'06 etc in a line chart. In the example below, the category column is "Sector".
* If your data contains one series - e.g. a simple bar chart or a single line chart, use a column/vector for the data argument. Example: `dt = mydata$tuition`
* If your chart contains multiple series - e.g. a stacked bar chart or multi-line chart, as opposed to a simple bar chart or single line chart, your data should be a data frame with one column per series. See below example. If needed, move the categories column as determined above (axis labels) to be the leftmost column. For the dt (data) argument, put the name of the data frame. This will take all columns besides the first and save each as a new "column" in your JSON (c3.js nomenclature). Your series option and data frame columns need to be in the same order. Reorder your data frame or the series list if needed.


An example from [scripts/processExistingDatasets.R](scripts/processExistingDatasets.R):
```R
source("scripts/createJsons.R")

# Change this!
boxpath <- "/Users/hrecht/Box Sync/COMM/**Project Folders**/College Affordability (Lumina) Project/**Production/"

########################################################################################################
# Prices and Expenses
########################################################################################################
# Room and Board
# Stacked horizontal bars
fig3_5 <- read.csv(paste(boxpath, "Prices and expenses_room and board/Section3_LivingArrangementofFTUG.csv", sep = ""), stringsAsFactors = F)

fig3_5
#                      Sector OnCampus OffCampus LiveWithParents
#                         All     0.22      0.46            0.33
#            Public four-year     0.56      0.24            0.20
#             Public two-year     0.33      0.39            0.28
# Private nonprofit four-year     0.03      0.52            0.45
#                  For profit     0.01      0.66            0.33

json3_5 <- makeJson(sectionn = 3, graphn = 5, 
	dt = fig3_5, 
	graphtype = "bar", 
	series = c("On campus", "Off campus", "Living with parents"), 
	categories = fig3_5$Sector, 
	tickformat = "percent", 
	rotated = TRUE, 
	directlabels = TRUE)
```

The output of this script is:
``` javascript
{
	"series": ["On campus", "Off campus", "Living with parents"],
	"axis": {
		"rotated": true,
		"x": {
			"type": "category",
			"categories": ["All", "Public four-year", "Public two-year", "Private nonprofit four-year", "For profit"]
		},
		"y": {
			"tick": {
				"format": "percent"
			}
		}
	},
	"metadata": {
		"source": "National Postsecondary Student Aid Study 2012, Power Stats",
		"notes": null
	},
	"title": "Living Arrangements of Full-Time Undergraduates, 2011-12",
	"data": {
		"columns": [
			["On campus", 0.22, 0.56, 0.33, 0.03, 0.01],
			["Off campus", 0.46, 0.24, 0.39, 0.52, 0.66],
			["Living with parents", 0.33, 0.2, 0.28, 0.45, 0.33]
		],
		"type": "bar",
		"groups": [
			["On campus", "Off campus", "Living with parents"]
		],
		"labels": {
			"format": "percent"
		}
	}
}
```
