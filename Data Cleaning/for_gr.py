import csv

csv_file = open("mains.csv")
cf2 = open("mains_dummy.csv", "w")


csv_reader = csv.reader(csv_file, delimiter = ',')
cw = csv.writer(cf2, delimiter = ',')

line_count = 0

for row in csv_reader:
    if line_count:
        f=0
        if line_count>1:
            if int(row[6]) - prev_year == 1:
                if prev_deet == row[12][:-1]:
                    try:
                        if (float(prev_index)!=0):
                            gr = (float(row[-5]) - float(prev_index))/float(prev_index)
                            row[-5] = gr
                            f=1
                    except:
                        pass

        if f == 0:
            row[-5] = "NA"

        prev_year = int(row[6])
        prev_deet = row[12][:-1]
        prev_index = row[-5]

    line_count+=1

    cw.writerow(row)

csv_file.close()
cf2.close()


f1 = open("mains_dummy.csv")
f2 = open("mains_final.csv","w")

arr = f1.readlines()
f1.close()

for s in arr:
    if s == '\n':
        continue
    else:
        f2.write(s)

f2.close()
