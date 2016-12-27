## MASTER SHEET FOR ALL EDITS MADE IN LUMINA GRAPHS

#SECTION 1: WHAT IS COLLEGE


#SECTION 2: COST OF EDUCATING

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
        "count": 5

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
      "max": 20000,
      "tick": {
        "format": "dollar",
        "count": 5
      }
    }
**Figure 2-62: Change Y-axis properties to adjust ticks:
        "y": {
     "padding": {"top": 0, "bottom": 0},
     "max": 1000,
      "tick": {
        "format": "dollar",
        "count": 5
      }
    }

#SECTION 3: PRICES AND EXPENSES

**Figure 3-19 Made hand corrections to x axis ticks.**

For normal line charts handled in the college-affordability.urban.org repo at:
`college-affordability.urban.org/components/30-components/graphs/graph/graph.jsx`
in various blocks specific to line and area charts. Given that this chart is a single edge case (toggle line chart), made corrections by hand, namely:
- set `x.tick.count: 14`
- added empty tick `""` to start and end of x.categories array
- added empty tick `null` to start and end of each data series array in `data.sets`

#SECTION 4: FINANCIAL AID

**Figure 4-8 had to manually change the ordering of the sets and had to replace "groups" aray with:**
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
#Figure 4-9
for graphs 1-3, change number of ticks
"y": {
  "max": 8000,
  "padding": {"top": 0, "bottom": 0},
  "tick": {
    "format": "$s",
    "count": 5
  }
},

for graphs 11-33, change number of ticks
"y": {
  "max": 6000,
  "padding": {"top": 0, "bottom": 0},
  "tick": {
    "format": "$s",
    "count": 4
  }
},

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

**Figure 4-21 : 
add brackets to single x-categories in 4-211 and 4-212
change y tick values
"y": {
  "padding": {"top": 0, "bottom": 0},
  "max": 1000,
  "tick": {
    "format": "dollar",
    "count": 3
  }

2) had to manually change order of sets


**Figure 4-24 : change y tick values
 "y": {
      "padding": {"top":0, "bottom": 0},
       "max": 25,
      "tick": {
        "format": "dollar",
        "count": 6
      }

**Figure 4-21 : make x label two lines, in first two graphs of multiple, in order to widen the graph



#SECTION 5: COVERING EXPENSES


#SECTION 6: AFTER COLLEGE


#SECTION 7: STUDENT PROFILES


#Figure 7-3 had to tweak groups array:
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

#Figure 7-7 #had to change groups array:

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

#Figure 7-11 need to change groups array to:
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

 #Figure 7-15 need to change groups array to:
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

  #Figure 7-19 need to change groups array to:
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


