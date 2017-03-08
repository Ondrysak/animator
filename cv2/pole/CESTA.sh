function array_cp {
  NEW=( 303 420 909 )
  unset CESTA
  CESTA=()
  for i in ${!NEW[*]}
  do
    CESTA+=( "${NEW[$i]}" )
  done
}

function append {
 KVOK=()
  for i in "${!CESTA[@]}"
  do
    [[ ! "$1" == "${CESTA[$i]}" ]] && KVOK+=( "${CESTA[$i]}" )
  done
  KVOK+=( "$1" )
  CESTA=( ${KVOK[*]} )
}

function prepend {
  KVOK=()
  KVOK+=( "$1" )
  for i in "${!CESTA[@]}"
  do      
    [[ ! "$1" == "${CESTA[$i]}" ]] && KVOK+=( "${CESTA[$i]}" )
  done
  CESTA=( ${KVOK[*]} )
}


CESTA=( "$(echo $PATH | tr ':' ' ')" )
array_cp
append 505
echo ${CESTA[*]}
echo ${#CESTA[*]}
prepend 101
echo ${CESTA[*]}
prepend 505
echo ${CESTA[*]}

