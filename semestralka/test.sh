#!/bin/bash
#single and double digit tests are valid, triple digit tests are error producing
type exiftool || echo "you should install exiftool show mediafiles metadata"
rm -rf ./dots*
for arg; do
read -p "Press RETURN key to remove ./dots* and continue..."
rm -rf ./dots*

case "$arg" in

1) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "#################################################################"
echo "./animator -v sin_small.data"
./animator -v sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

2) echo "#################################################################"
echo "Testing two valid input files with timeformat matching the default"
echo "-v is used"
echo "#################################################################"
echo "./animator -v sin_small.data sin_small2.data"
./animator -v sin_small.data sin_small2.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

3) echo "#################################################################"
echo "Testing four valid input files with timeformat matching the default"
echo "-v is used"
echo "#################################################################"
echo "./animator -v sin_small.data sin_small2.data sin_small3.data sin_small4.data"
./animator -v sin_small.data sin_small2.data sin_small3.data sin_small4.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

4) echo "#################################################################"
echo "Testing two valid input files with timeformat matching the default"
echo "-v is used"
echo "-S 5 is used to set speed of reading datafile"
echo "#################################################################"
echo "./animator -S 5 -v sin_small.data sin_small2.data"
./animator -S 5 -v sin_small.data sin_small2.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

5) echo "#################################################################"
echo "Testing two valid input files with timeformat matching the default"
echo "-v is used"
echo "-S 0.75 is used to set speed of reading datafile"
echo "#################################################################"
echo "./animator -S 0.75 -v sin_small.data sin_small2.data"
./animator -S 0.75 -v sin_small.data sin_small2.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

6) echo "#################################################################"
echo "Testing two valid input files with timeformat matching the default"
echo "-v is used"
echo "-T 10 is used to set duration of the resulting video"
echo "#################################################################"
echo "./animator -T 10 -v sin_small.data sin_small2.data"
./animator -T 10 -v sin_small.data sin_small2.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

7) echo "#################################################################"
echo "Testing two valid input files with timeformat matching the default"
echo "-v is used"
echo "-T 6.45 is used to set duration of the resulting video"
echo "#################################################################"
echo "./animator -T 6.45 -v sin_small.data sin_small2.data"
./animator -T 6.45 -v sin_small.data sin_small2.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

8) echo "#################################################################"
echo "Testing two valid input files with timeformat matching the default"
echo "-v is used"
echo "-S 0.75 is used to set speed of reading datafile"
echo "-T 6.45 is used to set duration of the resulting video"
echo "#################################################################"
echo "./animator -S 0.75 -T 6.45 -v sin_small.data sin_small2.data"
./animator -S 0.75 -T 6.45 -v sin_small.data sin_small2.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;; 

9) echo "#################################################################"
echo "Running two parralel instances of the script with the same valid input file, racecondition on creating the folder for resulting animation may arise"
echo "-v is used"
echo "#################################################################"
echo "./animator -v sin_small.data &"
echo "./animator -v sin_small.data &"
./animator -v sin_small.data &
./animator -v sin_small.data &
wait
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots_1/anim.mp4 2>/dev/null;;

10) echo "#################################################################"
echo "Running two parralel instances of the script but leting one sleep for a while to avoid racecondition"
echo "-v is used"
echo "#################################################################"
echo "./animator -v sin_small.data &
sleep 1 && ./animator -v sin_small.data &"
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
echo "./animator -v -y -2 sin_small.data"
./animator -v -y -2 sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

12) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-Y 3 is used to set ymax to 3"
echo "#################################################################"
echo "./animator -v -Y 3 sin_small.data"
./animator -v -Y 3 sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

13) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-Y max is used to set ymax to maximum"
echo "-y -2 is used to set ymin to -2"
echo "#################################################################"
"./animator -v -Y max -y -2 sin_small.data"
./animator -v -Y max -y -2 sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

14) echo "#################################################################"
echo "Testing one valid input file with timeformat not matching the default"
echo "-v is used"
echo "-t '[%H:%M:%S %d.%m.%Y]' is used to set timeformat"
echo "#################################################################"
"./animator -v -t '[%H:%M:%S %d.%m.%Y]' web.data"
./animator -v -t '[%H:%M:%S %d.%m.%Y]' web.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

15) echo "#################################################################"
echo "Testing one valid input from http source with timeformat not matching the default"
echo "-v is used"
echo "-t '[%H:%M:%S %d.%m.%Y]' is used to set timeformat"
echo "#################################################################"
echo "./animator -v -t '[%H:%M:%S %d.%m.%Y]' http://goo.gl/AsyLD"
./animator -v -t '[%H:%M:%S %d.%m.%Y]' http://goo.gl/AsyLD
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

