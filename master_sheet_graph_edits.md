## MASTER SHEET FOR ALL EDITS MADE BY HAND TO LUMINA JSONS

#SECTION 1: WHAT IS COLLEGE


#SECTION 2: COST OF EDUCATING

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
 
- **Figure 2-7**:
 -  for all multiples, add spaces to x-axis labels to create two lines, for example: `"'01'–        '02'"`

- **Figure 2-51**
  - : Change Y-axis properties to adjust ticks:

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
 - Change Y-axis properties to adjust ticks:

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
- **Figure 2-62**
 - Change Y-axis properties to adjust ticks:

  ```
          "y": {
       "padding": {"top": 0, "bottom": 0},
       "max": 1000,
        "tick": {
          "format": "dollar",
          "count": 5
        }
      }
  ```

- **Figure 2-7**
 - for all multiples, add spaces to x-axis labels to create two lines, for example: "'01'–        '02'"
 - set max y value and ticks

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


#SECTION 3: PRICES AND EXPENSES
- **Figure 3-4**
 - added top level `"padding":{"bottom": 30}`


- **Figure 3-3 (all multiples)**
 -  manually change color for each to avoid automated repeating colors

  ```
     "colors": {
      "Lowest decile": "#cfe8f3", 
      "2nd":"#a2d4ec", 
      "3rd":"#73bfe2", 
      "4th": "#5eb5de", 
      "5th":"#46abdb", 
      "6th": "#2da0d6", 
      "7th": "#1696d2", 
      "8th": "#12719e", 
      "9th": "#0a4c6a", 
      "Highest decile": "#062635"
     },
  ```

- **Figure 3-4**
 - add `"highlightIndex": 34` to outermost bracket

- **Figure 3-7**
 - add `"highlightIndex": 27` to outermost bracket

- **Figure 3-8**
 - add `"highlightIndex": 27` to outermost bracket

- **Figure 3-12**
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

