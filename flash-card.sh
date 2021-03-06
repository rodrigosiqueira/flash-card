# Copyright (C) 2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU general public license,
# Version 3.  See the file COPYING for more details

#!/bin/bash

declare -r FLASH_CARD_DB="flash-card-db"
declare -r EXTENSION=".fc"

function usage ()
{
  echo 'Usage: flash-card [OPTION]'
  echo -e "\t-l\tList available flash card db"
  echo -e "\t-i\tInput a specific flash card"
  echo -e "\t-h\tHelp information"
}

function list-dbs ()
{
  local partialName=""
  for i in flash-card-db/*; do
    partialName=$(basename $i)
    echo " " ${partialName%".fc"}
  done
}

function select_db ()
{
  local selected=$1
  local pathToRead=$FLASH_CARD_DB/$selected$EXTENSION
  local -A askAnswer

  mapfile -t mappedFileToArray < $pathToRead
  dbSize=${#mappedFileToArray[@]}
  index=$(( $RANDOM % $dbSize ))

  # Split string based on ':' and create an array of assotiative values
  while IFS=':' read key value; do
    askAnswer["$key"]="$value"
  done <<< "${mappedFileToArray[$index]}"
  echo ${!askAnswer[@]}
  echo ${askAnswer[@]}
}

function flash-card ()
{
  local -A parameters
  local OPTIND
  while getopts "i:lh" options; do
    case $options in
      i)
        parameters[$options]=$OPTARG
      ;;
      l)
        list-dbs
        return 0
      ;;
      h | * | \?)
        usage
        return 0
      ;;
    esac
  done

  select_db ${parameters["i"]}
}
