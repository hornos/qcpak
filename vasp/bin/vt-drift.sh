#!/bin/bash
# shpak header
. $(dirname ${0})/../../../shpak/lib/h.sh

sp_f_load @vasp

function __usage() {
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
      h) __usage;;
    esac
  done
else
  if test "${1}" = "-h" ; then
    __usage
  fi
  _inp="${1}"
fi

inp=${_inp%%.gz}
dat=${inp}_drift.dat
plt=${inp}_drift.plt

_cat=${sp_b_cat}
if test "${_inp}" != "${inp}" ; then
  _cat=${sp_b_zcat}
fi

# fiter out energies ------------------------------------------------------------
${_cat} "${inp}" | \
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
${sp_b_gpl} -persist ${plt}
if ! ${_keep} ; then
  rm ${dat} ${plt}
fi
