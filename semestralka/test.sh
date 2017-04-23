#!/bin/bash
set -o errtrace
type exiftool || echo "you should install exiftool show mediafiles metadata"
rm -rf ./dots*
for arg; do
rm -rf ./dots*

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
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

3) echo "#################################################################"
echo "Testing four valid input files with timeformat matching the default"
echo "-v is used"
echo "#################################################################"

./animator -v sin_small.data sin_small2.data sin_small3.data sin_small4.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

4) echo "#################################################################"
echo "Testing two valid input files with timeformat matching the default"
echo "-v is used"
echo "-S 5 is used to set speed of reading datafile"
echo "#################################################################"

./animator -S 5 -v sin_small.data sin_small2.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

5) echo "#################################################################"
echo "Testing two valid input files with timeformat matching the default"
echo "-v is used"
echo "-S 0.75 is used to set speed of reading datafile"
echo "#################################################################"

./animator -S 0.75 -v sin_small.data sin_small2.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

6) echo "#################################################################"
echo "Testing two valid input files with timeformat matching the default"
echo "-v is used"
echo "-T 10 is used to set duration of the resulting video"
echo "#################################################################"

./animator -T 10 -v sin_small.data sin_small2.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

7) echo "#################################################################"
echo "Testing two valid input files with timeformat matching the default"
echo "-v is used"
echo "-T 6.45 is used to set duration of the resulting video"
echo "#################################################################"
./animator -T 6.45 -v sin_small.data sin_small2.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;


8) echo "#################################################################"
echo "Testing two valid input files with timeformat matching the default"
echo "-v is used"
echo "-S 0.75 is used to set speed of reading datafile"
echo "-T 6.45 is used to set duration of the resulting video"
echo "#################################################################"

./animator -S 0.75 -T 6.45 -v sin_small.data sin_small2.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;; 


9) echo "#################################################################"
echo "Running two parralel instances of the script with the same valid input file, racecondition on creating the folder for result may arise"
echo "-v is used"
echo "#################################################################"
./animator -v sin_small.data &
./animator -v sin_small.data &
wait
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots_1/anim.mp4 2>/dev/null;;

10) echo "#################################################################"
echo "Running two parralel instances of the script but leting one sleep for a while to avoid racecondition"
echo "-v is used"
echo "#################################################################"
./animator -v sin_small.data &
sleep 1 && ./animator -v sin_small.data &
wait
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots_1/anim.mp4 2>/dev/null;;


11) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-y 2 is used to set ymin to -2"
echo "#################################################################"
./animator -v -y -2 sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

12) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-Y 3 is used to set ymax to 3"
echo "#################################################################"
./animator -v -Y 3 sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

13) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-Y max is used to set ymax to minimum"
echo "-y -2 is used to set ymin to -2"
echo "#################################################################"
./animator -v -Y max -y -2 sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

13) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-Y 3 is used to set ymax to 3"
echo "-y min is used to set ymin to min"
echo "#################################################################"
./animator -v -Y max -y -2 sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

13) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-Y 3 is used to set ymax to 3"
echo "-y min is used to set ymin to min"
echo "#################################################################"
./animator -v -Y max -y -2 sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

14) echo "#################################################################"
echo "Testing one valid input file with timeformat not matching the default"
echo "-v is used"
echo "-t '[%H:%M:%S %d.%m.%Y]' is used to set timeformat"
echo "#################################################################"
./animator -v -t '[%H:%M:%S %d.%m.%Y]' web.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

15) echo "#################################################################"
echo "Testing one valid input from http source with timeformat not matching the default"
echo "-v is used"
echo "-t '[%H:%M:%S %d.%m.%Y]' is used to set timeformat"
echo "#################################################################"
./animator -v -t '[%H:%M:%S %d.%m.%Y]' http://goo.gl/AsyLD
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

16) echo "#################################################################"
echo "Testing one valid input from http source with timeformat not matching the default"
echo "-v is used"
echo "-t '%H:%M:%S' is used to set timeformat"
echo "#################################################################"
./animator -v -t '%H:%M:%S' http://goo.gl/sqOCK
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;


*) echo "Invalid test number $arg" ;;
esac
done