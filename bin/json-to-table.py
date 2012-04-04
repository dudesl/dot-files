import json
import sys


filename = sys.argv[1]
#filename = 'example.js'


print 'abriendo archivo '+filename
f = open(filename, "r")

text = f.read()


json_content = json.loads(text)


columns = dict()
output_rows = []
lastrow = 0
index = {}
SEP = '@'
html = []

print json_content

for row in json_content['rows']:
    for k,v in row.items():
        if not columns.has_key(k):
            columns[k] = lastrow
            index[lastrow] = k
            lastrow = lastrow + 1

print columns

html.append( '<html><head>')
html.append( '       <link href="http://datatables.net/release-datatables/media/css/demo_table.css" rel="stylesheet" type="text/css"> </link>')
html.append( '       <script type="text/javascript" src="http://datatables.net/release-datatables/media/js/jquery.js"></script>')
html.append( '       <script type="text/javascript" src="http://datatables.net/release-datatables/media/js/jquery.dataTables.js"></script>')
html.append( '       <script type="text/javascript" charset="utf-8">')
html.append( '       			$(document).ready(function() {')
html.append( '       				$(\'#results\').dataTable();')
html.append( '       			} );')
html.append( '       		</script>')
html.append( '       </head><body><table id="results"><thead>')
line = ''
html.append( '<tr>')
for i in range(0,lastrow):
    html.append( '<th>' + index[i] + '</th>')
    line = line + index[i] + SEP

html.append( '</tr></thead>')

print line
line = ''

html.append( '<tbody>')
for row in json_content['rows']:
    html.append( '<tr>')
    for i in range(0,lastrow):
        if row.has_key(index[i]):
            val = row[index[i]]
        else:
            val = ''
        html.append( '<td>'+unicode(val).encode("utf-8")+'</td>')
        line = line + val + SEP
    print line
    html.append( '</tr>')
    line = ''

html.append( '</tbody>')
html.append( '</table></body></html>')
reload(sys)
sys.setdefaultencoding( "latin-1" )



web = open('/tmp/results-web.html', "w")
web.write(unicode('\n'.join(html)).encode("utf-8"))

web.close()
