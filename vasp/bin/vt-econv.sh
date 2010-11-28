#!/bin/bash

. $(dirname ${0})/../lib/h.sh

# options -----------------------------------------------------------------------
_inp="${1:-OSZICAR}"
_keep=false
if test $# -gt 1 ; then
  while getopts khi: opt; do
    case "$opt" in
      i) _inp=$OPTARG;;
      k) _keep=true;;
      h) echo "Usage: $(basename $0) [-k] [-i input]"; exit 1;;
    esac
  done
else
  _inp="${1}"
fi

inp=${_inp%%.gz}
dat=${inp}.dat
plt=${inp}.plt

if test "${_inp}" != "${inp}" ; then
  CAT=${ZCAT}
fi

# fiter out energies ------------------------------------------------------------
${CAT} "${inp}" | \
awk '/^ *[0-9]+ *F=/{gsub(/=/,"",$8);printf "%4d %12.6f %12.6f %21.9f\n",$1,$3,$5,$8}' \
> ${dat}

# plot --------------------------------------------------------------------------
cat > ${plt} << EOF
set term x11
set title "Energy Convergence - ${inp}"
set xlabel "Step"
set ylabel "Energy [eV]"
set pointsize 2
plot "${dat}" using 1:2 title "calcs" with points, \
     "${dat}" using 1:2 smooth csplines title "csplines"
EOF

${GPLOT} -persist ${plt}
if ! ${_keep} ; then
  rm ${dat} ${plt}
fi
