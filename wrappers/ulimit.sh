#!/bin/sh
# INSTALL: rename to binaryname.sh
for _o in s l m ; do
  ulimits -${_o} unlimited
done
exec "${0%%.sh}" $*
