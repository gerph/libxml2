# LibXML2

## Building

To build there are sources inside the RISC OS directory which should be able to be
built with the AMU tool:

On non-RISC OS systems:

    cd RISCOS
    riscos-amu -f MakefileLib,fe1 export
    riscos-amu -f MakefileTools,fe1 TARGET=xmlLint
    riscos-amu -f MakefileTools,fe1 TARGET=xmlCatalog
    riscos-amu -f MakefileTools,fe1 TARGET=testAutomata
    riscos-amu -f MakefileTools,fe1 TARGET=testC14N
    riscos-amu -f MakefileTools,fe1 TARGET=testHTML
    riscos-amu -f MakefileTools,fe1 TARGET=testReader
    riscos-amu -f MakefileTools,fe1 TARGET=testRelax
    riscos-amu -f MakefileTools,fe1 TARGET=testSAX
    riscos-amu -f MakefileTools,fe1 TARGET=testURI
    riscos-amu -f MakefileTools,fe1 TARGET=testXPath

## Updating to the latest upstream version

- Clone the libxml2 repository at https://gitlab.gnome.org/GNOME/libxml2
    - `git clone https://gitlab.gnome.org/GNOME/libxml2.git`
- Check out the tag for the version to be used.
    - `git checkout v2.9.12`
- Build it, to ensure that it works and generate necessary headers with the right defines and version numbers.
    - `./autogen.sh`
    - `make`
- In this repository, checkout the branch `vendor`.
    - `git checkout vendor`
- Create a new branch in the form `vendor-<X>.<Y>.<Z>`.
    - `git checkout -b vendor-2.9.12`
- Run the `copy-base.sh <directory>` to update the sources to the this version.
    - `./copy-bash.sh ~/external/libxml2`
- Add any extra files that have been created and commit the changes.
    - `git add *.c *.h include/libxml/*.h`
    - `git commit -m "Import of version 2.9.12"`
- Merge the branch into the vendor branch.
    - `git checkout vendor`
    - `git merge vendor-2.9.12`
- Check out the master branch to return to the current version of the OS.
    - `git checkout master`
- Create a new branch for merging in the vendor branch in the form `merging-<X>.<Y>.<Z>`.
    - `git checkout -b merging-2.9.12`
- Merge in the vendor branch.
    - `git merge vendor-2.9.12`
- Link any new files into the RISC OS file structures.
    - `./link-original.sh`
- Update the `MakefileLib,fe1` to add any extra files that need building or exporting
- Build everything, from clean.
    - `cd RISCOS`
    - `./build-all.sh --clean`
- Fix any breakages caused by conflicts in the merge, and repeat.
- Add new files which are linked by the build process
    - `git add c/* h/* include/libxml/h/*`
- Commit the merged version of the vendor branch.
    - `git commit`
- Update the `PORTVERSION` in the `c/xmllint` and `c/xmlcatalog` files.
- Test the new version and add any changed files.
- Commit changes to the merging branch.
    - `git commit`
- Merge into the master branch, and tag in the form `libxml2-<X>.<Y>.<Z>`.
    - `git checkout master`
    - `git merge merging-2.9.12`
    - `git tag libxml2-2.9.12`
- Push the changes to the repository.
