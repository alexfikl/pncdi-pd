TEXMK := "latexmk"
TEXOUTDIR := "latex.out"
TEXFLAGS := "-pdflua -output-directory=" + TEXOUTDIR

_default:
    @just template

# {{{ pdf
[private]
pdf basename:
    {{ TEXMK }} {{ TEXFLAGS }} {{ basename }}.tex
    @cp {{ TEXOUTDIR }}/{{ basename }}.pdf .
    exiftool -Subject= -Keywords= -overwrite_original {{ basename }}.pdf

[doc("Compile templates")]
template:
    @just pdf pncdi-pd-annex-3-a-template
    @just pdf pncdi-pd-annex-3-b-template
    @just pdf pncdi-pd-annex-31-cv-template
    @just pdf pncdi-pd-annex-51-template
    @just pdf pncdi-pd-annex-52-template
    @just pdf pncdi-pd-annex-53-template
    @just pdf pncdi-pd-annex-54-template
    @just pdf pncdi-pd-annex-55-template
    @just pdf pncdi-pd-annex-56-template
    @just pdf pncdi-pd-annex-57-template
    @just pdf pncdi-pd-annex-58-template

# }}}
# {{{ linting

[doc("Format source files")]
format: yamlfmt mdformat justfmt

[doc("Format YAML files with yamlfmt")]
yamlfmt:
    yamlfmt -gitignore_excludes .
    @echo -e "\e[1;32myamlfmt clean!\e[0m"

[doc("Format markdown files with mdformat")]
mdformat:
    python -m mdformat .
    @echo -e "\e[1;32mmdformat clean!\e[0m"

[doc("Run just --fmt over the justfile")]
justfmt:
    just --unstable --fmt
    @echo -e "\e[1;32mjust --fmt clean!\e[0m"

[doc("Run all linting checks over the source code")]
lint: typos

[doc("Check for typos (using typos)")]
typos:
    typos --sort --files --config typos.toml
    @echo -e "\e[1;32mtypos clean!\e[0m"

# }}}
# {{{ develop

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

# }}}
