#!/bin/bash
# Skript generuje animaci grafu ze zadanych dat

shopt -s extglob
export LC_ALL=C

USAGE=()
USAGE+=("Usage:  $0 [-v] [-o ext] data...")
USAGE+=("        $0 [-h]")
USAGE+=("           -o output_extension")
USAGE+=("           -v  verbose")
USAGE+=("           -h  this help")

ECODE=1
VERBOSE=0
OUTPUT=anim.mp4
DOTS=10
SPEED=1
#change time default format to [%Y-%m-%d %H:%M:%S]
TIMEFORMAT='[%Y/%m/%d %H:%M:%S]'
DURATION=''
CHECK=0
YMIN=auto
YMAX=auto
NAME=dots
# Funkce

function verbose { ((VERBOSE)) && printf "$0[debug]: %s\n" "$@" >&2; }
function vverbose { ((VERBOSE>1)) && printf "$0[debug]: %s\n" "$@" >&2; }
function err { printf "$0[error]: %s\n" "$@" >&2; exit; }

function test_arg {
	[ -n "$1" ] || err "Empty argument"
	[ -f "$1" ] || err "Argument '$1' is not a file"
	[ -r "$1" ] || err "Data file '$1' is not readable"
	[ -s "$1" ] || err "Data file '$1' is empty"
	#test if last field (value) is in correct format
	awk -F " " '{print $NF}' "$1" | egrep -v '^-?([0-9]+|[0-9]*\.[0-9]+)$' && err "Bad data format in '$1'"
        #egrep -v '^[0-9]+ -?([0-9]+|[0-9]*\.[0-9]+)$' "$1" && err "Bad data format in '$1'"
    awk '{$NF=""; print $0}' "$1" | ./datestd.pl "$TIMEFORMAT" >/dev/null 2>/dev/null || err "Date in $1 is not in correct format"
    verbose "Argument $1 checked!"

}

function preq {
type ffmpeg >/dev/null || err "It seems like ffmpeg is not installed"
type gnuplot >/dev/null || err "It seems like gnuplot is not installed"
perldoc -l DateTime::Format::Strptime >/dev/null || err "Seems like perl module DateTime::Format:Strptime is not installed"

}

function max_folder {
  max=0
  for file in *
  do
    temp=$(echo $file | grep -E "^$1_[0-9]+$" | sed "s/${1}_//")
    [[ -d $file  ]] && [[ $max -lt $temp ]] && max=$temp
  done
  max=$(($max + 1))
  mkdir "${1}_${max}" ||  err "Could not create folder ${1}_${max}"
  echo "${1}_${max}"
}
function process_arg {

    verbose "Processing: $1"
        test_arg "$1"
        #maybe could a problem to do this when using absolute path
    FIRSTDATE="$(head -n1 $1 | sed 's/ [^\ ]*$//')"
        #check return code
        #echo $(./dates.pl "$TIMEFORMAT" "$FIRSTDATE") "${arg}">>${TMP}/unsorted
        epoch=$(./dates.pl "$TIMEFORMAT" "$FIRSTDATE") || err "Date on first line of $arg is not in correct format"
        echo "$epoch" "$1">>${TMP}/unsorted
}
function process_arg {

    verbose "Processing: $1"
        test_arg "$1"
        #maybe could a problem to do this when using absolute path
    FIRSTDATE="$(head -n1 $1 | sed 's/ [^\ ]*$//')"
        #check return code
        #echo $(./dates.pl "$TIMEFORMAT" "$FIRSTDATE") "${arg}">>${TMP}/unsorted
        epoch=$(./dates.pl "$TIMEFORMAT" "$FIRSTDATE") || err "Date on first line of $arg is not in correct format"
        echo "$epoch" "$1">>${TMP}/unsorted
}

