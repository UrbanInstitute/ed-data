# Higher ed site graph creation process

Your first encounter with a graph for the site will likely be an embedded Excel graph in a Word draft. Your job is to evaluate graph layout changes if needed, record graph metadata, and put data into a json for site production. Info on data munging, needed for some graphs, will be included in a separate readme.

## GraphText.xlsx
Metadata about every graph is stored in GraphText.xlsx, in the Production folder on Box. You'll absolutely need access to this file. Change [the file path in createJsons.R ](https://github.com/UrbanInstitute/ed-data/blob/master/scripts/createJsons.R#L9) to the correct location on your machine. I highly recommend using Box Sync in general, but especially for this project.

GraphText contains one row per graph, with some fields that are for your own reference and notes, and others that get used in Json creation. Graphs from most sections of the site will already be entered into GraphText, but you may need to enter some yourself in later sections. Once page/section has been workshopped and had text approved, open the latest draft of the page's Word doc. For each graph, add a new row in GraphText with the following information:

### Columns that are for your reference only
* section: string - name of the section on the site
* page: string - name of the page on the site & Box folder
* needs_data_update: yes/no/unknown - will the data need to be updated before site launch?
* simple_dataset_exists: binary 1/blank - has a researcher made a simple data csv that you'll read in directly to make the json?
 * These CSVs should be placed in the same folder as the Word doc
* submitted: binary 1/blank - change to 1 when you've submitted the graph to keep track
 * You may want to add another value once data updates begin.
* comments: string - notes about the graph for yourself

### Columns that get used in `makeJson`
* section_number: integer - used for json file name and file path
* graph_number: integer - used for json file name and file path.
 * These numbers should go from 1 to N within each section. You'll see some figure numbers in the Word docs. IGNORE THEM ALL. We won't be displaying figure numbers on the site. These numbers are for your use, site production, and file management. It is fine if a Word doc says "Figure 5" and your spreadsheet says 18.
* type: string - valid options include "line", "bar", "horizontal bar", "stacked bar", "grouped bar", "horizontal stacked bar", "horizontal grouped bar", "stacked area"
* multiples: binary 0/1 - used to indicate if the graph has small multiples
* toggle: binary 0/1 - used to indicate if the uses a toggle (dropdown)
* title: string - copy/paste from the Word doc, inserted into the graph json
* notes: string - copy/paste from the Word doc, inserted into the graph json (leave blank if none)
* sources: string - copy/paste from the Word doc, inserted into the graph json
