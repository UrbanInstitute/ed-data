## MASTER SHEET FOR ALL EDITS MADE IN LUMINA GRAPHS

#SECTION 1: WHAT IS COLLEGE

**Figure 1-4
add 2 blank data points, one at beginning and end

#SECTION 2: COST OF EDUCATING

**Figure 2-2
1) add blank data point (null) as last x-value and "" to categories
2) add "overrideTickCount": true, to topmost bracket
3) set tick.count to 8

**Figure 2-3
1) add blank data point (null) as last x-value and "" to categories
2) add "overrideTickCount": true, to topmost bracket
3) set tick.count to 9

**Figure 2-4
add "highlightIndex" : 36  to outermost bracket

*Figure 2-7: 
1) for all multiples, add spaces to x-axis labels to create two lines, for example: "'01'–        '02'"
 2) set max y value and ticks
"y": {
  "padding": {"top": 0, "bottom": 0},
  "max": 20000,
  "tick": {
    "format": "dollar",
    "count": 5
  }
},

**Figure 2-51: Change Y-axis properties to adjust ticks:
  "axis": {
    "y": {
        "max": 6000,
      "padding": {"top": 0, "bottom": 0},
      "tick": {
        "format": "dollar",
        "count": 4
      }
    },
**Figure 2-52: Change Y-axis properties to adjust ticks:
  "axis": {
    "y": {
    "max": 1000,
    "padding": {"top": 0, "bottom": 0},
      "tick": {
        "format": "dollar",
        "count": 5#
      }
    },
**Figure 2-53: Change Y-axis properties to adjust ticks:
    "y": {
   "max": 60000,
    "padding": {"top": 0, "bottom": 0},
      "tick": {
        "format": "dollar",
        "count": 4
      }
    }
**Figure 2-54: Change Y-axis properties to adjust ticks:
    "y": {
        "max": 4000,
         "padding": {"top": 0, "bottom": 0},
      "tick": {
        "format": "dollar",
        "count": 5
      }
    }
    
**Figure 2-55: Change Y-axis properties to adjust ticks:
    "y": {
        "max": 30000,
        "padding": {"top": 0, "bottom": 0},
      "tick": {
        "format": "dollar",
        "count": 4
      }
    },

**Figure 2-61: Change Y-axis properties to adjust ticks:
    "y": {
      "padding": {"top": 0, "bottom": 0},
      "max": 25000,
      "tick": {
        "format": "dollar",
        "count": 6
      }
    }
**Figure 2-62: Change Y-axis properties to adjust ticks:
        "y": {
     "padding": {"top": 0, "bottom": 0},
     "max": 1200,
      "tick": {
        "format": "dollar",
        "count": 7
      }
    }

**Figure 2-7: 
1) for all multiples, add spaces to x-axis labels to create two lines, for example: "'01'–        '02'"
 2) set max y value and ticks
"y": {
  "padding": {"top": 0, "bottom": 0},
  "max": 20000,
  "tick": {
    "format": "dollar",
    "count": 5
  }
},


#SECTION 3: PRICES AND EXPENSES

**Figure 3-2
#add "overrideTickCount": true to outermost bracket


**Figure 3-3 (all multiples): manually change color for each to avoid automated repeating colors
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
**Figure 3-4: add "highlightIndex": 34 to outermost bracket

**Figure 3-7: add "highlightIndex": 27 to outermost bracket

**Figure 3-8: add "highlightIndex": 27 to outermost bracket

**Figure 3-8
for second graph:
add to y.tick --> "count": 5,

#**Figure 3-10
graph 2: add to y.tick --> "count": 5,

**Figure 3-12
1) set max y value and number of ticks:
"y": {
  "max": 50000,
  "padding": {"top": 0, "bottom": 0},
  "tick": {
    "format": "dollar",
    "count": 6
  }
}
2) add space to x-axis labels for graph 4 so that two-lines: ex- "'12–     '13'

**Figure 3-14
#need to add: "line": {"connectNull": true}  in JSON


**Figure 3-18: 
Set max value and change number of ticks for first set
"y": {
      "padding": {"top": 0, "bottom": 0},
      "max": 60000,
      "tick": {
        "format": "dollar",
        "count": 7
      }
}
Set max value and change number of ticks for second set
   "y": {
      "padding": {"top": 0, "bottom": 0},
      "max": 40000,
      "tick": {
        "format": "dollar",
        "count": 5
      }
    },
