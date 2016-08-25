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
    print(len(columns))
    for i in range(0, len(columns)):
        columns[i] = flatten(columns[i])
    print(columns)
    with open(filepath, 'w', encoding='utf-8') as fp:
        json.dump(dj, fp, ensure_ascii=False)

if __name__ == '__main__':
    flattenColumns(*sys.argv[1:])
