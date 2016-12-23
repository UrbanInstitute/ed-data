## MASTER SHEET FOR ALL EDITS MADE IN LUMINA GRAPHS

#SECTION 1: WHAT IS COLLEGE


#SECTION 2: COST OF EDUCATING


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

**Figure 4-20 : had to manually change group array to:**
```
	"groups": ["Need-based", "Non-need-based"]
```

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