- **Figure 3-18:** 
 - Set max value and change number of ticks for first set
  
  ```
  "y": {
        "padding": {"top": 0, "bottom": 0},
        "max": 60000,
        "tick": {
          "format": "dollar",
          "count": 7
        }
  }
  ```

 - Set max value and change number of ticks for second set
  
 ```
   "y": {
      "padding": {"top": 0, "bottom": 0},
      "max": 40000,
      "tick": {
        "format": "dollar",
        "count": 5
      }
    },
  ```
 - Set max value and change number of ticks for third set

  ```
  "y": {
    "padding": {"top": 0, "bottom": 0},
    "max": 50000,
    "tick": {
      "format": "dollar",
      "count": 6
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

- **Figure 3-20
 - In both graphs, added top level attribute `"tallSmallMultiple": true`

- **Figure 3-22:**
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
    `"y": {"padding": {"top": 0, "bottom": 0}, "max": 70000,`

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


- **Figure 4-19:**

 - had to manually change groups array to:

```
  "groups": [
    [
      "Institutional grant aid per full-time student", 
      "Remaining (net) tuition and fees per full-time student",
      "Institutional grant aid per recipient", 
      "Remaining (net) tuition and fees per recipient"
      ]
   ]
```

- **Figure 4-20 :**

 - had to manually change group array to:

```
  "groups": ["Need-based", "Non-need-based"]
```

- **Figure 4-21**
 - add brackets to single x-categories in 4-211 and 4-212
change y tick values

  ```
  "y": {
    "padding": {"top": 0, "bottom": 0},
    "max": 1000,
    "tick": {
      "format": "dollar",
      "count": 3
    }
  ```

 - had to manually change order of sets


 - **for first set of multiples:**
 
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


- **Figure 4-22**
 - **for first set of multiples:**
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

- **Figure 4-21**
 - make x label two lines, in first two graphs of multiple, in order to widen the graph



#SECTION 5: COVERING EXPENSES

- **Figure 5-1 (all multiples)**
 - in first graph, add bracket for x.categories since single category "All families"
 - set max y value and ticks
  ```
      "y": {
        "padding": {"top": 0, "bottom": 0},
        "max": 100000,
        "tick": {
          "count": 3,
          "format": "dollar"
        }
      },
  ```
  
- **Figure 5-3**
 - add   `"highlightIndex" : 25`  to outermost bracket


- **Figure 5-8**
  - add `"highlightIndex" : 0`  to outermost bracket

- **Figure 5-11**
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

- **Figure 5-13:**
 - in first graph, add bracket for `x.categories` since single category `"All Undergraduates"`
 - in first, add space to x-axis labels for two lines so `"All Under-                 graduates"`
 - in the third graph, add space to x-axis labels for two lines  so  `"Less than          ....."` or `"$30,000–            ........."` for instance
 - in the fourth graph, add space to x-axis labels for two lines so "Full-time           ....."

- **Figure 5-14**
 - add `"overrideTickCount": true` to outermost bracket
 
- **Figure 5-17**
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
        "max": 20000
      },
  ```

- **Figure 5-25:**
 - add `"overrideTickCount": true` to outermost bracket
 - set `x.ticks.count` to `11`
 - add 4 blank data points (two at beginning and two at end) 

#SECTION 6: AFTER COLLEGE

- **Figure 6-7**
 - add top level `"forceTall": true` to force 900px height
 - add top level `"padding": {"bottom": 30}`
 
- **Figure 6-8**
 - add bracket to `"categories": ["Education Debt"]`

- **Figure 6-20**
 - make x-labels two lines after dash by adding space: `$1,000– / $5,000`

#SECTION 7: STUDENT PROFILES

- **Figure 7-3**
 - had to tweak groups array:

  ```
  "groups": [
    [
      "Expected family contribution", 
      "Federal grants", 
      "Military/Veterans", 
      "State grants", 
      "Institutional grants", 
      "Private and employer aid", 
      "Federal student loans", 
      "Federal  parent loans", 
      "Private loans", 
      "Earnings and other resources", 
      "Tuition and fees", 
      "NonTF budget"
      ]
    ]
  ```
 - manually set colors to avoid duplicates
  
  ```
  "colors": {
    "Institutional grants":"#1696d2",
    "Military\/Veterans": "#000000",
    "Tuition and fees": "#55b748",
    "Earnings and other resources": "#ffff00",
    "Private and employer aid": "#d2d2d2",
    "NonTF budget": "#ec008b",
    "Federal grants": "#6100ec",
    "State grants": "#d700ec",
    "Private loans": "#88ec00",
    "Federal student loans": "#ffa500",
    "Expected family contribution": "#ec0015",
    "Federal  parent loans": "#00ecd7"
  },
  ```

- **Figure 7-7**
 - had to change groups array:

  ```
    "groups": [
      [
        "Private loans", 
        "Institutional grants", 
        "Tuition and fees", 
        "State public grants",
        "Federal grants", 
        "NonTF budget", 
        "EFC", 
        "Military/Veterans", 
        "Private and employer aid", 
        "Federal parent loans", 
        "Federal student loans", 
        "Earnings and other resources"
        ]
      ],
  ```

- **Figure 7-11**
 - need to change groups array to:
 
  ```
  "groups": [
    [
      "Expected family contribution", 
      "Federal grants", 
      "Military/Veterans", 
      "State grants", 
      "Institutional grants", 
      "Private and employer aid", 
      "Federal student loans", 
      "Federal  parent loans", 
      "Private loans", 
      "Earnings and other resources",
      "Budget beyond tuition and fees", 
      "Tuition and fees"
      ]
    ],
  ```

 - need to set colors manually to avoid duplicates
  ```
  "colors": {
    "Expected family contribution":"#d700ec",
    "Federal grants":"#000000",
    "Military/Veterans":"#55b748",
    "State grants": "#00ecd7",
    "Institutional grants":"#1696d2",
    "Private and employer aid":"#88ec00",
    "Federal student loans": "#d2d2d2",
    "Federal  parent loans":"#6100ec",
    "Private loans": "#ec008b",
    "Earnings and other resources":"#ffa500",
    "Budget beyond tuition and fees":"#ec0015",
    "Tuition and fees":"#ffff00"
  },
  ```
  
- **Figure 7-15**
 - need to change groups array to:
 
  ```
  "groups": [
    [
      "Expected family contribution", 
      "Federal grants", 
      "Military/Veterans", 
      "State grants", 
      "Institutional grants", 
      "Private and employer aid", 
      "Federal student loans", 
      "Federal  parent loans", 
      "Private loans", 
      "Earnings and other resources",
      "Budget beyond tuition and fees", 
      "Tuition and fees"
      ]
    ],
  ```
   
 - need to change colors to avoid duplicates
 
  ```
  "colors": {
    "Expected family contribution":"#d700ec",
    "Federal grants":"#000000",
    "Military/Veterans":"#55b748",
    "State grants":"#00ecd7",
    "Institutional grants":"#ffff00",
    "Private and employer aid":"#88ec00",
    "Federal student loans":"#d2d2d2",
    "Federal  parent loans":"#6100ec",
    "Private loans":"#ec0015",
    "Earnings and other resources":"#ffa500",
    "Budget beyond tuition and fees":"#ec008b",
    "Tuition and fees": "#1696d2"
  },
  ```
- **Figure 7-19**
 - need to change groups array

  ```
  "groups": [
    [
      "Expected family contribution", 
      "Federal grants", 
      "Military/Veterans", 
      "State grants", 
      "Institutional grants", 
      "Private and employer aid", 
      "Federal student loans", 
      "Federal  parent loans", 
      "Private loans", 
      "Budget beyond tuition and fees", 
      "Tuition and fees"
      ]
    ],
  ```
   
 - need to set colors to avoid duplicates
 
  ```
  "colors": {
    "Expected family contribution":"#d700ec",
    "Federal grants": "#000000",
    "Military/Veterans": "#55b748",
    "State grants": "#ffff00",
    "Institutional grants": "#1696d2",
    "Private and employer aid": "#ec008b", 
    "Federal student loans": "#d2d2d2",
    "Federal  parent loans": "#6100ec", 
    "Private loans": "#88ec00",
    "Budget beyond tuition and fees": "#ec0015",
    "Tuition and fees": "#00ecd7"
  },
  ```