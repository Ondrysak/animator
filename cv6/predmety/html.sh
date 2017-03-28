#!/bin/bash
codes=($(curl https://edux.fit.cvut.cz/courses/ | grep '\[DIR\]' | sed -Ee 's#<[^>]*>##' -e 's#<[^>]*>##' -e 's#/</a.*$##' -e 's#^ ##' | grep -e "^B" -e "^P" -e "^M"))
rm -rf courses
mkdir courses
cd courses
for code in ${codes[*]}; do
  mkdir "$code"
  echo "$( echo $code | sed -e 's/BI.-/BI-/' -e 's/MI.-/MI-/' )" > "$code"/info.txt
done

