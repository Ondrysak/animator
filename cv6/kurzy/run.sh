#!/bin/bash
sed -f script.sed -n data.html | sed '/^$/d' > mine.txt
diff mine.txt data.txt && echo "OK"
