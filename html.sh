codes=$(curl https://edux.fit.cvut.cz/courses/ | grep "</a>" | grep folder.gif | cut -d= -f4 | tr -d '/"' | cut -d'>' -f1 | grep "^[bBpPmM]")
mkdir courses
cd courses
while read -r line; do
  mkdir "$line"
  echo "===== ${line} ======" > ./"$line"/index
done <<< "$codes"
