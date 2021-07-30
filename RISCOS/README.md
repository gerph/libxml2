# RISC OS LibXML2

This release contains the LibXML2 library, the tools and the !Catalogs resource.

## Library

The library can be found in the `Lib` directory, and contains a build of the sources
in 26bit, 32bit, application and module formats. This is intended for use with the
RISC OS SharedCLibrary.

## Tools

There are two tools supplied, in the `Tools` directory:

* `XMLLint` can be used to check the well-formedness of XML files, and may be used
  to validate content.
* `XMLCatalog` can be used to manipulate the configuration of the XML Catalog
  resources within the `!Catalogs` resources.

## !Catalogs resource

The `!Catalogs` resource may be copied within the `!Boot.Resources` directory
for global use. It provides a local storage for centrally managed well known
documents. For example the HTML DTD or common style sheets could be placed
within the `!Catalogs` resource to make them available without having to resort
to network access.
