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
# FIXME: Cannot build the following binaries:
#           runtest
#           schematron
#           testrecurse
for tool in xmllint \
            xmlcatalog \
            testapi \
            testAutomata \
            testchar \
            testdict \
            testC14N \
            testHTML \
            testlimits \
            testModule \
            testOOM \
            testReader \
            testRegexp \
            testRelax \
            testSAX \
            testSchemas \
            testURI \
            testXPath \
            runxmlconf \
            runsuite ; do
    riscos-amu -f MakefileTools,fe1 TARGET=$tool install INSTDIR=${instdir}
done

# Build the Catalogs resource
cd catalogs
if $clean ; then
    riscos-amu -f Makefile,fe1 clean
    rm -rf Install
fi
riscos-amu -f Makefile,fe1 install INSTDIR=Install
cd ..
