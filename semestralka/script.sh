#!/bin/bash
# Skript generuje animaci grafu ze zadanych dat

shopt -s extglob

USAGE=()
USAGE+=("Usage:  $0 [-v] [-o ext] data...")
USAGE+=("        $0 [-h]")
USAGE+=("           -o output_extension")
USAGE+=("           -v  verbose")
USAGE+=("           -h  this help")

ECODE=1
VERBOSE=0
OUTPUT=anim.mp4

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
	#awk -F " " '{print $NF}' "$1" | egrep -v '^-?([0-9]+|[0-9]*\.[0-9]+)$' && err "Bad data format in '$1'"
        egrep -v '^-?([0-9]+|[0-9]*\.[0-9]+)$' "$1" && err "Bad data format in '$1'"

}

function video {
	test_arg "$1"
	DATA=$1

	# Limity podle datoveho souboru
	LINES=$(wc -l <"$DATA")
	verbose "$arg has $LINES lines"
	YRANGE=$(sort -n "$DATA" | sed -n '1p;$p' | paste -d: -s)
	verbose "$arg has $YRANGE range"
	FMT=$TMP/%0${#LINES}d.png
	verbose "tmp file FMT set to $FMT"
	# Vygenerovat snimky animace
	for ((i=1;i<=LINES;i++))
	do
		{
			cat <<-PLOT
				set terminal png
				set output "$(printf "$FMT" $i)"
				plot [0:$LINES][$YRANGE] '-' with lines t ''
				PLOT
			head -n $i "$DATA"
		} | gnuplot
		((p=100*i/LINES,p%10==0?first:(first=1,0))) && { vverbose "Done: $p%"; first=0; }
	done

	# Spojit snimky do videa
	ffmpeg -y -i "$FMT" -- "$DATA.$OUTPUT" >/dev/null 2>/dev/null
}


##############################
# Zpracovani prepinacu
while getopts vho: opt
do
	case $opt in
		v) ((VERBOSE++));;
		h) printf "%s\n" "$USAGE"; ECODE=0; exit ;;
		o) OUTPUT=$OPTARG;;
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
	verbose "Processing: $arg"
	video "$arg"
done


ECODE=0