#Set max value and change number of ticks for third set
"y": {
  "padding": {"top": 0, "bottom": 0},
  "max": 50000,
  "tick": {
    "format": "dollar",
    "count": 6
  }
},


**Figure 3-19 
Made hand corrections to x axis ticks
For normal line charts handled in the college-affordability.urban.org repo at:
`college-affordability.urban.org/components/30-components/graphs/graph/graph.jsx`
#in various blocks specific to line and area charts. Given that this chart is a single edge case (toggle line chart), made orrections by hand, namely:
- set `x.tick.count: 13`
"overrideTickCount": true,
#- added "colors": {"25th percentile": "#1696d2", "Median": "#fdbf11", "75th percentile": "#000000"  } to outermost bracket in data"
- make sure sets are ordered by 1 and then 2



**Figure 3-20
For first graph:
    "y": {
      "padding": {"top":0, "bottom":0},
      "max": 50000,
      "min":-10000,
      "tick": {
        "format": "dollar",
        "count": 7
      }
    },
For second graph:
    "y": {
      "padding": {"top": 0, "bottom": 0},
      "max": 1,
      "tick": {
        "format": "percent",
        "count": 5
      }
    }

#Figure 3-21
#First set of multiples
need to add "groups": [["Tuition and fees covered by grant aid","Remaining (net) tuition and fees","Living expenses covered by grant aid", "Remaining (net) living expenses"]]

**Figure 3-22:
#First set of multiples:
1) need to add "groups": [["Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"]]
2) set max y value and ticks:
"y": {
  "padding": {"top": 0, "bottom": 0},
  "max": 30000,
  "tick": {
    "format": "dollar",
    "count": 4
  }
},
#Second set of multiples
1) need to add "groups": [["Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"]]
2) set max y value in first graph: "y": {"padding": {"top": 0, "bottom": 0}, "max": 70000,

#Third set of multiples
1) need to add "groups": [["Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"]]
2) set max y value and number of ticks
"y": {
  "padding": {"top": 0, "bottom": 0},
  "max": 20000,
  "tick": {
    "format": "dollar",
    "count": 5
  }
},
#Fourth set of multiples
1) need to add "groups": [["Tuition and fees covered by grant aid", "Remaining (net) tuition and fees", "Living expenses covered by grant aid", "Remaining (net) living expenses"]]
2) need to set max y-value and ticks
"y": {
  "padding": {"top": 0, "bottom": 0},
  "max": 40000,
  "tick": {
    "count": 5,
    "format": "dollar"
  }
},

#SECTION 4: FINANCIAL AID

**Figure 4-7 (all multiples)
1) set max y value and ticks
"y": {
  "padding": {"top": 0, "bottom": 0},
  "max": 20000,
  "tick": {
    "format": "dollar",
    "count": 5
  }
}

2) insert space to x-values after Indepedent or Dependent so that x-values are two lines total

**Figure 4-8 
#had to manually change the ordering of the sets and had to replace "groups" aray with:
```
	"groups": [
	[
	"Federal",
	"State",
	"Veterans",
	"Institutional",
	"Private"
	]
```
**Figure 4-9
#FIRST SET
1) for graph 1, add bracket to single category "All..."
2)for graph 2, add spaces to x-labels to create two lines, for example: "Less than         $30,000" "$30,000 –       $64,999"
3) for graphs 1-3, change number of ticks
"y": {
  "max": 8000,
  "padding": {"top": 0, "bottom": 0},
  "tick": {
    "format": "$s",
    "count": 5
  }
},
#SECOND SET
4) for graph 1, add bracket to single category "All..."
5)for graph 2, add spaces to x-labels to create two lines, for example: "Less than         $30,000" "$30,000 –       $64,999"
6) for graphs 1-3, change number of ticks
"y": {
  "max": 6000,
  "padding": {"top": 0, "bottom": 0},
  "tick": {
    "format": "$s",
    "count": 4
  }
},

**Figure 4-13
# add "highlightIndex" : 18 to outermost bracket


**Figure 4-14
#add highlightIndex": 20 to outermost bracket

**Figure 4-15
1) set max y-value and ticks
"y": {
  "max": 0.4,
  "padding": {"top": 0, "bottom": 0},
  "tick": {
    "format": "percent",
    "count": 3
  }
},

2) add spacing to x-values so two lines, for example: "Public             two-year"

**Figure 4-16