function video {
	DATA=$1
        verbose "Using modulo $DOTS for points"
	#create file with dots using awk and row numbers
	awk -v DTCOUNT="$DOTS" 'NR%DTCOUNT==0 {print $0}' "$1">"${TMP}/dots"

	# Limity podle datoveho souboru
	LINES=$(wc -l <"$DATA")
	verbose "$1 has $LINES lines"
        #ymin ymax dle parametru
        if [ "$YMIN" = auto ]; then
	TMPYMIN=$( awk -F " " '{print $NF}' "$DATA" | sort -n | sed -n '1p')
        elif [ "$YMIN" = min ]; then
        TMPYMIN=$( awk -F " " '{print $NF}' "$DATA" | sort -n | sed -n '1p')
        else
        TMPYMIN="$YMIN"
        fi

        if [ "$YMAX" = auto ]; then
        TMPYMAX=$( awk -F " " '{print $NF}' "$DATA" | sort -n | sed -n '$p')
        elif [ "$YMAX" = max ]; then
        TMPYMAX=$( awk -F " " '{print $NF}' "$DATA" | sort -n | sed -n '$p')
        else
        TMPYMAX="$YMAX"
        fi

	YRANGE=$( echo "${TMPYMIN}:${TMPYMAX}")
	verbose "$1 has $YRANGE range"
	FMT=$TMP/%0${#LINES}d.png
	verbose "tmp file FMT set to $FMT"
        verbose "timeformat set to $TIMEFORMAT"
        verbose "speed set to $SPEED"	
        # Vygenerovat snimky animace
        local i
        local k
        local float
        i=1
        k=1
        float=1
	while [ $i -le $LINES ]
	do
		{
			cat <<-PLOT
				set terminal png
                                set timefmt "$TIMEFORMAT"
				set xdata time
                                set yrange [$YRANGE]
                                set format x"%H:%M"
                                set grid
                                set output "$(printf "$FMT" $k)"
				plot '-' using 1:3 with lines t '', "${TMP}/dots" using 1:3 w p t '' 
				PLOT
			head -n $i "$DATA"
		} | gnuplot
		((p=100*i/LINES,p%10==0?first:(first=1,0))) && { vverbose "Done: $p%"; first=0; }
	        float=$(echo "$float+$SPEED" | bc)
                i=$(echo "$float/1" | bc)
                k=$(($k+1))
        done
        verbose "GNUPLOT done, ffmpeg comes into play"
	#vytvorit slozku pro vystup
        mkdir $NAME 2>/dev/null || NAME=$(max_folder $NAME)
     # Spojit snimky do videa   
	if [[ -z "$DURATION" ]]; then
        ffmpeg -y -i "$FMT" -- "${PWD}/${NAME}/${OUTPUT}" >/dev/null 2>/dev/null
        else
        FPS=$(echo "($LINES)/($DURATION*$SPEED)" | bc -l)
        verbose "Calculated FPS based on speed and duration is $FPS"
        ffmpeg -framerate $FPS -y -i "$FMT" -- "${PWD}/${NAME}/${OUTPUT}" >/dev/null 2>/dev/null
        fi
	

}

preq

##############################
# Zpracovani prepinacu
while getopts vho:d:t:s:T:y:Y:n: opt
do
	case $opt in
		v) ((VERBOSE++));;
		h) printf "%s\n" "$USAGE"; ECODE=0; exit ;;
		o) OUTPUT=$OPTARG;;
                d) DOTS=$OPTARG;;
                t) TIMEFORMAT=$OPTARG;;
                s) SPEED=$OPTARG;;
                T) DURATION=$OPTARG;;
                y) YMIN=$OPTARG;;
                Y) YMAX=$OPTARG;;
                n) NAME=$OPTARG;;
		\?) err "$USAGE";
	esac
done
shift $((OPTIND-1))

# Adresar pro docasne soubory
TMP=$(mktemp -d) || { echo "Cannot create temporary directory" >&2; exit 1; }
trap 'rm -rf "$TMP"; exit $ECODE' EXIT
verbose "Temp dir: $TMP"



EXT=${OUTPUT##*.}
case $EXT in
	mp4|avi|mpeg|mpg) : ;;
	*) err "Unrecognisable outout format '$EXT'";;
esac


# Osetreni parametru
[ $# -ge 1 ] || err "Arguments missing" "${USAGE[@]}"



for arg
do

if [[ "$arg" =~ ^http ]]; then
verbose "Downloading $arg"
wget --quiet -O - "$arg" > "${TMP}/download" || err "Download of $arg failed"
process_arg "${TMP}/download";
else
process_arg "$arg";
fi

done

cat ${TMP}/unsorted | sort -n >${TMP}/sorted


verbose "Merging input files"

while read line; do
  filename=$(echo $line | awk '{print $NF}')
  cat "$filename">>"${TMP}/merge"
done <${TMP}/sorted

verbose "Files merged in  ${TMP}/merge $#"
k=0

#check all parametres if they collide or anything

video "${TMP}/merge"
ECODE=0
