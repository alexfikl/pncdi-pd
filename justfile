TEXMK := "latexmk"
TEXOUTDIR := "latex.out"
TEXFLAGS := "-pdflua -output-directory=" + TEXOUTDIR

_default:
    @just --list

[private]
pdf basename:
    {{ TEXMK }} {{ TEXFLAGS }} {{ basename }}.tex
    @cp {{ TEXOUTDIR }}/{{ basename }}.pdf .

[doc("Compile templates")]
template:
    @just pdf pncdi-pd-annex-3-a-template
    # @just pdf pncdi-pd-annex-3-b-template
    # @just pdf pncdi-pd-annex-31-cv-template
    @just pdf pncdi-pd-annex-51-template
    @just pdf pncdi-pd-annex-52-template
    @just pdf pncdi-pd-annex-53-template
    @just pdf pncdi-pd-annex-54-template
    @just pdf pncdi-pd-annex-55-template
    @just pdf pncdi-pd-annex-56-template
    @just pdf pncdi-pd-annex-57-template
    @just pdf pncdi-pd-annex-58-template

[doc("Check for typos (using typos)")]
typos:
    typos --sort --files --config typos.toml
    @echo -e "\e[1;32mtypos clean!\e[0m"

[doc("Update license text")]
license:
    python -m reuse download CC0-1.0
    cp LICENSES/CC0-1.0.txt LICENSE
    @rm -rf LICENSES

[doc("Remove all temporary compilation files")]
clean:
    rm -rf {{ TEXOUTDIR }}

[doc("Remove all generated files")]
purge: clean
    rm -rf *.pdf
