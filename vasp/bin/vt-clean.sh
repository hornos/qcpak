#!/bin/bash

. $(dirname ${0})/../lib/h.sh

function usage() {
  echo "Usage: $(basename $0) [-f] [-p pattern]"
  exit 1
}

# options -----------------------------------------------------------------------
_force=false

if test $# -gt 1 ; then
  while getopts p:fh opt; do
    case "$opt" in
      p) _pat=$OPTARG;;
      f) _force=true;;
      h) usage;;
    esac
  done
else
  if test "${1}" = "-h" ; then
    usage
  fi
 _pat=${1:-WAVECAR}
fi

if ${_force} ; then
  _opts="-f"
else
  _opts="-i"
fi

for f in $(find . -name *${_pat}*) ; do
  rm -v ${_opts} "${f}"
done
