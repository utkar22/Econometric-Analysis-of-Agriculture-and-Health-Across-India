import csv

#Reading GDP data

states = dict()

csv_file = open("gdp.csv")

csv_reader = csv.reader(csv_file, delimiter = ',')
line_count = 0

for row in csv_reader:
    if line_count == 0:
        pass
    else:
        states[row[0].lower()] = [row[1],row[2],row[3],row[4],row[5],row[6],row[7],row[8],row[9]]
    line_count+=1

csv_file.close()

#print(states)

#Reading Beds data

bed = dict()

bed_f = open("beds.csv")

bed_r = csv.reader(bed_f, delimiter = ',')

for row in bed_r:
    bed[row[0].lower()] = row[1]

#print(bed)

#Reading tap data

tap = dict()

tf = open("tap.csv")

tf_r = csv.reader(tf, delimiter = ',')

for row in tf_r:
    try:
        tap[row[0].lower()] = float(row[1])
    except:
        pass

#print(tap)



line_count = 0

cf1 = open("mains.csv")
cf2 = open("mains_dummy.csv", "w")

cr = csv.reader(cf1, delimiter = ',')
cw = csv.writer(cf2, delimiter = ',')

js=[0,0,0,0,0]

prev_row = None

for row in cr:
    f=1
    if line_count == 0:
        f=1
    else:
        if line_count == 1:
            pass
        else:
            #try:
            if int(row[6]) - prev_year == 1:
                if (row[12] == prev_deet):
                    if (prev_index != 0):
                        gr = (float(row[-5]) - prev_index)/prev_index
                        row[-1] = gr
                    else:
                        row[-1] = "NA"
                else:
                    row[-1] = "NA"
            else:
                row[-1] = "NA"
            #except:
            #    row[-1] = "NA"
        
        try:
            row[-4] = states[row[3].lower()][int(row[6])-2011]
        except:
            row[-4] = "NA"
            f=0
            js[0]+=1

        try:
            row[-3] = bed[row[3].lower()]
        except:
            row[-3] = "NA"
            f=0
            js[1]+=1

        try:
            row[-2] = tap[row[5].lower()]
        except:
            row[-2] = "NA"
            f=0
            js[2]+=1

        prev_year = int(row[6])
        prev_deet = row[12]
        prev_index = float(row[-5])

    if ((row[52] == "") or (row[54] == "") or (row[55] == "") or (row[56] == "") or (row[57] == "") or (row[58] == "") or (row[-5] == "")):
        f=0
        js[3]+=1

    if f==1:
        for i in range(len(row)):
            if row[i] == "":
                row[i] = "NA"
                js[4]+=1
        cw.writerow(row)
        
    line_count+=1

    if (line_count % 1000 == 0):
        print (js)



cf1.close()
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
