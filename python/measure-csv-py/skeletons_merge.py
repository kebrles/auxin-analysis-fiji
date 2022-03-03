import os
import csv
import sys
import re


def makeRoiLabel(fijiLabel):
    newLabel = ""
    if "aligned" in fijiLabel:
        newLabel = fijiLabel.split(":", 1)[1]
    else:
        labelParts = fijiLabel.split(":")
        newLabel = labelParts[1] + ":" + labelParts[3].split("/")[0]
    return newLabel


def writeDataDictToCsv(data, path):
    with open(path, "w", newline='') as csvfile:
        writer = csv.writer(csvfile, dialect='excel', delimiter=",")

        # hlavicka = nazvy sloupcu
        writer.writerow(["Image", "Order", "ROI", "Area", "PM", "cytosol", "PM/cytosol"])

        for key in data:
            image_data = data[key]
            if image_data is None:
                continue

            index = 0
            while index < len(image_data):
                row = []
                if index == 0:
                    row.insert(0, key)
                else:
                    row.insert(0, '')
                row.append(index/2 + 1) # "Order"
                row.append(makeRoiLabel(image_data[index][1])) # ROI label
                row.append(image_data[index][2]) #area
                row.append(image_data[index+1][3]) # under line average - "PM"
                row.append(image_data[index][3]) # ROI average - "cytosol"
                row.append(format(float(image_data[index+1][3]) / float(image_data[index][3]), ".4f")) # PM/cytosol


                writer.writerow(row)

                index += 2


def getRequiredCsvRowData(filePath):
    results = []
    with open(filePath, newline='') as csvfile:
        reader = csv.reader(csvfile, delimiter=",")
        rowIterator = iter(reader)
        next(rowIterator)
        for row in rowIterator:
            rowData = []
            rowData.append(row[0])  # id
            rowData.append(row[1])  # label
            rowData.append(row[2])  # area
            rowData.append(row[3])  # mean
            results.append(rowData)
    return results


# R2D2_arpc5_1_plant2_1_Z-Stack_podivné tečky.czi_selected_GREEN
def processCsv(directory, file, file_type):
    # print(directory, file)

    all_files = os.listdir(directory)
    selectedFilter = filter(lambda x: re.search(file + ".*" + file_type + ".csv$", x) is not None, all_files)

    foundFile = next(selectedFilter, None)

    data = None
    if foundFile is None:
        print("!!! ERROR MISSING csv: ", file)
    else:
        print( "OK", file)
        data = getRequiredCsvRowData(os.path.join(directory, foundFile))

    return {file : data}



if __name__ == '__main__':
    print('Number of arguments:', len(sys.argv) - 1)
    print('Arguments:\n')
    for arg in sys.argv[1:]:
        print(arg)
    print()
    print("Processed files: ")
    directory = sys.argv[1]
    file_type = sys.argv[2]  # for example: reviewed - will process only measurements with 'reviewed' in name
    files = filter(lambda x: x.endswith(".tif"), os.listdir(directory))

    all_data = dict()
    for file in files:
        all_data.update(processCsv(directory, file[:-4], file_type))


    path = os.path.normpath(directory)
    path_elements = path.split(os.sep)
    results_file_name = path_elements[-2] + "_" + path_elements[-1] + "_" + file_type + "_ALL.csv"
    writeDataDictToCsv(all_data, os.path.join(directory, results_file_name))
    print("\nResults saved to: " + results_file_name)
