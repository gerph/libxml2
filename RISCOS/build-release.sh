#!/bin/bash
##
# Build the releases from the sources.
#

set -e

RELEASE_DIR=Release

./build-binaries.sh

rm -rf "${RELEASE_DIR}"

mkdir -p "${RELEASE_DIR}"
mkdir -p "${RELEASE_DIR}/Lib"
mkdir -p "${RELEASE_DIR}/Tools/XML/Help"

cp inst/xmllint,ff8 "${RELEASE_DIR}/Tools/XML/XMLLint,ff8"
cp inst/xmlcatalog,ff8 "${RELEASE_DIR}/Tools/XML/XMLCatalog,ff8"
cp ../upstream/COPYING "${RELEASE_DIR}/COPYING"
cp -R inst/docs "${RELEASE_DIR}/"
cp -R "${LIB_DIR}/libxml" "${RELEASE_DIR}/Lib/libxml"

# Obtain the help messages
# The help messages can only be reported by running the tool, so we send it off to the build service
# to run the tool and return the help messages so that we can put them in the right place.
tmpdir="${TMPDIR:-/tmp}/ro-libxml2.$$"
mkdir -p "$tmpdir"
cp help-robuild.yaml "$tmpdir/.robuild.yaml"
cp inst/xml* help-extract,feb "$tmpdir/"
(
    echo "Processing files in '$tmpdir'"
    cd "$tmpdir"
    zip -9r source-archive.zip xml* help-extract,feb .robuild.yaml

    if [[ "$(uname -s)" == 'Darwin' ]] ; then
        # Assume that it's already installed on the system
        rbo=riscos-build-online
    else
        curl -s -L -o "riscos-build-online" https://github.com/gerph/robuild-client/releases/download/v0.05/riscos-build-online && chmod +x riscos-build-online
        rbo=./riscos-build-online
    fi
    "$rbo" -i "$tmpdir/source-archive.zip" -o "$tmpdir/output" -t 20

    unzip "$tmpdir/output,a91"
)

# Now process those messages into our help.
./help-conversion.pl "$tmpdir/xmlcatalog-help" "${RELEASE_DIR}/Tools/XML/Help/XMLCatalog"
./help-conversion.pl "$tmpdir/xmllint-help" "${RELEASE_DIR}/Tools/XML/Help/XMLLint" "$tmpdir/xmllint-version"

rm -rf "$tmpdir"
