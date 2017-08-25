#!/bin/sh

declare -r BLUECOLOR="\033[1;34;49m%s\033[m\n"
declare -r REDCOLOR="\033[1;31;49m%s\033[m\n"
declare -r GREENCOLOR="\033[1;31;92m%s\033[m\n"
declare -r SEPARATOR="========================================================="

function say()
{
  message="$@"
  if [ -t 1 ]; then
    printf $GREENCOLOR "$message"
  else
    echo "$message"
  fi
}

# Execute all tests
for test_entry in tests/*.sh; do
  say "Test:" $test_entry
  say $SEPARATOR
  bash $test_entry
done
