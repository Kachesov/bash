#!/bin/bash
args=("$@")	
NAME=""
TYPE=""
DIR=""

match(){
if [ "-$TYPE" "$1" ]; then
  if [[ "$1" == $NAME ]]; then
    echo "$1"
  fi
fi
}

find(){
for filename in "$1"/*
do
  match ${filename##*/}
  if [ -d "$filename" ]; then
    find "$filename"
  fi
done
}

parse(){
if [ $# == 5 ]; then
  DIR="${args[4]}"
  if [ args[0]=="-type" ]; then
    if [ args[2]=="-iname" ]; then     
      NAME="${args[3]}"
      TYPE="${args[1]}"
    fi
  else
    if [ args[2]=="-type" ]; then
      if [ args[0]=="-iname" ]; then
        NAME="${args[1]}"
        TYPE="${args[3]}"
      fi
    fi
  fi
fi     
}

main(){
  parse "$@"
  find "$DIR"	
}

main "$@"