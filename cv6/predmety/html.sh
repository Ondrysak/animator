#!/bin/bash
codes=($(curl https://edux.fit.cvut.cz/courses/ | grep '\[DIR\]' | sed -Ee 's#<[^>]*>##' -e 's#<[^>]*>##' -e 's#/</a.*$##' -e 's#^ ##' | grep -e "^B" -e "^P" -e "^M"))
rm -rf courses
mkdir courses
cd courses
count=0
for code in ${codes[*]}; do
  mkdir "$code"
  info="$( echo $code | sed -e 's/BI.-/BI-/' -e 's/MI.-/MI-/' )"
  echo "$info">"$code"/info.txt
  [[ $info == $code ]] && count=$(( $count + 1 ))
done
echo "Skutecnych predmetu je $count."
