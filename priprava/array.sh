#!/bin/bash
export CESTA
( IFS=':'; CESTA=( $(echo "$PATH") ) ) 
echo "${CESTA[*]}";