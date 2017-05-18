#/bin/bash
#pid parentpid name

procs=$(ps -eo pid,ppid | tr -s '[[:space:]]' | sed 's/^[[:space:]]*//' | tail -n+2 | sort -n)

while read line; do
pid=$( echo "$line" | cut -d' ' -f1 )
ppid=$( echo "$line" | cut -d' ' -f2 )
parent_arr["$pid"]="$ppid"
done<<<"$procs"



for proces in "${!parent_arr[@]}"; do
	depth=0

	parent="${parent_arr[$proces]}"

	while [[ "$parent" != 0 ]]; do

		parent="${parent_arr[$parent]}"
		depth=$(( depth + 1 ))
	done
	depth_arr["$proces"]="$depth";
done



max=0
for index in "${!depth_arr[@]}"; do
newdepth="${depth_arr[$index]}"
if [[ "$max" -lt "$newdepth" ]]; then
result=()
max="$newdepth"
result+=( "$index" )
elif [[ "$max" -eq "$newdepth" ]]; then
result+=( "$index" )
fi	
done
echo "$max: ${result[*]}"