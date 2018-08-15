#!/usr/bin/env bash

alias di='meld .'
alias st='git status -s'
alias ci='git commit'

which php > /dev/null && {
    alias xdebug='XDEBUG_CONFIG="idekey=PHPSTORM COMPOSER_ALLOW_XDEBUG=1" php'
}

which mysql > /dev/null && alias mysql='mysql -p'

which mysql > /dev/null && which mysqldump > /dev/null && dump() {
  local DB="oxid_"$1
  shift
  local LIKE_TERM=${1-%}
  shift
  local SQL="SHOW TABLES WHERE \`Tables_in_"$DB"\` NOT LIKE 'oxv\_%' AND \`Tables_in_"$DB"\` LIKE '"$LIKE_TERM"';"
  echo -n "DB password: "
  read -s DB_PASS
  for t in $(mysql -NBA -u oxid -p$DB_PASS -D $DB -e "$SQL")
  do
    echo "DUMPING TABLE: $t"
    mysqldump $@ -u oxid -p$DB_PASS $DB $t > $t.sql
  done
  return 0
}

[ -d $HOME/.local/share/JetBrains/Toolbox/apps/PhpStorm/ch-0 ] && phpstorm() {
    local script=$(ls $HOME/.local/share/JetBrains/Toolbox/apps/PhpStorm/ch-0/*/bin/phpstorm.sh | sort -r | head -1)
    "$script" "$@"
}

[ -d $HOME/.local/share/JetBrains/Toolbox/apps/PyCharm-C/ch-0 ] && pycharm() {
    local script=$(ls $HOME/.local/share/JetBrains/Toolbox/apps/PyCharm-C/ch-0/*/bin/pycharm.sh | sort -r | head -1)
    "$script" "$@"
}