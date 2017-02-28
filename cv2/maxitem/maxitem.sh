function max_item {
 ls -l | tail -n+2 | tr -s " " | cut -d" " -f9 | grep "$1" | sed "s/${1}_//" | sort -n | tail -n1
}
max_item file_item 
