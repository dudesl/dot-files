import json
import sys
import re

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

html.append( '<style type="text/css"><!--')
html.append('/*---------- bright Styles ---------*/')
html.append('.sh_bright{background:none; padding:0; margin:0; border:0 none;}.sh_bright .sh_sourceCode{background-color:#fff;color:#401e7a;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_keyword{color:#ff3030;font-weight:bold;font-style:normal;}.sh_bright .sh_sourceCode .sh_type{color:#f7b92c;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_string{color:#1861a7;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_regexp{color:#1861a7;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_specialchar{color:#1861a7;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_comment{color:#38ad24;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_number{color:#32ba06;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_preproc{color:#5374b0;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_symbol{color:#3030ee;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_function{color:#d11ced;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_cbracket{color:#3030ee;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_url{color:#1861a7;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_date{color:#ff3030;font-weight:bold;font-style:normal;}.sh_bright .sh_sourceCode .sh_time{color:#ff3030;font-weight:bold;font-style:normal;}.sh_bright .sh_sourceCode .sh_file{color:#ff3030;font-weight:bold;font-style:normal;}.sh_bright .sh_sourceCode .sh_ip{color:#1861a7;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_name{color:#1861a7;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_variable{color:#00f;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_oldfile{color:#1861a7;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_newfile{color:#1861a7;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_difflines{color:#ff3030;font-weight:bold;font-style:normal;}.sh_bright .sh_sourceCode .sh_selector{color:#00f;font-weight:normal;font-style:normal;}.sh_bright .sh_sourceCode .sh_property{color:#ff3030;font-weight:bold;font-style:normal;}.sh_bright .sh_sourceCode .sh_value{color:#1861a7;font-weight:normal;font-style:normal;}')
html.append('')
html.append('/*-------- Snippet Base Styles ----------*/')
html.append('.snippet-wrap {position:relative;}')
html.append('*:first-child+html .snippet-wrap {display:inline-block;}')
html.append('* html .snippet-wrap {display:inline-block;}')
html.append('.snippet-reveal{text-decoration:underline;}')
html.append('.snippet-wrap .snippet-menu, .snippet-wrap .snippet-hide {position:absolute; top:10px; right:15px; font-size:.9em;z-index:1;background-color:transparent;}')
html.append('.snippet-wrap .snippet-hide {top:auto; bottom:10px;}')
html.append('*:first-child+html .snippet-wrap .snippet-hide {bottom:25px;}')
html.append('* html .snippet-wrap .snippet-hide {bottom:25px;}')
html.append('.snippet-wrap .snippet-menu pre, .snippet-wrap .snippet-hide pre {background-color:transparent; margin:0; padding:0;}')
html.append('.snippet-wrap .snippet-menu a, .snippet-wrap .snippet-hide a {padding:0 5px; text-decoration:underline;}')
html.append('.snippet-wrap pre.sh_sourceCode{padding:1em;line-height:1.8em;overflow:auto;position:relative;')
html.append('-moz-border-radius:15px;')
html.append('-webkit-border-radius:15px;')
html.append('border-radius:15px;')
html.append('box-shadow: 2px 2px 5px #000;')
html.append('-moz-box-shadow: 2px 2px 5px #000;')
html.append('-webkit-box-shadow: 2px 2px 5px #000;}')
html.append('.snippet-wrap pre.snippet-textonly {padding:2em;}')
html.append('*:first-child+html .snippet-wrap pre.snippet-formatted {padding:2em 1em;}')
html.append('* html .snippet-wrap pre.snippet-formatted {padding:2em 1em;}')
html.append('.snippet-reveal pre.sh_sourceCode {padding:.5em 1em; text-align:right;}')
html.append('.snippet-wrap .snippet-num li{padding-left:1.5em;}')
html.append('.snippet-wrap .snippet-no-num{list-style:none; padding:.6em 1em; margin:0;}')
html.append('.snippet-wrap .snippet-no-num li {list-style:none; padding-left:0;}')
html.append('.snippet-wrap .snippet-num {margin:1em 0 1em 1em; padding-left:3em;}')
html.append('.snippet-wrap .snippet-num li {list-style:decimal-leading-zero outside none;}')
html.append('.snippet-wrap .snippet-no-num li.box {padding:0 6px; margin-left:-6px;}')
html.append('.snippet-wrap .snippet-num li.box {border:1px solid; list-style-position:inside; margin-left:-3em; padding-left:6px;}')
html.append('*:first-child+html .snippet-wrap .snippet-num li.box {margin-left:-2.4em;}')
html.append('* html .snippet-wrap .snippet-num li.box {margin-left:-2.4em;}')
html.append('.snippet-wrap li.box-top {border-width:1px 1px 0 !important;}')
html.append('.snippet-wrap li.box-bot {border-width:0 1px 1px !important;}')
html.append('.snippet-wrap li.box-mid {border-width:0 1px !important;}')
html.append('.snippet-wrap .snippet-num li .box-sp {width:18px; display:inline-block;}')
html.append('*:first-child+html .snippet-wrap .snippet-num li .box-sp {width:27px;}')
html.append('* html .snippet-wrap .snippet-num li .box-sp {width:27px;}')
html.append('.snippet-wrap .snippet-no-num li.box {border:1px solid;}')
html.append('.snippet-wrap .snippet-no-num li .box-sp {display:none;}')

html.append( '--> </style>')
html.append( '       <script type="text/javascript" src="http://datatables.net/release-datatables/media/js/jquery.js"></script>')
html.append( '       <script type="text/javascript" src="http://datatables.net/release-datatables/media/js/jquery.dataTables.js"></script>')
html.append( '       <script type="text/javascript" src="http://steamdev.com/snippet/js/jquery.snippet.js"></script>')
html.append( '       <script type="text/javascript" charset="utf-8">')
html.append( '       			$(document).ready(function() {')
html.append( '       				$(\'#results\').dataTable();')
html.append( '       				$(\'pre.sql\').snippet(\'sql\',{style:\'bright\'});')
html.append( '       				$(\'pre.javascript\').snippet(\'javascript\',{style:\'bright\'});')
html.append( '       			} );')
html.append( '       		</script>')
html.append( '<h4>query:</h4>')

insensitive_select = re.compile(re.escape('select'), re.IGNORECASE)
insensitive_from = re.compile(re.escape('from'), re.IGNORECASE)
insensitive_where = re.compile(re.escape('where'), re.IGNORECASE)
insensitive_and = re.compile(re.escape('and'), re.IGNORECASE)
query = json_content['query']
query = insensitive_select.sub("SELECT",query)
query = insensitive_where.sub("\nWHERE",query)
query = insensitive_from.sub("\nFROM",query)
query = insensitive_and.sub("\n\tAND",query)

html.append( '<pre class=\'sql\'>'+query+'</pre>')
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
html.append( '</table>')
html.append('<p><h4>Json</h4>')
html.append('<pre class=\'javascript\'>'+json.dumps(json_content['rows'], sort_keys=True, indent=4)+'</pre></p>')
html.append('</body></html>')
reload(sys)
sys.setdefaultencoding( "latin-1" )



web = open('/tmp/results-web.html', "w")
web.write(unicode('\n'.join(html)).encode("utf-8"))

web.close()
