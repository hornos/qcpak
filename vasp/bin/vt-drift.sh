#!/bin/bash

. $(dirname ${0})/../lib/h.sh

function usage() {
  echo "Usage: $(basename $0) [-k] [-i input]"
  exit 1
}

# options -----------------------------------------------------------------------
_inp="${1:-OUTCAR}"
_keep=false
if test $# -gt 1 ; then
  while getopts khi: opt; do
    case "$opt" in
      i) _inp=$OPTARG;;
      k) _keep=true;;
      h) usage;;
    esac
  done
else
  if test "${1}" = "-h" ; then
    usage
  fi
  _inp="${1}"
fi

inp=${_inp%%.gz}
dat=${inp}_drift.dat
plt=${inp}_drift.plt

if test "${_inp}" != "${inp}" ; then
  CAT=${ZCAT}
fi

# fiter out energies ------------------------------------------------------------
${CAT} "${inp}" | \
awk 'BEGIN{step=0} /^ *total drift:/{++step;printf "%3d  0.0 0.0 0.0   %12.6f %12.6f %12.6f\n",step,$3,$4,$5}' \
> ${dat}

lines=$(cat "${dat}" | wc -l)

# plot --------------------------------------------------------------------------
cat > ${plt} << EOF
set term x11
set title "Total Drift - ${inp}"
set palette negative maxcolors ${lines}
splot "${dat}" using 2:3:4:5:6:7:1 with vectors linetype palette title "Steps"
pause -1
EOF

echo "Press Enter"
${GPLOT} -persist ${plt}
if ! ${_keep} ; then
  rm ${dat} ${plt}
fi
