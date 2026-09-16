import csv

line_count = 0

cf1 = open("main.csv")
cf2 = open("main_dummy.csv", "w")

cr = csv.reader(cf1, delimiter = ',')
cw = csv.writer(cf2, delimiter = ',')

for row in cr:
    f=1
    if line_count == 0:
        f=1
    else:   
        if ((row[54] == "")):
            f=0

    if f==1:
        for i in range(len(row)):
            if row[i] == "":
                row[i] = "NA"
        cw.writerow(row)
        
    line_count+=1


f1 = open("main_dummy.csv")
f2 = open("main_clean.csv","w")

arr = f1.readlines()
f1.close()

for s in arr:
    if s == '\n':
        continue
    else:
        f2.write(s)

f2.close()
