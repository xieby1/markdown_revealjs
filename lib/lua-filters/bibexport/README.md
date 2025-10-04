# bibexport

> **Warning**
>
> This filter is deprecated, as the functionality is now include
> in pandoc. Use `--to=biblatex` with this filter instead:
>
> ``` lua
> function Pandoc (doc)
>   doc.meta.references = pandoc.utils.references(doc)
>   doc.meta.bibliography = nil
>   return doc
> end
> ```

Export all cited references into a single bibtex file. This is
most useful when writing collaboratively while using a large,
private bibtex collection. Using the bibexport filter allows to
create a reduced bibtex file suitable for sharing with
collaborators.

## Prerequisites

This filter expects the `bibexport` executable to be installed
and in the user's PATH. Installation differs across systems.
Users of the TeX Live distribution can install the [bibexport]
package by running

    tlmgr install bibexport

Windows appears to be unsupported at the moment.

[bibexport]: https://www.ctan.org/pkg/bibexport

## Usage

The filter runs `bibexport` on a temporary *aux* file, creating
the file *bibexport.bib* on success. The name of the temporary
*.aux* file can be set via the `auxfile` meta value; if no value
is specified, *bibexport.aux* will be used as filename.

Please note that `bibexport` prints messages to stdout. Pandoc
should be called with the `-o` or `--output` option instead of
redirecting stdout to a file. E.g.

    pandoc --lua-filter=bibexport.lua article.md -o article.html

or, when the filter is called in a one-off fashion

    pandoc --lua-filter=bibexport.lua article.md -o /dev/null
