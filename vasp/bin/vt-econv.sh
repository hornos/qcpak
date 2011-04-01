#!/bin/bash
# shpak header
. $(dirname ${0})/../../../shpak/lib/h.sh

sp_f_load @vasp

function __usage() {
  echo "Usage: $(basename $0) [-k] [-i input]"
  exit 1
}

# options -----------------------------------------------------------------------
_inp="${1:-OSZICAR}"
_keep=false
_spline=false
if test $# -gt 1 ; then
  while getopts kshi: opt; do
    case "$opt" in
      i) _inp=$OPTARG;;
      k) _keep=true;;
      s) _spline=true;;
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
dat=${inp}.dat
plt=${inp}.plt

_cat=${sp_b_cat}
if test "${_inp}" != "${inp}" ; then
  _cat=${sp_b_zcat}
fi

# fiter out energies ------------------------------------------------------------
${_cat} "${inp}" | \
awk '/^ *[0-9]+ *F=/{gsub(/=/,"",$8);printf "%4d %12.6f %12.6f %21.9f\n",$1,$3,$5,$8}' \
> ${dat}

# plot --------------------------------------------------------------------------
cat > ${plt} << EOF
set term x11
set title "Energy Convergence - ${inp}"
set xlabel "Step"
set ylabel "Energy [eV]"
set pointsize 2
EOF
if ${_spline} ; then
cat >> ${plt} << EOF
plot "${dat}" using 1:2 title "calcs" with points, \
     "${dat}" using 1:2 smooth csplines title "csplines"
EOF
else
cat >> ${plt} << EOF
plot "${dat}" using 1:2 title "calcs" with points
EOF
fi

${sp_b_gpl} -persist ${plt}
if ! ${_keep} ; then
  rm ${dat} ${plt}
fi
