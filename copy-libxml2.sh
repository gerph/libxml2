#!/bin/bash
##
# Copy the sources from a released libxml2 directory to the 'upstream' directory.
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

rm upstream/*.c upstream/*.h upstream/include/libxml/*.h
cp "${base_dir}"/*.c upstream/
cp "${base_dir}"/*.h upstream/
cp "${base_dir}"/include/libxml/*.h upstream/include/libxml/
cp "${base_dir}"/COPYING upstream/
