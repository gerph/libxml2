#!/bin/bash
##
# Build all the binaries from the sources.
#

set -e

clean=false
if [[ "$1" == '--clean' ]] ; then
    clean=true
fi

if $clean ; then
    riscos-amu -f MakefileLib,fe1 clean
fi
riscos-amu -f MakefileLib,fe1 export
for tool in xmlLint \
            xmlCatalog \
            testAutomata \
            testC14N \
            testRelax \
            testReader \
            testXPath \
            testHTML \
            testURI \
            testSAX ; do
    riscos-amu -f MakefileTools,fe1 TARGET=${tool}
done
