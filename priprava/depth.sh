#/bin/bash
#pid parentpid name

procs=$(ps -eo pid,ppid | tr -s '[[:space:]]' | sed 's/^[[:space:]]*//' | tail -n+2 | sort -n)

while read line; do
pid=$( echo "$line" | cut -d' ' -f1 )
ppid=$( echo "$line" | cut -d' ' -f2 )
#echo "$pid and $ppid"
if [[ "$ppid" -eq 0 ]]; then
depth["$pid"]=0
else
parentdepth="${depth[$ppid]}"
#echo "parentdepth $parentdepth"
depth["$pid"]=$(( parentdepth + 1 ))
fi	
done<<<"$procs"
max=0

for index in "${!depth[@]}"; do
newdepth="${depth[$index]}"
if [[ "$max" -lt "$newdepth" ]]; then
result=()
max="$newdepth"
result+=( "$index" )
elif [[ "$max" -eq "$newdepth" ]]; then
result+=( "$index" )
fi	
done
echo "$max: ${result[*]}"