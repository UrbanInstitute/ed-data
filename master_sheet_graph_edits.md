## MASTER SHEET FOR ALL EDITS MADE BY HAND TO LUMINA JSONS

#SECTION 1: WHAT IS COLLEGE
 - **FOR ALL GRAPHS IN "STUDENTS" SECTION (1-5 THROUGH 1-14), ADD THE FOLLOWING TO TOP LEVEL:**

 ``` "hideTooltip": true ``` 

- **Figure 1-1**
	- add top level flag `"forceMediumHeight": true` 

- **Figure 1-10**
  - add to outermost bracket: ``` "hideTooltip": true ``` 
 
- **Figure 1-11**
	- add `customHideLabelTwo": true` to outermost bracket
  - add to outermost bracket: ``` "hideTooltip": true ``` 

- **Figure 1-12**
	- add `customHideLabelTwo": true` to outermost bracket
  - add to outermost bracket: ``` "hideTooltip": true ``` 

- **Figure 1-13**
  - add to outermost bracket: ``` "hideTooltip": true ``` 

- **Figure 1-14**
  - add to outermost bracket: ``` "hideTooltip": true ``` 


#SECTION 2: COST OF EDUCATING
- **Figure 2-1**
 - add ` "overrideTickCount": true ` to outermost bracket
 - set x.tick.count: 10
 - add single blank data point to beginning and 2 blank data points to end of x.categories
 - add ` null ` to beginning and ` null, null, ` at end of each array of data

- **Figure 2-2**
 - add blank data point (`null`) as last x-value and `""` to categories
 - add `"overrideTickCount": true`, to topmost bracket
 - set tick.count to `8`

- **Figure 2-3**
 - add blank data point (`null`) as last x-value and `""` to categories
 - add `"overrideTickCount": true`, to topmost bracket
 - set tick.count to `9`

- **Figure 2-4**
 - add `"highlightIndex" : 36` to outermost bracket
 - add ` metadata.pluralNotes: true `
 

- **Figure 2-51**
  - for source line of multiples, add ` pluralNotes: "true" ` to jsx file
  - Change Y-axis properties to adjust ticks:

  ```
  "axis": {
    "y": {
      "max": 6000,
    "padding": {"top": 0, "bottom": 0},
    "tick": {
      "format": "dollar",
      "count": 4
    }
  },
  ```

- **Figure 2-52**
 - Change Y-axis properties to adjust ticks:

  ```
    "axis": {
      "y": {
      "max": 1000,
      "padding": {"top": 0, "bottom": 0},
        "tick": {
          "format": "dollar",
          "count": 5
  
        }
      },
  ```

- **Figure 2-53**
 - Change Y-axis properties to adjust ticks:

  ```
      "y": {
     "max": 60000,
      "padding": {"top": 0, "bottom": 0},
        "tick": {
          "format": "dollar",
          "count": 4
  
        }
      }
  ```
- **Figure 2-54**
 - Change Y-axis properties to adjust ticks:

  ```
      "y": {
          "max": 4000,
           "padding": {"top": 0, "bottom": 0},
        "tick": {
          "format": "dollar",
          "count": 5
        }
      }
  ```
    
- **Figure 2-55**
 - Change Y-axis properties to adjust ticks:

  ```
      "y": {
          "max": 30000,
          "padding": {"top": 0, "bottom": 0},
  
        "tick": {
          "format": "dollar",
          "count": 4
        }
      },
  ```

- **Figure 2-61**
 -  add ` "subtitle": "Private nonprofit four-year institutions by share of applicants admitted", ` after title

- **Figure 2-62**
 - add ` "subtitle": "Public four-year institutions by share of applicants admitted" ` after title

- **Figure 2-7**
 - set max y value and ticks

```
    "y": {
      "padding": {"top": 0, "bottom": 0},
      "max": 25000,
      "tick": {
        "format": "dollar",
         "count": 6
      }
    }

```
 - Net tuition category should be on the bottom of the stacked bars
 - for all graphs: add `  "wideSmallMultiple": true ` to outermost bracket

