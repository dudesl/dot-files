# tomar archivo
# pasar a objeto
# si es arreglo ya esta
# si es mapa, buscar valor que sea arreglo, y hacer ese, o el argumento pasado
# para cada elemento, si es mapa, recursivamente meterse para generar rows con titulo de clave previa

import json
import sys
import re
import csv
import io
import codecs

def is_number(x):
    try:
        x + 1
        return True
    except TypeError:
        return False
rows =[]
titles=dict()
sortedTitles=dict()

def collect_data(pre,d):
    row=dict()
    for k, v in d.iteritems():
        if isinstance(v, dict):
            newK=""
            if len(pre) > 0:
                newK = pre+'__'+k
            else:
                newK = k
            collect_data(newK)
        else:
            newV = v
            newK=""
            if len(pre) > 0:
            if len(pre) > 0:
                newK = pre+'__'+k
            else:
                newK = k
            if isinstance(v, str):
                newV = v.encode("utf-8")
            if not titles.has_key(newK):
                titles[newK] = len(titles)
                sortedTitles[titles[newK]] = newK

            row[titles[newK]] = newV
            print u'{0} : {1}'.format(newK, newV)
            rows.append(row)

filename = sys.argv[1]
#fileout = sys.argv[2]

print 'abriendo archivo '+filename
f = codecs.open(filename, "r",encoding="utf-8")

text = f.read()


json_content = json.loads(text)

to_analize = None
if isinstance(json_content, dict):
    for k, v in json_content.iteritems():
        print "revisando {0}".format(k)
        if isinstance(v, list):
            print "uso esto!"
            to_analize = v
else:
    to_analize=json_content

for a in to_analize:
    collect_data("",a)

print titles

row_titles = []
for i in range(0,len(sortedTitles)):
    row_titles.append(sortedTitles[i])

csvfile = open('salida.csv','w')
writer = csv.writer(csvfile, delimiter=',', quotechar='\'')
writer.writerow(row_titles)

for row in rows:
    csv_row = []
    print row
    for l in range(0,len(titles)):
        if row.has_key(l):
            val = row[l]
            if isinstance(row[l],str):
                val = val.encode("ascii")
            csv_row.append(val)
        else:
            csv_row.append("")
    writer.writerow(csv_row)



"""
columns = dict()
output_rows = []
lastrow = 0
index = {}

collect_data(to_analize, columns, 

for row in to_analize:
    for k,v in row.items():
        if not columns.has_key(k):
            columns[k] = lastrow
            index[lastrow] = k
            lastrow = lastrow + 1




"""
