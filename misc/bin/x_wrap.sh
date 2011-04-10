#!/bin/bash
#/// \file x_wrap.sh
#/// \brief wraps binaries into shell exec eggs
#///

function __usage() {
  echo "Usage: $(basename ${0}) -p pattern -w wrapper.sh"
}

### defaults
_sfx=".sh"
_cpy=false
_del=false
_pat="${1:-vasp}"
_wrp="x_ulimit.sh"
_q="-v"

### options
if test "${1}" = "-h" ; then
  __usage
  exit 1
fi

while getopts hp:w:cdq opt; do
  case "$opt" in
    h) __usage; exit 1;;
    p) _pat=$OPTARG;;
    w) _wrp=$OPTARG;;
    c) _cpy=true;;
    d) _del=true;;
    q) _q="-v"
  esac
done

### main
if ! test -x "${_wrp}" ; then
  echo "Not executable: ${_wrp}"
  exit 1
fi

for x in ${_pat}* ; do
  if test "${x%%${_sfx}}${_sfx}" != "${x}${_sfx}" ; then
    continue
  fi
  if ! test -x "${x}" ; then
    continue
  fi
  _wx="${x}${_sfx}"
  if test -x "${_wx}" ; then
    if ${_del} ; then
      rm ${_q} -f "${_wx}"
      continue
    else
      continue
    fi
  fi
  if ${_cpy} ; then
    cp ${_q} "${_wrp}" "${_wx}"
  else
    ln ${_q} -s "${_wrp}" "${_wx}"
  fi
done
