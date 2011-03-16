#!/bin/bash

pat="${1:-APPLE}"

echo "" | cpp -dM | grep "${pat}"
