echo '{' > topost.js.log
echo '    "request_method": "POST",' >> topost.js.log
echo "    \"request_uri\": \"$QUERY_INTER_URL\"," >> topost.js.log
echo '    "request_headers": {' >> topost.js.log
echo '        "Content-type": "application/json"' >> topost.js.log
echo '    },' >> topost.js.log
echo "    \"request_body\": \"{\\\"schema\\\": \\\"orange\\\", \\\"query\\\": \\\"$1\\\"}\"" >> topost.js.log
echo '}' >> topost.js.log

curl -vso temp.log -H "Content-type: application/json" -X POST -d @topost.js.log $GENERIC_TESTING_URL | python -mjson.tool

python ~/bin/json-to-table.py temp.log
google-chrome web.html &

