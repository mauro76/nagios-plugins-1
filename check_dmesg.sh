#!/usr/bin/env sh

output=$(dmesg -T -l crit,alert,emerg 2>/dev/null || dmesg || exit 3)
if test ! -z "$output"; then
  filtered_output=$({
    echo $output | egrep -o -i \
    'Hardware Error|I/O error|hard resetting link|DRDY ERR'
  })

  if test ! -z "$filtered_output"; then
    echo 'WARNING - The dmesg output contain error(s) :'
    echo $filtered_output
    exit 1
  fi
fi

echo "OK - The dmesg command output doesn't seem contain error."
exit 0