1) add space for x-axis labels in graphs 3 and 5 to make two lines, for example:
 "Public        two-year"   "$106,000           or more"

2) set max y-value and number of ticks
"y": {
  "max": 6000,
  "padding": {"top": 0, "bottom": 0},
  "tick": {
    "format": "$s",
    "count": 4
  }
}


**Figure 4-19: had to manually change groups array to:**
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

**Figure 4-20 : 
1) had to manually change group array to:**
```
	"groups": ["Need-based", "Non-need-based"]
```
2) had to manually change order of sets

**Figure 4-21 : 
1)add brackets to single x-categories in 4-211 and 4-212
2)change y tick values
"y": {
  "padding": {"top": 0, "bottom": 0},
  "max": 1800,
  "tick": {
    "format": "dollar",
    "count": 3
  }

3) make x label two lines, in first two graphs of multiple, in order to widen the graph


**Figure 4-22
FIRST SET
1) set y max value and ticks
    "y": {
  "padding": {"top":0, "bottom":0},
  "max": 0.15,
  "tick": {
    "count": 4,
    "format": "percent"
  }
}
2) adding spacing to x values in third and fourth graphs to create two lines , for example: 
"Public          four-year"         "Less than           $30,000"
3) add brackets to single category in first graph


SECOND SET
1) set y max value and ticks
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

2) adding spacing to x values in third and fourth graphs to create two lines , for example: 
"Public          four-year"         "Less than           $30,000"

3) add brackets to single category in first graph

**Figure 4-23
FIRST SET
1) set y max value and ticks
"y": {
  "padding": {"top": 0, "bottom":0},
  "max": 15000,
  "tick": {
    "format": "dollar",
    "count": 4
  }
}
2) adding spacing to x values in third and fourth graphs to create two lines , for example: 
"Public          four-year"         "Less than           $30,000"

3) add brackets to single category in first graph


SECOND SET
1) set y max value and ticks
"y": {
  "padding": {"top": 0, "bottom": 0},
  "max": 10000,
  "tick": {
    "format": "dollar",
    "count": 3
  }
},
2) adding spacing to x values in third and fourth graphs to create two lines , for example: 
"Public          four-year"         "Less than           $30,000"

3) add brackets to single category in first graph


**Figure 4-24 : 
1) change y tick values
 "y": {
      "padding": {"top":0, "bottom": 0},
       "max": 25,
      "tick": {
        "format": "dollar",
        "count": 6
      }
2) add "overrideTickCount": true to outermost bracket




#SECTION 5: COVERING EXPENSES

**Figure 5-1 (all multiples)
1) in first graph, add bracket for x.categories since single category "All families"
2) set max y value and ticks
    "y": {
      "padding": {"top": 0, "bottom": 0},
      "max": 120000,
      "tick": {
        "count": 4,
        "format": "dollar"
      }
    },
3) For x-axis labels, add space between year range and "years", so that they are on two lines, 
for example: "25-34           years"

**Figure 5-3
add   "highlightIndex" : 25  to outermost bracket


**Figure 5-8
add "highlightIndex" : 0  to outermost bracket

**Figure 5-11
#set max y-value and ticks
"y": {
  "padding": {"top": 0, "bottom": 0},
  "max": 0.5,
  "tick": {
    "format": "percent",
    "count": 6
  }
},

**Figure 5-13: 
1) in first graph, add bracket for x.categories since single category "All Undergraduates"
2) in first, add space to x-axis labels for two lines so "All Under-                 graduates" 
3) in the third graph, add space to x-axis labels for two lines  so  "Less than          ....." or "$30,000–            ........." for instance
4) in the fourth graph, add space to x-axis labels for two lines so "Full-time           ....."

**Figure 5-14
add "overrideTickCount": true to outermost bracket

**Figure 5-17
1) in the first graph, make x-label three lines by adding spaces in between "All full-time/ dependent/ students"
2) in the second graph, make each x-label two lines, so  "Less than          ....." or "$30,000–            ........." for instance
3) set max y-value and ticks

    "y": {
      "padding": {"top": 0, "bottom": 0},
      "tick": {
        "count": 3,
        "format": "dollar"
      },
      "max": 20000
    },
**Figure 5-25:
1) add "overrideTickCount": true to outermost bracket
2) set x.ticks.count to 11
3) add 4 blank data points (two at beginning and two at end) 

**Figure 5-29
1) add "overrideTickCount": true   to outermost bracket
2) add x.tick.count = 6
3) add empty data point to end


