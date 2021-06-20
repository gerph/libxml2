#!/bin/bash
##
# Create links for the RISC OS format of the source from the upstream directory.
#

mkdir -p c h
mkdir -p include/libxml/h

# Source files
for file in ../upstream/*.c ; do
  ln -sf ../"$file" c/$(basename "$file" .c)
done
for file in ../upstream/*.h ; do
  ln -sf ../"$file" h/$(basename "$file" .h)
done

# Include files
for file in ../upstream/include/libxml/*.h ; do
  ln -sf ../../../"$file" include/libxml/h/$(basename "$file" .h)
done