- **Figure 2-8**
 - Net tuition category should be on the bottom of the stacked bars
 - set max y and ticks

 ```
    "y": {
      "padding": {"top":0, "bottom": 0},
      "max": 60000,
      "tick": {
        "format": "dollar",
        "count": 4
      }
    },
```
 - add spacing to xlabels, for example: '01–          '03 
 - add ` pluralNotes: "true" ` to jsx file
 - for all graphs: add `  "wideSmallMultiple": true ` to outermost bracket

- **Figure 2-9**
 - For all multiples, set ticks and max value:

 ```
    "y": {"max": 120000, "padding": {"top":0, "bottom": 0}, "tick": {"format": "dollar", "count": 5}}
 ```

#SECTION 3: PRICES AND EXPENSES

- **Figure 3-1**
	- add to top level  ` "hideTooltip": true `

- **Figure 3-2**
  - add "overrideTickCount": true to outermost bracket
	- add 3 blank data points: `null` at start of each series and `null, null` at end of each series
	- Add `""` to start of categories list and ` "", "" ` to the end
	- Add `axis.x.tick.count: 13`

- **Figure 3-3**
 - add ` axis.x.tick.multiline: false `
 - add ` axis.y.padding.left: 200 `


 
- **Figure 3-4**
 - First graph: added metadata.subtitle: "Public two-year institutions"
 - First graph: added "highlightIndex": 36 to outermost bracket
 - Second graph: added metadata.subtitle: "Public four-year institutions"
 - Second graph: added "highlightIndex": 21 to outermost bracket

- **Figure 3-7**
 - add `"highlightIndex": 27` to outermost bracket

- **Figure 3-8**
 - add `"highlightIndex": 27` to outermost bracket
 - add ` metadata.pluralNotes: true `
 - add ` metadata.pluralSources: true  `

- **Figure 3-11**
 - add `metadata.pluralNotes: true`
 
- **Figure 3-12**
 - add ` "wideSmallMultiple": true ` to outermost bracket
 - add space to x-axis labels for graph 4 so that two-lines: ex- `"'12–     '13'` 
 - set max y value and number of ticks:

  ``` 
  "y": {
    "max": 50000,
    "padding": {"top": 0, "bottom": 0},
    "tick": {
      "format": "dollar",
      "count": 6
    }
  }
  ```
  
- **Figure 3-15**
	- Add top level object `"size":{"height": 320},`
- **Figure 3-17**
 - add ` "padding": {"bottom": 30} ` to outermost bracket

 
