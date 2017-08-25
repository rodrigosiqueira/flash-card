. ./flash-card.sh --source-only
. $(dirname $0)/helper/test_helper.sh

test_template_control_list ()
{
  select_db
  assertEquals $? 0
}

load_shunit2
