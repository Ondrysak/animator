if [[ -s last ]]
then
last=$(cat last | tail -n1 | cut -d' ' -f1)
backup=$(cat last)
else
last=0
fi 
find -name info.txt -printf "%T@ %Tc %p\n" | sort -n | awk -v last="$last" '$1>last {print $0}' | tee last
if [[ ! -s last ]]
then
echo "$backup" > last
fi  
