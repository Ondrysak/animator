#!/bin/bash
codes=($(curl https://edux.fit.cvut.cz/courses/ | grep '\[DIR\]' | sed -Ee 's#<[^>]*>##' -e 's#<[^>]*>##' -e 's#/</a.*$##' -e 's#^ ##' | grep -e "^B" -e "^P" -e "^M"))
rm -rf courses
mkdir courses
cd courses
for code in ${codes[*]}; do
  mkdir "$code"
  echo "===== ${code} ======" > ./"$code"/index
done
month=$((10#$(date +"%m")))
if [[ "$month" < 2 || "$month" > 9 ]]
then
echo "B$(($(date +'%y')-1))1"
else
echo "B$(($(date +'%y')-1))2"
fi
