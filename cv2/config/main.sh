#!/bin/bash

VERBOSE=0
DEBUG=0

function err
{
	printf -- "%s [ERROR]: %s\n" "$0" "$@" >&2
	exit 2
}

function usage
{
	echo "USAGE:	parse_conf.sh [-vd] conf_file..."
	echo "		parse_conf.sh -h"
	echo "		-v verbose"
	echo "		-d debug"
	echo "		-h help"
}

while getopts "vdh" opt
do
	case $opt in
	v)
		VERBOSE=1
	;;

	d)
		DEBUG=1
	;;

	h)
		usage
		exit 0
	;;
	
	?)
		usage
		exit 2
	;;
	esac
done
shift $((OPTIND - 1))

for i in "$@"
do
	[[ ! -e "$i" ]] && err "File does not exist."
	[[ ! -f "$i" ]] && err "Given argument is not a file."
	[[ ! -r "$i" ]] && err "File is not readable."	
done

config=$(mktemp)
cat "$@" >> "$config"

while read line
do
	[ "$DEBUG" -eq 1 ] && printf -- "[%s]\n" "$line"
	[ "$VERBOSE" -eq 1 ] && printf -- "%s=\"%s\"\n" "$(cut -d' ' -f1 <<< "$line")" "$(cut -d' ' -f2 <<< "$line")"
	declare "$(cut -d' ' -f1 <<< "$line")"="$(cut -d' ' -f2 <<< "$line")"
done < <(grep -v '^#\|^$' "$config" | tr -s ' ')

rm ${config}
