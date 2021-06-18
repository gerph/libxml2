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