- **Figure 3-18** 
 -**FOR ALL GRAPHS:
 ```
   "groups": [
    [
      "25th percentile",
      "Median",
      "75th percentile"
      ]
    ],
  ```

 - **First Set**
  - add ` subtitle="Ages 18–34, by gender and age" ` to jsx file
  - Set max value and change number of ticks for first pair
  
  ```
  "y": {
        "padding": {"top": 0, "bottom": 0},
        "max": 120000,
        "tick": {
          "format": "dollar",
          "count": 4
        }
  }
  ```
 - **Second Set**
  -add ` subtitle = "Ages 18–23, by gender and race and ethnicity" to jsx file
  - Set max value and change number of ticks for second pair
  
 ```
   "y": {
      "padding": {"top": 0, "bottom": 0},
      "max": 80000,
      "tick": {
        "format": "dollar",
        "count": 3
      }
    },
  ```
 - **Third Set**
  -add `subtitle = "Ages 24–34, by gender and race and ethnicity" ` to jsx file
  - Set max value and change number of ticks for third pair

  ```
  "y": {
    "padding": {"top": 0, "bottom": 0},
    "max": 120000,
    "tick": {
      "format": "dollar",
      "count": 4
    }
  },
  ```

- **Figure 3-19**
 - Made hand corrections to x axis ticks. For normal line charts handled in the college-affordability.urban.org repo at:
`college-affordability.urban.org/components/30-components/graphs/graph/graph.jsx`
in various blocks specific to line and area charts. Given that this chart is a single edge case (toggle line chart), made corrections by hand, namely:
    - set `x.tick.count: 14`
    - added empty tick `""` to start and end of x.categories array
    - added empty tick `null` to start and end of each data series array in `data.sets`
    - added "colors": {"25th percentile": "#1696d2", "Median": "#fdbf11", "75th percentile": "#000000"  } to outermost bracket in "data"
    - make sure sets are ordered by 1 and then 2
    - add empty data points to beginning and end of each array of data and "" to beginning and end of categories array
    - make legend items in order of "25th percentile", "Median", "75th percentile"

- **Figure 3-20**
 - To both first and second graphs, add top level `"padding": {"right": 30}`
 - For first graph:
 "y": {
 "padding": {"top":0, "bottom":0},
 "max": 50000,
 "min":-10000,
 "tick": {
 "format": "dollar",
 "count": 7
 }
 },
 - For second graph:
 "y": {
 "padding": {"top": 0, "bottom": 0},
 "max": 1,
 "tick": {
 "format": "percent",
 "count": 5
 }
 }
 - for first graph, add :
  `"subtitle": "Dollars per full-time student" `
 - for second graph, add:
  `subtitle: "Percentage of full-time students" `
 - For both graphs, add 
 ```
  "groups": [
    [
      "Grant aid",
      "Tuition and fees left over"
      ]
    ]
 ```
 - Make "Tuition and fees" first item in legend


- **Figure 3-21**
 - need to add
 
	```
	"groups": [["Tuition and fees covered by grant aid",
	"Remaining (net) tuition and fees","Living expenses covered by grant aid",
	"Remaining (net) living expenses"]]
	```
	 
 - for all graphs, add ` "wideSmallMultiple": true ` to outermost bracket
 - for all graphs, add `"multipleCustomLabelPosition": true` to outermost bracket
 - for all graphs, add `axis.x.label: "Parent Income Quartile"`
 - for all graphs, add 
 
  ``` 
      "y": {
      "max": 50000,
      "padding": {"top": 0, "bottom": 0},
      "tick": {
        "format": "dollar",
        "count": 3

      }
    },
  ```

- **Figure 3-22:**
 - **FOR EACH SET OF MULTIPLES**
	 - 	Add `"subtitle"` in jsx file
 - **First set of multiples**
    - First set of multiples need to add
    
    ```
    "groups":
    [
      [
        "Tuition and fees covered by grant aid",
        "Remaining (net) tuition and fees",
        "Living expenses covered by grant aid",
        "Remaining (net) living expenses"
      ]
    ]
    ```

    - set max y value and ticks:

    ```
    "y": {
      "padding": {"top": 0, "bottom": 0},
      "max": 30000,
      "tick": {
        "format": "dollar",
        "count": 4
      }
    },
    ```
  
 - **Second set of multiples**
      - need to add
 
     ```
     "groups":
       [
        [
        "Tuition and fees covered by grant aid",
        "Remaining (net) tuition and fees",
        "Living expenses covered by grant aid",
        "Remaining (net) living expenses"
        ]
       ]
     ```

    - Also set max y value in first graph:
    `"y": {"padding": {"top": 0, "bottom": 0}, "max": 60000,`

 - **Third set of multiples**
   - set max y value and number of ticks
    
    ```
    "y": {
      "padding": {"top": 0, "bottom": 0},
      "max": 20000,
      "tick": {
        "format": "dollar",
        "count": 5
      }
    },
    ```
 - **Fourth set of multiples**
   - need to add
  
    ```
    "groups":
      [
        [
        "Tuition and fees covered by grant aid",
        "Remaining (net) tuition and fees",
        "Living expenses covered by grant aid",
        "Remaining (net) living expenses"
        ]
      ]
    ```
  
    - need to set max y-value and ticks
    
      ```
      "y": {
        "padding": {"top": 0, "bottom": 0},
        "max": 40000,
        "tick": {
          "count": 5,
          "format": "dollar"
        }
      },
      ```


#SECTION 4: FINANCIAL AID
- **Figure 4-1**
  - add ` "padding": {"bottom": 30} ` to outermost bracket
  - add ` "hideTooltip": true ` to outermost bracket
  - add `"customLabelPosition":true` to outermost bracket

- **Figure 4-2**
  - add `"padding": {"bottom": 60}` to outermost tick

- **Figure 4-4**
 - FOR ALL MULTIPLES: add ` "hideTooltip": true ` to outermost bracket
 - Multiple two, top level flag `"customHideLabelThree": true,`
 - Multiple five, top level flag `"customHideLabelThree": true,`
 
- **Figure 4-6**
 - add ` "hideTooltip": true ` to outermost bracket

- **Figure 4-7 (all multiples)**
 - set max y value and ticks
 
  ```
  "y": {
    "padding": {"top": 0, "bottom": 0},
    "max": 20000,
    "tick": {
      "format": "dollar",
      "count": 5
    }
  }
  ```
 - insert space to x-values after Indepedent or Dependent so that x-values are two lines total


- **Figure 4-8**
 - add top level flag `"customHideLabelFour": true,`
 - had to manually change the ordering of the sets and had to replace `"groups"` aray with:

  ```
    "groups": 
    [
      [
      "Federal",
      "State",
      "Veterans",
      "Institutional",
      "Private"
      ]
    ]
  ```
- **Figure 4-9**
 - **First set of multiples**
   - in jsx file, add ` subtitle= "Dollars per recipient" `
   - for all graphs : add ` "hideTooltip": true ` to outermost bracket
	 - for graph 1, add bracket to single category `"All..."`
	 - for graph 2, add spaces to x-labels to create two lines, for example: `"Less than         $30,000" "$30,000 –       $64,999"`
	 - for graphs 1-3, change number of ticks

	  ```
	  "y": {
	    "max": 8000,
	    "padding": {"top": 0, "bottom": 0},
	    "tick": {
	      "format": "$s",
	      "count": 5
	    }
	  },
  ```
  	 - for all graphs, added top level attribute `"wideSmallMultiple": true`

 - **Second set of multiples**
   - in jsx file, add ` subtitle= "Dollars per full-time student" `
   - for all graphs: add ` "hideTooltip": true ` to outermost bracket
	 - for graph 1, add bracket to single category `"All..."`
	 - for graph 2, add spaces to x-labels to create two lines, for example: `"Less than         $30,000" "$30,000 –       $64,999"`
	 - for graphs 1-3, change number of ticks
	  
	  ```
	  "y": {
	    "max": 6000,
	    "padding": {"top": 0, "bottom": 0},
	    "tick": {
	      "format": "$s",
	      "count": 4
	    }
	  },
	  ```
	  - for all graphs, added top level attribute `"wideSmallMultiple": true`


- **Figure 4-13**
 - add `"highlightIndex" : 18` to outermost bracket

- **Figure 4-14**
 - add highlightIndex": 20 to outermost bracket

- **Figure 4-15**
 - set max y-value and ticks
 
  ```
  "y": {
    "max": 0.4,
    "padding": {"top": 0, "bottom": 0},
    "tick": {
      "format": "percent",
      "count": 5
    }
  },
  ```

 - add spacing to x-values so two lines, for example: `"Public             two-year"`

- **Figure 4-16**

 - add space for x-axis labels in graphs 3 and 5 to make two lines, for example:
 `"Public        two-year"   "$106,000           or more"`

 - set max y-value and number of ticks
 
  ```
  "y": {
    "max": 6000,
    "padding": {"top": 0, "bottom": 0},
    "tick": {
      "format": "$s",
      "count": 4
    }
  }
  ```

- **Figure 4-17**
	- Set `data.groups` to `[["Need-based", "Non-need-based"]],`

- **Figure 4-19**

 - had to manually change groups array to:

```
    "groups": [
      [
        "Institutional grant aid",
        "Remaining (net) tuition and fees"
      ]
    ],
```

- **Figure 4-20**
 - add top level object `"size":{"height" : 300},`
 - had to manually change group array to:

```
  "groups": ["Need-based", "Non-need-based"]
```
 - had to manually change order of sets

 - add ` metadata.pluralNotes:true `
 

- **Figure 4-21**
 - add brackets to single x-categories in 4-211 and 4-212
change y tick values

  ```
  "y": {
    "padding": {"top": 0, "bottom": 0},
    "max": 1800,
    "tick": {
      "format": "dollar",
      "count": 3
    }
  ```

 - make x label two lines, in first two graphs of multiple, in order to widen the graph

 - add ` wideSmallMultiples: true ` to outermost bracket for all graphs



- **Figure 4-22**
 - **for first set of multiples:**
    - add brackets to single category in first graph
    - set y max value and ticks
    
    ```
        "y": {
      "padding": {"top":0, "bottom":0},
      "max": 0.15,
      "tick": {
        "count": 4,
        "format": "percent"
      }
    }
    ```
    - adding spacing to x values in third and fourth graphs to create two lines , for example: 
`"Public          four-year"         "Less than           $30,000"`

 - **for second set of multiples:**
    - add brackets to single category in first graph
    - set y max value and ticks

    ```
    "y": {
      "padding": {
        "top": 0, "bottom": 0
      },
      "max": 0.3,
      "tick": {
        "format": "percent",
        "count": 4
      }
    },
    ```
    
    - adding spacing to x values in third and fourth graphs to create two lines , for example: 
`"Public          four-year"         "Less than           $30,000"`

- **Figure 4-23**
 - **for first set of multiples:**
    - add brackets to single category in first graph
    - set y max value and ticks
      
      ```
      "y": {
        "padding": {"top": 0, "bottom":0},
        "max": 15000,
        "tick": {
          "format": "dollar",
          "count": 4
        }
      }
      ```
    - adding spacing to x values in third and fourth graphs to create two lines , for example: 
`"Public          four-year"         "Less than           $30,000"`

 - **for second set of multiples:**
    - add brackets to single category in first graph
    - set y max value and ticks
   
    ```
    "y": {
      "padding": {"top": 0, "bottom": 0},
      "max": 10000,
      "tick": {
        "format": "dollar",
        "count": 3
      }
    },
    ```
    - adding spacing to x values in third and fourth graphs to create two lines , for example: 
`"Public          four-year"         "Less than           $30,000"`



- **Figure 4-24**
 - change y tick values
 
  ```
   "y": {
        "padding": {"top":0, "bottom": 0},
         "max": 25,
        "tick": {
          "format": "dollar",
          "count": 6
        }
  ```
 - add `"overrideTickCount": true` to outermost bracket


- **Figure 4-26**
 - add ` "padding": {"bottom": 30}` to outermost bracket
 - add ` "hideTooltip": true ` to outermost bracket

- **Figure 4-27**
 - add ` "padding": {"bottom": 30}` to outermost bracket
 - add ` "hideTooltip": true ` to outermost bracket

#SECTION 5: COVERING EXPENSES

- **Figure 5-1 (all multiples)**
 - in first graph, add bracket for x.categories since single category "All families"
 - For x-axis labels, add space between year range and "years", so that they are on two lines, 
#for example: "25-34           years"
 - set max y value and ticks
  ```
      "y": {
        "padding": {"top": 0, "bottom": 0},
        "max": 150000,
        "tick": {
          "count": 3,
          "format": "dollar"
        }
      },
  ```
  
- **Figure 5-3**
 - add   `"highlightIndex" : 25`  to outermost bracket


- **Figure 5-6**
 - make TFRB appear first in the legend
 - add ` metadata.pluralSources: true `

- **Figure 5-8**
  - add `"highlightIndex" : 0`  to outermost bracket
  - custom format (`$XX.XX`), set `data.labels.format` and `axis.t.tick.format` to `"dollarCents"`

- **Figure 5-9**
  - add ` "hideTooltip": true ` to outermost bracket
  - add `"customHideLabel": true` to outermost bracket

- **Figure 5-10**
  - add ` "hideTooltip": true ` to outermost bracket
  - add `"customHideLabel": true` to outermost bracket

- **Figure 5-11**
 - add ` "hideTooltip": true ` to outermost bracket
 - set max y-value and ticks

  ```
  "y": {
    "padding": {"top": 0, "bottom": 0},
    "max": 0.5,
    "tick": {
      "format": "percent",
      "count": 6
    }
  },
  ```
  
- **Figure 5-12**
 - add ` metadata.pluralNotes: true `


- **Figure 5-13**
 - in first graph, add bracket for `x.categories` since single category `"All Undergraduates"`

- **Figure 5-14**
 - add ` "overrideTickCount": true ` to outermost bracket
 - add ` metadata.pluralSources: true `

- **Figure 5-15**
 - for both graphs, add ` "hideTooltip": true ` to top bracket

-**Figure 5-16**
 - add ` "hideTooltip": true ` to top bracket

- **Figure 5-17**
 - add `"wideSmallMultiple":true` to outermost bracket for all three multiples 
 - in the first graph, make x-label three lines by adding spaces in between `"All full-time/ dependent/ students"`
 - in the second graph, make each x-label two lines, so  `"Less than          ....."` or `"$30,000–            ........."` for instance
 - set max y-value and ticks

  ```
      "y": {
        "padding": {"top": 0, "bottom": 0},
        "tick": {
          "count": 3,
          "format": "dollar"
        },
        "max": 32000
      },
  ```
  - in first graph, add ` "padding": {"top": 30}, ` to outermost bracket
- **Figure 5-19**
 - add ` "hideTooltip": true ` to outermost bracket


- **Figure 5-20**
 - add ` "hideTooltip": true ` to outermost bracket

- **Figure 5-21**
 - add ` "hideTooltip": true ` to outermost bracket


- **Figure 5-22**
 - for first graph, set max y value and ticks:

 ```
      "y": {
        "padding": {"top":0 , "bottom":0},
        "max": 500000,
        "tick": {
          "format": "dollar",
          "count": 3
        }
      },
 ```
 - for second graph, set max y value and ticks:
 ```
      "y": {
      "padding": {"top": 0, "bottom": 0},
      "max": 500000,
      "tick": {
        "format": "dollar",
        "count": 3
      }
    },
 ```
 - for both graphs, delete "groups" array

- **Figure 5-25:**
 - add `"overrideTickCount": true` to outermost bracket
 - set `x.ticks.count` to `11`
 - add 4 blank data points (two at beginning and two at end) 
 - add ` "size": {"height": 400} ` to outermost bracket

- **Figure 5-26**
  - add ` "noAxisPadding": true ` to outermost bracket

- **Figure 5-27**
 - change order of arrays in data.columns to match order of series in tooltip

- **Figure 5-26:**
	- add `"customLabelPosition":true` to outermost bracket
	- add `"noAxisPadding":true` to outermost bracket

- **Figure 5-28**
 - add ` "hideTooltip": true ` to outermost bracket
 - add ` "padding": {"bottom": 30}` to outermost bracket

 
#SECTION 6: AFTER COLLEGE
- **Figure 6-200**

 - set groups array to:

 ```
  "groups": [
  [
    "Completed degree at two-year college",
    "Completed Bachelor's degree at four-year college",
    "Still enrolled",
    "Not enrolled"
    ]
  ],

  ```
- **Figure 6-1**
 - add two blank data points, one to beginning and end
 - set max y-value and ticks:

 ```
     "y": {
      "padding": {
        "top": 0, "bottom": 0
      },
      "max": 1,
      "min": 0.5,
      "tick": {
        "format": "percent"
      }
    },
```
 -set x.tick.count to 9
 - add `"overrideTickCount": true` to outermost bracket


- **Figure 6-6**
 - add ` "hideTooltip": true ` to outermost bracket


- **Figure 6-7**
 - add top level `"forceTall": true` to force 900px height
 - add top level `"padding": {"bottom": 30}`
 
- **Figure 6-8**
 - add bracket to `"categories": ["Education Debt"]`


- **Figure 6-10**
- add ` metadata.pluralNotes: true ` to outermost bracket

- **Figure 6-11**
 - add ` metadata.pluralNotes: true ` to outermost bracket

- **Figure 6-12**
 - add ` metadata.pluralNotes: true ` to outermost bracket

- **Figure 6-13**
 - add ` metadata.pluralNotes: true ` to outermost bracket

- **Figure 6-15**
 - add ` metadata.pluralNotes: true ` to outermost bracket

- **Figure 6-20**
 - make x-labels two lines after dash by adding space: `$1,000– / $5,000`

#SECTION 7: STUDENT PROFILES
- **ALL FIGURES IN SECTION**
 - 	add toplevel custom flag to increase chart height, `"forceMediumHeight": true`

- **Figure 7-3**
 - manually arrange sets so that the dropdown is in order of: "Public four-year out-of-state", "Public four-year in-state", "Public two-year", "Private nonprofit four-year", "For-Profit"
 - change 0 to "NA" with regex
   [0]{1}[,]  --> replace with "NA",
  [0]{1}\n  --> replace with "NA"\n
 - had to tweak groups array:

  ```
    "groups": [
    [
    "Private loans", 
    "Institutional grant aid", 
    "Tuition and fees", 
    "State grant aid",
    "Federal grant aid", 
    "Budget beyond tuition and fees", 
    "Expected family contribution", 
    "Military and veterans grant aid", 
    "Private and employer grant aid", 
    "Federal parent loans", 
    "Federal student loans", 
    "Earnings and other resources"
    ]
    ],
  ```
 - manually set colors to avoid duplicates
  
  ```
  "colors": {
    "Expected family contribution": "#848081",
    "Federal grant aid": "#cfe8f3",
    "Military and veterans grant aid": "#a2d4ec",
    "State grant aid": "#73bfe2",
    "Institutional grant aid":"#46abdb",
    "Private and employer grant aid": "#1696d2",
    "Federal student loans": "#fccb41",
    "Federal parent loans": "#fdbf11",
    "Private loans": "#fce39e",
    "Earnings and other resources": "#d5d5d4",
    "Tuition and fees": "#ec008b",
    "Budget beyond tuition and fees": "#000000"
  },
  ```
- **Figure 7-4**
 - manually arrange sets so that the dropdown is in order of: "Public four-year out-of-state", "Public four-year in-state", "Public two-year", "Private nonprofit four-year", "For-Profit"
 - had to manually set order of years for each toggle category so that years are ascending
  -for example: 

   ``` 
   "For-profit",
        [
          [
            "2 years",
            28295.96,
            18434.976
          ],
          [
            "3 years",
            42443.94,
            27652.464
          ],
          [
            "4 years",
            56591.92,
            36869.952
          ],
          [
            "5 years",
            70739.9,
            46087.44
          ],
          [
            "6 years",
            84887.88,
            55304.928
          ]

        ]
      ],
  ```

- **Figure 7-7**
 - manually arrange sets so that the dropdown is in order of: "Public four-year out-of-state", "Public four-year in-state", "Public two-year", "Private nonprofit four-year", "For-Profit"
 - change 0 to "NA" with regex
   [0]{1}[,]  --> replace with "NA",
   [0]{1}\n  --> replace with "NA"\n
 - had to change groups array:

  ```
    "groups": [
      [
        "Private loans", 
        "Institutional grant aid", 
        "Tuition and fees", 
        "State grant aid",
        "Federal grant aid", 
        "Budget beyond tuition and fees", 
        "Expected family contribution", 
        "Military and veterans grant aid", 
        "Private and employer grant aid", 
        "Federal parent loans", 
        "Federal student loans", 
        "Earnings and other resources"
        ]
      ],
  ```
 - manually set colors: 
 ```
     "colors": {
      "Expected family contribution": "#848081",
      "Federal grant aid": "#cfe8f3",
      "Military and veterans grant aid": "#a2d4ec",
      "State grant aid": "#73bfe2",
      "Institutional grant aid":"#46abdb",
      "Private and employer grant aid": "#1696d2",
      "Federal student loans": "#fccb41",
      "Federal parent loans": "#fdbf11",
      "Private loans": "#fce39e",
      "Earnings and other resources": "#d5d5d4",
      "Tuition and fees": "#ec008b",
      "Budget beyond tuition and fees": "#000000"
      }
  ```
- **Figure 7-8**
 - manually arrange sets so that the dropdown is in order of: "Public four-year out-of-state", "Public four-year in-state", "Public two-year", "Private nonprofit four-year", "For-Profit"
 - had to manually set order of years for each toggle category so that years are ascending

- **Figure 7-11**
 - manually arrange sets so that the dropdown is in order of: "Public four-year out-of-state", "Public four-year in-state", "Public two-year", "Private nonprofit four-year", "For-Profit"
 - change 0 to "NA" with regex
  [0]{1}[,]  --> replace with "NA",
  [0]{1}\n  --> replace with "NA"\n
 - need to change groups array to:
 
  ```
  "groups": [
    [
      "Private loans", 
      "Institutional grant aid", 
      "Tuition and fees", 
      "State grant aid",
      "Federal grant aid", 
      "Budget beyond tuition and fees", 
      "Expected family contribution", 
      "Military and veterans grant aid", 
      "Private and employer grant aid", 
      "Federal parent loans", 
      "Federal student loans", 
      "Earnings and other resources"
      ]
    ],
  ```

 - need to set colors manually to avoid duplicates
  ```
  "colors": {
    "Expected family contribution": "#848081",
    "Federal grant aid": "#cfe8f3",
    "Military and veterans grant aid": "#a2d4ec",
    "State grant aid": "#73bfe2",
    "Institutional grant aid":"#46abdb",
    "Private and employer grant aid": "#1696d2",
    "Federal student loans": "#fccb41",
    "Federal parent loans": "#fdbf11",
    "Private loans": "#fce39e",
    "Earnings and other resources": "#d5d5d4",
    "Tuition and fees": "#ec008b",
    "Budget beyond tuition and fees": "#000000"
  },
  ```
- **Figure 7-12**
 - manually arrange sets so that the dropdown is in order of: "Public four-year out-of-state", "Public four-year in-state", "Public two-year", "Private nonprofit four-year", "For-Profit"
 - had to manually set order of years for each toggle category so that years are ascending

- **Figure 7-15**
 - manually arrange sets so that the dropdown is in order of: "Public four-year out-of-state", "Public four-year in-state", "Public two-year", "Private nonprofit four-year", "For-Profit"
 - change 0 to "NA" with regex
  [0]{1}[,]  --> replace with "NA",
  [0]{1}\n  --> replace with "NA"\n
 - need to change groups array to:
 
  ```
  "groups": [
    [
    "Private loans", 
    "Institutional grant aid", 
    "Tuition and fees", 
    "State grant aid",
    "Federal grant aid", 
    "Budget beyond tuition and fees", 
    "Expected family contribution", 
    "Military and veterans grant aid", 
    "Private and employer grant aid", 
    "Federal parent loans", 
    "Federal student loans", 
    "Earnings and other resources"
      ]
    ],
  ```
   
 - need to change colors to avoid duplicates
 
  ```
  "colors": {
  "Expected family contribution": "#848081",
  "Federal grant aid": "#cfe8f3",
  "Military and veterans grant aid": "#a2d4ec",
  "State grant aid": "#73bfe2",
  "Institutional grant aid":"#46abdb",
  "Private and employer grant aid": "#1696d2",
  "Federal student loans": "#fccb41",
  "Federal parent loans": "#fdbf11",
  "Private loans": "#fce39e",
  "Earnings and other resources": "#d5d5d4",
  "Tuition and fees": "#ec008b",
  "Budget beyond tuition and fees": "#000000"
  },
  ```

- **Figure 7-16**
 - manually arrange sets so that the dropdown is in order of: "Public four-year out-of-state", "Public four-year in-state", "Public two-year", "Private nonprofit four-year", "For-Profit"
 - had to manually set order of years for each toggle category so that years are ascending


- **Figure 7-19**
 - manually arrange sets so that the dropdown is in order of: "Public four-year out-of-state", "Public four-year in-state", "Public two-year", "Private nonprofit four-year", "For-Profit"
 - change 0 to "NA" with regex
  [0]{1}[,]  --> replace with "NA",
  [0]{1}\n  --> replace with "NA"\n

  ```
  "groups": [
    [
    "Private loans", 
    "Institutional grant aid", 
    "Tuition and fees", 
    "State grant aid",
    "Federal grant aid", 
    "Budget beyond tuition and fees", 
    "Expected family contribution", 
    "Military and veterans grant aid", 
    "Private and employer grant aid", 
    "Federal parent loans", 
    "Federal student loans", 
    "Earnings and other resources"
      ]
    ],
  ```
   
 - need to set colors to avoid duplicates
 
  ```
  "colors": {
  "Expected family contribution": "#848081",
  "Federal grant aid": "#cfe8f3",
  "Military and veterans grant aid": "#a2d4ec",
  "State grant aid": "#73bfe2",
  "Institutional grant aid":"#46abdb",
  "Private and employer grant aid": "#1696d2",
  "Federal student loans": "#fccb41",
  "Federal parent loans": "#fdbf11",
  "Private loans": "#fce39e",
  "Earnings and other resources": "#d5d5d4",
  "Tuition and fees": "#ec008b",
  "Budget beyond tuition and fees": "#000000"
  },
  ```

- **Figure 7-20**
 - manually arrange sets so that the dropdown is in order of: "Public four-year out-of-state", "Public four-year in-state", "Public two-year", "Private nonprofit four-year", "For-Profit"
 - had to manually set order of years for each toggle category so that years are ascending