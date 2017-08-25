. ./flash-card.sh --source-only
. $(dirname $0)/helper/test_helper.sh

declare -r target_output='tests/temp_files'

setUp()
{
  mkdir -p $target_output
}

tearDown()
{
  rm -rf $target_output
}

test_usage_helper ()
{
  local first_line=$(usage | head -1)
  assertEquals 'Usage: flash-card [OPTION]' "$first_line"
}

load_shunit2
