mkdir -p archive
cd archive
month=$((10#$(date +"%m")))
if [[ "$month" < 2 || "$month" > 9 ]]
then
code="B$(($(date +'%y')-1))1"
else
code="B$(($(date +'%y')-1))2"
fi
datum=$(date +'%Y-%m-%d')
cas=$(date +'%H:%M:%S')
dirname=$(echo "${code}@${datum}_${cas}")
mkdir -p "$dirname"

