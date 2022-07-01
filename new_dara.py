import csv

flourine = dict()
child_marriage = dict()


file1 = open("child_marriage.csv")
reader1 = csv.reader(file1, delimiter = ',')

line_count = 0

for row in reader1:
    if line_count == 0:
        pass
    else:
        child_marriage[row[0].lower()] = [row[1],row[2],row[3],row[4],row[5],row[6]]
    line_count+=1

file1.close()


file2 = open("flourine.csv")
reader2 = csv.reader(file2, delimiter = ',')

for row in reader2:
    flourine[row[0].lower()] = [row[1],row[2],row[3],row[4],row[5],row[6]]



line_count = 0

cf1 = open("main10.csv")
cf2 = open("main10_dummy.csv", "w")

cr = csv.reader(cf1, delimiter = ',')
cw = csv.writer(cf2, delimiter = ',')

for row in cr:
    f = 1
    if line_count == 0:
        f = 1
    else:
        try:
            row[-2] = child_marriage[row[3].lower()][int(row[6])-2011]
        except:
            row[-2] = "NA"

        try:
            row[-1] = flourine[row[3].lower()][int(row[6])-2011]
        except:
            row[-1] = "NA"

        #print (row[3].lower())
        #print (child_marriage[row[3].lower()][row[6]-2011])

    cw.writerow(row)

    line_count+=1

    

    #if (line_count == 10):
    #    break

cf1.close()
cf2.close()

f1 = open("main10_dummy.csv")
f2 = open("main_final.csv","w")

arr = f1.readlines()
f1.close()

for s in arr:
    if s == '\n':
        continue
    else:
        f2.write(s)

f2.close()
