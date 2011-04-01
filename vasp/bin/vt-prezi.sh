#!/bin/bash
# shpak header
. $(dirname ${0})/../../../shpak/lib/h.sh

function __usage() {
  echo "Usage: $(basename $0) [-p prefix]"
  exit 1
}

# options
_force=false

if test $# -gt 1 ; then
  while getopts p:fh opt; do
    case "$opt" in
      p) _pre=$OPTARG;;
      f) _force=true;;
      h) __usage;;
    esac
  done
else
  if test "${1}" == "-h" ; then
    __usage
  fi
 _pre=${1:-SiC}
fi

sp_f_stt "Directory list"
ls -lA *

sp_f_yesno "Start"
if test $? -gt 0 ; then
  exit 1
fi

sp_f_stt "Rename"
for i in * ; do
  sp_f_sfx "${i}" "${_pre}." false
  if test $? -gt 0 || ${_force}; then
    mv -fv "${i}" "${_pre}.${i}"
  fi
done

sp_f_stt "Compress"
gzip -v *
