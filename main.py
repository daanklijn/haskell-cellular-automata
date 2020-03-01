import time

def show(row):
    result = ''
    for i in row:
        if(i==1):
            result+="o"
        else:
            result+=" "
    print(result)

def next(row, rules):
    next = []
    for i in range(len(row)):
        if(i==0):
            a = 0
        else:
            a = row[i-1]
        b = row[i]
        if(i==len(row)-1):
            c = 0
        else:
            c = row[i+1]
        rule = str(a)+str(b)+str(c)
        next.append(rules[rule])
    return next

        
row = [0,0,1,0,0,0,0,0,1,0,0,0,0,1,0,0,0]
row = row + row + row
rules = {
    '111':0,
    '110':0,
    '101':0,
    '100':1,
    '011':1,
    '010':1,
    '001':1,
    '000':0
}
show(row)
while(True):
    row = next(row,rules)
    show(row)
    time.sleep(0.1)