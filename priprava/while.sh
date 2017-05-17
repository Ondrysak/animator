#!/bin/bash
filename=passwd
while read line; do
echo $line 
echo hello
done < /etc/"$filename"