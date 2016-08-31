# Read in json file for graph, created in R
# Flatten "columns" arrays, which are generally nested due to R list limitations

import json
import sys


def flatten(l): return flatten(l[0]) + (flatten(l[1:]) if len(l) > 1 else []) if type(l) is list else [l]

# call flattenColumns from command line (or R)
def flattenColumns(filepath):
    with open(filepath, encoding='utf-8') as fp:
        dj = json.load(fp)
    columns = dj["data"]["columns"]
    series = dj["series"]
    # If there is more than one series, flatten each separately
    if isinstance(series, list):
        for i in range(0, len(columns)):
            columns[i] = flatten(columns[i])
    # Otherwise flatten the whole 'columns' attribute
    else:
        dj["data"]["columns"] = [columns[0]] + columns[1]
    print(dj["data"]["columns"])
    with open(filepath, 'w', encoding='utf-8') as fp:
        json.dump(dj, fp, ensure_ascii=False)

if __name__ == '__main__':
    flattenColumns(*sys.argv[1:])
