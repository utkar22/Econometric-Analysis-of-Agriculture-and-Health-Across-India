import csv

seasons = []

csv_file = open("main9.csv")

csv_reader = csv.reader(csv_file, delimiter = ',')

for row in csv_reader:
    s = row[7]
    if s not in seasons:
        seasons.append(s)

csv_file.close()

print(seasons)