16) echo "#################################################################"
echo "Testing one valid input from http source with timeformat not matching the default and not containing year month or day"
echo "-v is used"
echo "-t '%H:%M:%S' is used to set timeformat"
echo "#################################################################"
echo "./animator -v -t '%H:%M:%S' http://goo.gl/sqOCK"
./animator -v -t '%H:%M:%S' http://goo.gl/sqOCK
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

17) echo "#################################################################"
echo "Testing one valid file with timeformat matching the default default"
echo "-v is used"
echo "-f config.cfg is used to specify config file YMax 5 YMin -5 Speed 3 Time 10"
echo "#################################################################"
echo "./animator -v -f config.cfg sin_small.data"
./animator -v -f config.cfg sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

18) echo "#################################################################"
echo "Testing one valid file with timeformat matching the default default and not containing year month or day"
echo "-v is used"
echo "-f config.cfg is used to specify config file YMax 5 YMin -5 Speed 3 Time 10"
echo "-Y 3 is used to set ymax to 3 overriding config"
echo "-y min is used to set ymin to min overriding config"
echo "#################################################################"
echo "./animator -v -Y 3.5 -y min -f config.cfg sin_small.data"
./animator -v -Y 3.5 -y min -f config.cfg sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

19) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-Y 1 is used to set ymax to 1"
echo "-y 0.5 is used to set ymin to 0.5"
echo "#################################################################"
echo "./animator -v -Y 1 -y 0.5 sin_small.data"
./animator -v -Y 1 -y 0.5 sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

20) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-e modulo=5:type=3 is used"
echo "#################################################################"
echo "./animator -v -e "modulo=5:type=3" sin_small.data"
./animator -v -e "modulo=5:type=3" sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

21) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-e modulo=5:type=3 is used"
echo "#################################################################"
echo './animator -v -e "modulo=5" -e "type=3" sin_small.data'
./animator -v -e "modulo=5" -e "type=3" sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

22) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-e modulo=5 -e type:200 is used"
echo "#################################################################"
echo './animator -v -e "modulo=5" -e "type=200" sin_small.data'
./animator -v -e "modulo=5" -e "type=200" sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

23) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-t [%H:%M:%S %d.%m.%Y]' is used " 
echo "-S 2.33 is used to set speed of reading datafile"
echo "#################################################################"
echo "./animator -v -t '[%H:%M:%S %d.%m.%Y]' -S 2.33 web.data"
./animator -v -t '[%H:%M:%S %d.%m.%Y]' -S 2.33 web.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

24) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-f config EffectParams, as it can appear more than once both modulo and type should apply if used like this EffectParams modulo=10, EffectParams type=2"

echo "#################################################################"
echo "./animator -v -f config_e.cfg sin_small.data"
./animator -v -f config_e.cfg sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

25) echo "#################################################################"
echo "Testing one valid input file with timeformat %x %X using en_GB locale"
echo "-v is used"
echo "-S 0.2 to slowdown a bit"
echo "#################################################################"
echo './animator -v -t "%x %X" -S 0.2 ./%xX_mini.data'
./animator -v -t "%x %X" -S 0.2 ./%xX_mini.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

26) echo "#################################################################"
echo "Testing max_folders reaction to files and symlinks with one input file matching default timeformat"
echo "-v is used"
echo "#################################################################"
echo "touch dots dots_1
ln -s dots_1 dots_2
ln -s dots_2 dots_3
./animator -v sin_small.data"
touch dots dots_1
ln -s dots_1 dots_2
ln -s dots_2 dots_3
./animator -v sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots_4/anim.mp4 2>/dev/null;;

27) echo "#################################################################"
echo "Valid input file with newline in its name"
echo "-v is used"
echo "#################################################################"
echo './animator -v "$(printf "sin\nsmall.data")"'
./animator -v "$(printf "sin\nsmall.data")"
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

28) echo "#################################################################"
echo "Valid input"
echo "-S 50 and -T 10 is used to test case where there is few frames but we want animation to be long"
echo "#################################################################"
echo "./animator -v -S 50 -T 10 sin_small.data"
./animator -v -S 50 -T 10 sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

29) echo "#################################################################"
echo "Valid input file"
echo "-S 1 and -T 0.5 is used to test case where there is many frame but  we want animatiion to be short"
echo "#################################################################"
echo "./animator -v -S 1 -T 0.5 sin_small.data"
./animator -v -S 1 -T 0.5 sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

