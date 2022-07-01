import csv

zero = 0
na = 0

csv_file = open("main9.csv")

csv_reader = csv.reader(csv_file, delimiter = ',')

for row in csv_reader:
    yi = row[-4]

    if (yi == "0"):
        zero+=1
    elif yi == "NA":
        na+=1

print (zero, na)
