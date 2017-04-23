#!/bin/bash
set -o errtrace
type exiftool || echo "you should install exiftool show mediafiles metadata"

for arg; do
case "$arg" in

1) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "#################################################################"
./animator -v sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

2) echo "#################################################################"
echo "Testing two valid input files with timeformat matching the default"
echo "-v is used"
echo "#################################################################"

./animator -v sin_small.data sin_small2.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots_1/anim.mp4 2>/dev/null;;

3) echo "#################################################################"
echo "Testing four valid input files with timeformat matching the default"
echo "-v is used"
echo "#################################################################"

./animator -v sin_small.data sin_small2.data sin_small3.data sin_small4.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots_2/anim.mp4 2>/dev/null;;

4) echo "#################################################################"
echo "Testing two valid input files with timeformat matching the default"
echo "-v is used"
echo "-S 5 is used to set speed of reading datafile"
echo "#################################################################"

./animator -S 5 -v sin_small.data sin_small2.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots_3/anim.mp4 2>/dev/null;;

5) echo "#################################################################"
echo "Testing two valid input files with timeformat matching the default"
echo "-v is used"
echo "-S 0.75 is used to set speed of reading datafile"
echo "#################################################################"

./animator -S 0.75 -v sin_small.data sin_small2.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots_4/anim.mp4 2>/dev/null;;

6) echo "#################################################################"
echo "Testing two valid input files with timeformat matching the default"
echo "-v is used"
echo "-T 10 is used to set duration of the resulting video"
echo "#################################################################"

./animator -T 10 -v sin_small.data sin_small2.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots_5/anim.mp4 2>/dev/null;;

7) echo "#################################################################"
echo "Testing two valid input files with timeformat matching the default"
echo "-v is used"
echo "-T 6.45 is used to set duration of the resulting video"
echo "#################################################################"
./animator -T 6.45 -v sin_small.data sin_small2.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots_6/anim.mp4 2>/dev/null;;


8) echo "#################################################################"
echo "Testing two valid input files with timeformat matching the default"
echo "-v is used"
echo "-S 0.75 is used to set speed of reading datafile"
echo "-T 6.45 is used to set duration of the resulting video"
echo "#################################################################"

./animator -S 0.75 -T 6.45 -v sin_small.data sin_small2.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots_7/anim.mp4 2>/dev/null;; 


9) echo "#################################################################"
echo "Running two parralel instances of the script"
echo "-v is used"
echo "#################################################################"
./animator -v sin_small.data &
./animator -v sin_small.data &
wait
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots_8/anim.mp4 2>/dev/null
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots_9/anim.mp4 2>/dev/null;;

?) echo "Invalid test number $arg" ;;
esac
done