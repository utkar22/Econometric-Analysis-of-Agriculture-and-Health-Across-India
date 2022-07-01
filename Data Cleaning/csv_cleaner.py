f1 = open("main2.csv")
f2 = open("main3.csv","w")

arr = f1.readlines()
f1.close()

for s in arr:
    if s == '\n':
        continue
    else:
        f2.write(s)

f2.close()
