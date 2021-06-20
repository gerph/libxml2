#!/bin/bash
##
# Build all the binaries from the sources.
#

set -e

instdir=inst

clean=false
if [[ "$1" == '--clean' ]] ; then
    clean=true
fi

# Remove the installation directory ensure we build it again.
rm -rf "${instdir}"

if $clean ; then
    riscos-amu -f MakefileLib,fe1 clean
fi
riscos-amu -f MakefileLib,fe1 export
for tool in xmllint \
            xmlcatalog \
            testAutomata \
            testC14N \
            testRelax \
            testReader \
            testXPath \
            testHTML \
            testURI \
            testSAX ; do
    riscos-amu -f MakefileTools,fe1 TARGET=$tool install INSTDIR=${instdir}
done
