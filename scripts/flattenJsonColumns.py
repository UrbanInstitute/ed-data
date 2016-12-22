import json
import sys


def flatten(l): return flatten(l[0]) + (flatten(l[1:]) if len(l) > 1 else []) if type(l) is list else [l]

# call flattenColumns from command line (or R)
def flattenColumns(filepath):
    with open(filepath, encoding='utf-8') as fp:
        dj = json.load(fp)
    series = dj["series"]
    if "columns" in dj["data"]:
        columns = dj["data"]["columns"]
        # If there is more than one series, flatten each separately
        if isinstance(series, list):
            for i in range(0, len(columns)):
                columns[i] = flatten(columns[i])
        # Otherwise flatten the whole 'columns' attribute
        else:
            if(isinstance(columns[1], list)):
                dj["data"]["columns"] = [columns[0]] + columns[1]
            else:
                dj["data"]["columns"] = [columns[0]] + [columns[1]]
            # And for c3 charts it needs to be coreced to an array of arrays
            dj["data"]["columns"] = [dj["data"]["columns"]]
        print(dj["data"]["columns"])
    if "sets" in dj["data"]:
        sets = dj["data"]["sets"]
        # If there is more than one series, flatten each separately
        for key, value in sets.items():
            if(type(value[1][0]) is dict):
            #toggles with multiple series (e.g. personas)
                reshaped = {}
                finalReshaped = []
                for subDict in value[1]:
                    for subKey, subValue in subDict.items():
                        if subKey not in reshaped:
                            reshaped[subKey] = [subValue]
                        else:
                            reshaped[subKey].append(subValue)
                for reshapedKey, reshapedValue in reshaped.items():
                    finalReshaped.append([reshapedKey] + reshapedValue)
                print (finalReshaped)
                dj["data"]["sets"][key][1] = finalReshaped

            else:
            #other toggles, with a single series
                dj["data"]["sets"][key] = [value[0]] + value[1]
                # And for c3 charts it needs to be coreced to an array of arrays
                dj["data"]["sets"][key] = [dj["data"]["sets"][key]]
        print(dj["data"]["sets"])
    # For stacked charts, need to nest "groups" elements as a list of lists for c3
    if "groups" in dj["data"]:
        dj["data"]["groups"] = [dj["data"]["groups"]]
    with open(filepath, 'w', encoding='utf-8') as fp:
        json.dump(dj, fp, ensure_ascii=False)

if __name__ == '__main__':
    flattenColumns(*sys.argv[1:])