#SECTION 6: AFTER COLLEGE

**Figure 6-1: 
1) add two blank data points, one to beginning and end
2) add "overrideTickCount": true to outermost bracket
3) add x.tick.count: 9

**Figure 6-8
add bracket to "categories": ["Education Debt"]

**Figure 6-20
make x-labels two lines after dash by adding space: $1,000– / $5,000

#SECTION 7: STUDENT PROFILES


**Figure 7-3 
1) change 0 to "NA" with regex
[0]{1}[,]  --> replace with "NA",
[0]{1}\n  --> replace with "NA"\n

2) edit groups array
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

3) add colors array
"colors": {
  "Expected family contribution": "#848081",
  "Federal grant aid": "#cfe8f3",
  "Military and veterans grant aid": "#a2d4ec",
  "State grant aid": "#73bfe2",
  "Institutional grant aid":"#1696d2",
  "Private and employer grant aid": "#1696d2",
  "Federal student loans": "#fccb41",
  "Federal parent loans": "#fdbf11",
  "Private loans": "#fce39e",
  "Earnings and other resources": "#d5d5d4",
  "Tuition and fees": "#ec008b",
  "Budget beyond tuition and fees": "#000000"
  },



**Figure 7-7 
1) change 0 to "NA" with regex
[0]{1}[,]  --> replace with "NA",\n
[0]{1}\n  --> replace with "NA"

2) edit groups array
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

3) add colors array
"colors": {
  "Expected family contribution": "#848081",
  "Federal grant aid": "#cfe8f3",
  "Military and veterans grant aid": "#a2d4ec",
  "State grant aid": "#73bfe2",
  "Institutional grant aid":"#1696d2",
  "Private and employer grant aid": "#1696d2",
  "Federal student loans": "#fccb41",
  "Federal parent loans": "#fdbf11",
  "Private loans": "#fce39e",
  "Earnings and other resources": "#d5d5d4",
  "Tuition and fees": "#ec008b",
  "Budget beyond tuition and fees": "#000000"
  },

**Figure 7-11 
1) change 0 to "NA" with regex
[0]{1}[,]  --> replace with "NA",
[0]{1}\n  --> replace with "NA"\n

2) edit groups array
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

3) add colors array
"colors": {
  "Expected family contribution": "#848081",
  "Federal grant aid": "#cfe8f3",
  "Military and veterans grant aid": "#a2d4ec",
  "State grant aid": "#73bfe2",
  "Institutional grant aid":"#1696d2",
  "Private and employer grant aid": "#1696d2",
  "Federal student loans": "#fccb41",
  "Federal parent loans": "#fdbf11",
  "Private loans": "#fce39e",
  "Earnings and other resources": "#d5d5d4",
  "Tuition and fees": "#ec008b",
  "Budget beyond tuition and fees": "#000000"
  },


 **Figure 7-15 
1) change 0 to "NA" with regex
[0]{1}[,]  --> replace with "NA",
[0]{1}\n  --> replace with "NA"\n

2) edit groups array
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

3) add colors array
"colors": {
  "Expected family contribution": "#848081",
  "Federal grant aid": "#cfe8f3",
  "Military and veterans grant aid": "#a2d4ec",
  "State grant aid": "#73bfe2",
  "Institutional grant aid":"#1696d2",
  "Private and employer grant aid": "#1696d2",
  "Federal student loans": "#fccb41",
  "Federal parent loans": "#fdbf11",
  "Private loans": "#fce39e",
  "Earnings and other resources": "#d5d5d4",
  "Tuition and fees": "#ec008b",
  "Budget beyond tuition and fees": "#000000"
  },

**Figure 7-19 

1) change 0 to "NA" with regex
[0]{1}[,]  --> replace with "NA",\n
[0]{1}\n  --> replace with "NA"

2) edit groups array
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

3) add colors array
"colors": {
  "Expected family contribution": "#848081",
  "Federal grant aid": "#cfe8f3",
  "Military and veterans grant aid": "#a2d4ec",
  "State grant aid": "#73bfe2",
  "Institutional grant aid":"#1696d2",
  "Private and employer grant aid": "#1696d2",
  "Federal student loans": "#fccb41",
  "Federal parent loans": "#fdbf11",
  "Private loans": "#fce39e",
  "Earnings and other resources": "#d5d5d4",
  "Tuition and fees": "#ec008b",
  "Budget beyond tuition and fees": "#000000"
  },



