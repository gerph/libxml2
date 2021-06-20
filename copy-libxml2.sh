#!/bin/bash
##
# Copy the sources from a released libxml2 directory to the 'original' directory.
#

set -e

base_dir=$1
if [[ "$base_dir" == "" ]] ; then
    echo "Syntax: $0 <libxml2 directory>" >&2
    exit 1
fi

if [[ ! -f "${base_dir}/xmllint.c" ]] ; then
    echo "This does not look like a libxml2 directory" >&2
    exit 1
fi

rm original/*.c original/*.h original/include/libxml/*.h
cp "${base_dir}"/*.c original/
cp "${base_dir}"/*.h original/
cp "${base_dir}"/include/libxml/*.h original/include/libxml/
cp "${base_dir}"/COPYING original/
