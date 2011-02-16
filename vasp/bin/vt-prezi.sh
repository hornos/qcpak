#!/bin/bash

. $(dirname ${0})/../lib/h.sh

function usage() {
  echo "Usage: $(basename $0) [-p prefix]"
  exit 1
}

# options -----------------------------------------------------------------------
_force=false

if test $# -gt 1 ; then
  while getopts p:fh opt; do
    case "$opt" in
      p) _pre=$OPTARG;;
      h) usage;;
    esac
  done
else
  if test "${1}" = "-h" ; then
    usage
  fi
 _pre=${1:-SiC}
fi

for i in * ; do
  mv -fv "${i}" "${_pre}.${i}"
done

gzip -v *
