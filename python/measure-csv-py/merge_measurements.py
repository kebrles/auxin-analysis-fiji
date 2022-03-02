import os
import csv
import sys
import re


def writeDataDictToCsv(data, path):
    with open(path, "w", newline='') as csvfile:
        writer = csv.writer(csvfile, dialect='excel', delimiter=",")
        writer.writerow(["Image", "ROI", "Area", "Red_Mean", "Green_Mean", "R/G"])

        for key in data:
            first = True
            image_data = data[key]
            for row in image_data:
                if first:
                    row.insert(0, key)
                    first = False
                else:
                    row.insert(0, '')
                writer.writerow(row)
    pom = 0


def getCsvRowData(filePath):
    results = []
    with open(filePath, newline='') as csvfile:
        reader = csv.reader(csvfile, delimiter=",")
        rowIterator = iter(reader)
        next(rowIterator)
        for row in rowIterator:
            rowData = []
            rowData.append(row[0])  # id
            rowData.append(row[1])  # area
            rowData.append(row[2])  # mean
            results.append(rowData)
    return results


# R2D2_arpc5_1_plant2_1_Z-Stack_podivné tečky.czi_selected_GREEN
def processCsv(directory, file, file_type):
    print(directory, file)
    ahoj = ""

    all_files = os.listdir(directory)
    found_red = filter(lambda x: re.search(
        "^" + file + ".*" + ("_" + file_type + "_RED.csv$" if len(file_type) > 0 else "czi_RED.csv$"), x) is not None,
                       all_files)
    redCSV = os.path.join(directory, next(found_red))

    found_green = filter(lambda x: re.search(
        "^" + file + ".*" + ("_" + file_type + "_GREEN.csv$" if len(file_type) > 0 else "czi_GREEN.csv$"),
        x) is not None, all_files)

    greenCSV = os.path.join(directory, next(found_green))

# tady zakomentovat
    redData = getCsvRowData(redCSV)
    greenData = getCsvRowData(greenCSV)

    finalData = []
    for i in range(0, len(redData)):
        redData[i].append(greenData[i][2])
        redData[i].append(
            str(
                round(
                    float(redData[i][2]) / float(greenData[i][2]), 5)))
        finalData.append(redData[i])

        pom2 = 0

    return {file: finalData}


if __name__ == '__main__':
    print('Number of arguments:', len(sys.argv) - 1)
    print('Arguments:\n')
    for arg in sys.argv[1:]:
        print(arg)
    print()
    print("Processed files: ")
    directory = sys.argv[1]
    file_type = sys.argv[2]  # for example: reviewed - will process only measurements with 'reviewed' in name
    files = filter(lambda x: x.endswith(".czi"), os.listdir(directory))

    all_data = dict()
    for file in files:
        all_data.update(processCsv(directory, file[:-4], file_type))

    # file_type, directory
    path = os.path.normpath(directory)
    path_elements = path.split(os.sep)
    results_file_name = path_elements[-2] + "_" + path_elements[-1] + "_" + file_type + "_ALL.csv"
    writeDataDictToCsv(all_data, os.path.join(directory, results_file_name))
    print("\nResults saved to: " + results_file_name)
# TODO
# - poslala ten smejd
# - automaticka hulka na vsechno, pak ulozit ROI
# - review ROI, promazat, ulozit

# - zmerit area to line (3px), zmerit jas area mean -> do excelu (prumer membrana, prumer vnitrek, pomer)
# - sousedici hranice ze se prekrivaji - odposunou
# - nesedi na slice moc dobre (posunout???)