30) echo "#################################################################"
echo "Valid input file with timeforamt matching the default"
echo "-n is used to specify a folder for output which contains a space"
echo "#################################################################"
echo './animator -v -n "dots space" ./sin_small.data'
./animator -v -n "dots space" ./sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots\ space/anim.mp4 2>/dev/null;;

31) echo "#################################################################"
echo "Valid input file with timeformat matching the default, but its name starts with http which should not make script confused"
echo "#################################################################"
echo "./animator -v ./http.data"
./animator -v ./http.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

32) echo "#################################################################"
echo "Valid input file with timeformat matching the default"
echo "Demonstrating double usage of -v"
echo "#################################################################"
echo "./animator -v -v  ./sin_small.data"
./animator -v -v  ./sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

33) echo "#################################################################"
echo "Testing one valid file with timeformat matching the default default and not containing year month or day"
echo "-v is used"
echo "-f config.cfg is used to specify config file YMax 5 YMin -5 Speed 3 Time 10"
echo "#################################################################"
echo './animator -v -f "config space.cfg" sin_small.data'
./animator -v -f "config space.cfg" sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

34) echo "#################################################################"
echo "Testing one valid file with quote in name"
echo "-v is used"
echo "#################################################################"
echo "./animator -v sin\'small.data "
./animator -v sin\'small.data 
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

35) echo "#################################################################"
echo "Testing one valid file with double quote in name"
echo "-v is used"
echo "#################################################################"
echo './animator -v sin\"small.data'
./animator -v sin\"small.data 
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

36) echo "#################################################################"
echo "Testing one valid input file with timeformat not matching the default"
echo "-v is used"
echo "-t '[%Y/%m/%d %H:%M:%S]' is used to set timeformat"
echo "#################################################################"
echo "./animator -v -t '[%Y/%m/%d %H:%M:%S]' sin_week_int.data"
./animator -v -t '[%Y/%m/%d %H:%M:%S]' sin_week_int.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

37) echo "#################################################################"
echo "Testing one valid input file with timeformat not matching the default"
echo "-v is used"
echo "-t '[%Y/%m/%d %H:%M:%S]' is used to set timeformat"
echo "#################################################################"
echo "./animator -v -t '[%Y/%m/%d %H:%M:%S]' sin_week_int_part.data"
./animator -v -t '[%Y/%m/%d %H:%M:%S]' sin_week_int_part.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

38) echo "#################################################################"
echo "Testing one valid input file with timeformat not matching the default"
echo "-v is used"
echo "-t '[%Y/%m/%d %H:%M:%S]'is used to set timeformat"
echo "#################################################################"
echo "./animator -v -t '[%Y/%m/%d %H:%M:%S]' sin_week_real.data"
./animator -v -t '[%Y/%m/%d %H:%M:%S]' sin_week_real.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

39) echo "#################################################################"
echo "Testing one valid input file with timeformat not matching the default"
echo "-v is used"
echo "-t '[%Y/%m/%d %H:%M:%S]' is used to set timeformat"
echo "#################################################################"
echo "./animator -v -t '[%Y/%m/%d %H:%M:%S]' sin_week_real_part.data"
./animator -v -t '[%Y/%m/%d %H:%M:%S]' sin_week_real_part.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;



101) echo "#################################################################"
echo "Valid input matching default timeformat"
echo "-e invalid number of gnuplot point"
echo "#################################################################"
echo './animator -v -e "modulo=10:type=201" sin_small.data'
./animator -v -e "modulo=10:type=201" sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

102) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default but -t is used to produce error in timeformat mismatch"
echo "-v is used"
echo "-t '[%H:%M:%S %d.%m.%Y]' is used to set timeformat"
echo "#################################################################"
echo "./animator -v -t '[%H:%M:%S %d.%m.%Y]' sin_small.data"
./animator -v -t '[%H:%M:%S %d.%m.%Y]' sin_small.data;;

103) echo "#################################################################"
echo "Testing one invalid input file where timeformat matches default but some lines are misordered"
echo "-v is used"
echo "#################################################################"
echo "./animator -v sin_noncontinuous.data"
./animator -v sin_noncontinuous.data;;

104) echo "#################################################################"
echo "Testing two valid input files where timeformat matches default but files overlap"
echo "-v is used"
echo "#################################################################"
echo "./animator -v sin_small.data sin_small_overlap.data"
./animator -v sin_small.data sin_small_overlap.data;;

105) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-S is used to set invalid negative speed"
echo "#################################################################"
echo "./animator -v -S -2 sin_small.data"
./animator -v -S -2 sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

106) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-e with invalid key valua pair is used"
echo "#################################################################"
echo './animator -v -e "modulo=5" -e"thisiswrong=3" sin_small.data'
./animator -v -e "modulo=5" -e"thisiswrong=3" sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

107) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-e modulo way too large for 200 line input file is used"
echo "#################################################################"
echo './animator -v -e "modulo=300" sin_small.data'
./animator -v -e "modulo=300" sin_small.data
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

108) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-e modulo way too large for 200 line input file is used"
echo " using || to test if exitcode is nonzero after producing an error"
echo "#################################################################"
echo './animator -v -e "modulo=300" sin_small.data || echo "EXIT CODE NONZERO, SOMETHING WENT WRONG!"'
./animator -v -e "modulo=300" sin_small.data || echo "EXIT CODE NONZERO, SOMETHING WENT WRONG!"
exiftool -directory -filename -filetype -filesize -duration -videoframerate ./dots/anim.mp4 2>/dev/null;;

109) echo "#################################################################"
echo "Testing one valid input file where timeformat matches default but -S is used with wrong val"
echo "-v is used"
echo "-S superquick"
echo "#################################################################"
echo './animator -v -S superquick sin_small.data'
./animator -v -S superquick sin_small.data;;

110) echo "#################################################################"
echo "Testing one valid input file where timeformat matches default but -f used with invalid path"
echo "-v is used"
echo "-f nothinghere"
echo "#################################################################"
echo "./animator -v -f nothinghere sin_small.data"
./animator -v -f nothinghere sin_small.data;;

111) echo "#################################################################"
echo "Testing one valid input file where timeformat matches default but -f used with unreadable file"
echo "-v is used"
echo "-f /etc/shadow"
echo "#################################################################"
echo './animator -v -f /etc/shadow sin_small.data'
./animator -v -f /etc/shadow sin_small.data;;

112) echo "#################################################################"
echo "Testing one valid input file where timeformat matches default but -f used with unreadable file"
echo "-v is used"
echo "-f empty.cfg"
echo "#################################################################"
echo "./animator -v -f empty.cfg sin_small.data"
./animator -v -f empty.cfg sin_small.data;;

113) echo "#################################################################"
echo "Testing one valid input file where timeformat matches default and one unreadable file"
echo "-v is used"
echo "#################################################################"
echo "./animator -v sin_small.data /etc/shadow"
./animator -v sin_small.data /etc/shadow;;

114) echo "#################################################################"
echo "Testing one valid input file where timeformat matches default and one nonexistent file "
echo "-v is used"
echo "#################################################################"
echo "./animator -v sin_small.data ./nothere"
./animator -v sin_small.data ./nothere;;

115) echo "#################################################################"
echo "Testing input of one nonexistent file "
echo "-v is used"

echo "#################################################################"
echo "./animator -v ./nothere"
./animator -v ./nothere;;

116) echo "#################################################################"
echo "Testing one valid input file where timeformat matches default and one empty file "
echo "-v is used"
echo "#################################################################"
echo "./animator -v sin_small.data empty.data"
./animator -v sin_small.data empty.data;;

117) echo "#################################################################"
echo "Testing one valid input file where timeformat matches default and -S is zero"
echo "-v is used"
echo "-S 0"
echo "#################################################################"
echo "./animator -v -S 0 sin_small.data"
./animator -v -S 0 sin_small.data;;

118) echo "#################################################################"
echo "Testing one valid input file where timeformat matches default and -S is zero"
echo "-v is used"
echo "-S 0.000"
echo "#################################################################"
echo "./animator -v -S 0.000 sin_small.data"
./animator -v -S 0.000 sin_small.data;;

119) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default"
echo "-v is used"
echo "-T negative duration"
echo "#################################################################"
echo "./animator -v -T -2 sin_small.data"
./animator -v -T -2 sin_small.data;;


120) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default, but containing empty line"
echo "-v is used"
echo "#################################################################"
echo "./animator -v sin_small_whitespace.data"
./animator -v sin_small_whitespace.data;; 

121) echo "#################################################################"
echo "Testing one valid input file with timeformat matching the default, but containing empty line"
echo "-v is used"
echo "#################################################################"
echo "./animator -v sin_small_baddate.data"
./animator -v sin_small_baddate.data;; 




*) echo "Invalid test number $arg" ;;
esac
done



