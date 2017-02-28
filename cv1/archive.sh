mkdir -p archive
cd archive
month=$((10#$(date +"%m")))
if [[ "$month" < 2 || "$month" > 9 ]]
then
code="B$(($(date +'%y')-1))1"
else
code="B$(($(date +'%y')-1))2"
fi
whole=$(date +'%Y-%m-%dx%H:%M:%S')
datum=$(echo "$whole" | cut -d'x' -f1)
cas=$(echo "$whole" | cut -d'x' -f2)
dirname=$(echo "${code}@${datum}_${cas}")
mkdir -p "$dirname"

