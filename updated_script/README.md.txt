# Creating JSONs

##### Files included in this folder:
- `Codebook for graphtext update.xlsx`: detailed codebook for new and old fields in graphtext
- `Sample_graphtext.xlsx`: (sloppy!) update to graphtext
- `makejsons_update.R`: updated R code (with comments, function headers, etc) to complete these tasks. 
- `Template for data file.xlsx`: walks through how ALL CSV files should be formatted
- `process_graphs.R`: sample wrapper script for this code

Important note: I've tested this code on the first section graphs and an assortment of other files - but will test for about another hour or so Monday morning to make sure I'm not missing any errors. I very well could be - I've been looking at this non-stop for two days!

##### What does this do?
- The workflow described below will convert perfectly formatted CSV files and well-filled-out graphtext options into proper JSONs to graph.
- The workflow encapsulates the **vast** majority of manual changes. Changes left out are described below. 
- The workflow automatically creates **pretty** JSONs - so if you do have to edit them manually, the process should be far easier. 

##### What does this NOT do?
- This will NOT catch multiline formatting - sorry!
- There is one figure (1-1) in production that has a json with data as characters (e.g., "463", "47"). I have no idea why! This script will not replicate that (but if we can read numbers in as strings - let me know. I do something pretty gross in the code to prevent numbers from being refactored and I would love to not worry about that!).
- This will NOT change 0s to "NA" - largely because "NA" gets ported to JSON as "null", and I didn't know if you wanted the text of "NA" or a blank value. If you want a blank value (e.g., null) this is easy enough to fix - or you can update this on the csv end. 
- This will NOT update .jsx files

##### Steps to make JSONs
_Note: The script as written depends on perfectly formatted data and a complete graphtext.xslx file. Notes for both of these files are below, but it is important to check the data csv file and the `graphtext.xslx` file before diving into the R code if something looks "off" to you in the final output._ 
1. Open the wrapper script,`process_graphs.R`. Into this wrapper script, input the proper paths to data files for each section as well as where the graphtext index xslx file lives (and its name!). NB: The name is separate from the file path in case it is standardized across users -- this should make it easier to update. 
2.  Make sure the graphtext file is up to date. "Up to date" means that it has, at minimum, a valid value for **all** of the required fields. For a codebook to which fields are required, please see: `Codebook_for_graphtext_update.xslx`
3.  Quickly check a few csvs to ensure that they are properly formatted. Proper formatting means that all series names and categories appear exactly as you would like them to appear in the final graph. For a guide to how to format each csv, please see: `Template for data file.xslx`
4.  Update the wrapper script. Create function calls for sections 2-7 as shown in section 1. 
5.  Call the wrapper script. JSONs will be generated in the same directory as the data directory for each graph (this is so you can quickly check that the JSON is right, when you have the data at hand). __NOTE TO BEN__: in retrospect, I should've separated this call -- and will do so first thing on Monday. 


##### Fields required by `makeJson()`:
- `section_number`: The section number (e.g., 2, 5). This is one of the two numbers that essentially index this document for our own use.
- `graph_number`: The graph number (e.g., the first multiple of graph 7 would be 71). This is the second index number. 
- `type`: The type of graph this is. Any string is valid - but keep in mind that this looks for keywords "horizontal", "line", and "bar" to make smart decisions.
- `sources`: The sources you want on the graph, EXACTLY as you want them  to appear (with the caveat that new lines will not be read)
-  `title`: The title of the graph, EXACTLY as you want it to appear (same caveat as above - new lines will not be retained)
- `notes`: The notes that you want on the graph, EXACTLY as you want it to appear (same caveat).
- `toggle`: This boolean tells us whether the graph has a toggle option (1) or not (0).
- `data_source`: This is the name of the csv file you want to read in. Whatever the name of the csv file is, you will get a corresponding json file out. In other words, if for whatever reason, you read data in from the file "theskyisblue.csv", you will get a json in the same folder as your data with the filename "theskyisblue.json"
- `direct_labels`: This boolean tells us whether the graph has direct labels (1) or not (0).
- `y_tick_format`: This tells us how to format the axis. These values are contained in the R wrappers that Vivian wrote. 

#### Optional fields for `makeJson()`
_Note: the majority of optional fields address changes that had to be hand-done in the past. As a result, there are many. For additional detail, see the xslx file specified above._
- `subtitle, metadata_subtitle`: adds figure subtitle
- `x_label, y_label`: adds label
- `y_max_value`: number to set max value to
- `x_tick_count, y_tick_count`: number to set tick counts to
- `axis_x_tick_not_multiline`: boolean for false flag
- `y_padding_left, y_padding_right, y_padding_top, y_padding_bottom`: adds padding object to y axis
- `top_level_flags, metadata_flags`: string list of flags to add to the top level or to metadata
- `add_nulls_beginning, add_nulls_end`: adds blank values to categories and to data
- `highlightIndex`: option to highlight a given index
- `top_level_padding_left, top_level_padding_right, top_level_padding_top, top_level_padding_bottom`: adds padding object to top level
- `top_level_width, top_level_height`: adds size object to top level
- `imageOverride`: adds imageOverride flag with title__subtitle
- `colors_dictionary`: reads in list of key:value pairs to add a color dictionary to the data object in JSON


