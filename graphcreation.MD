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