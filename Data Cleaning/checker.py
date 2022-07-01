import csv

csv_file = open("main9.csv")

csv_reader = csv.reader(csv_file, delimiter = ',')
line_count = 0
cc = 0

for row in csv_reader:
    if line_count == 0:
        pass
    else:
        try:
            float(row[-1])
        except:
            print (row[-1])
            print (line_count)
    line_count+=1

csv_file.close()

#print (cc-line_count)
