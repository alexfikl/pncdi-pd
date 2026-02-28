# PNCDI-PD: LaTeX Template

[![GitHub Actions Workflow Status](https://github.com/alexfikl/pncdi/actions/workflows/ci.yml/badge.svg)](https://github.com/alexfikl/pncdi-pd/actions/workflows/ci.yml)
[![Open in Overleaf](https://img.shields.io/static/v1?label=LaTeX&message=Open-in-Overleaf&color=47a141&style=flat&logo=overleaf)](https://www.overleaf.com/docs?snip_uri=https://github.com/alexfikl/pncdi-pd/archive/refs/heads/main.zip)

> [!WARNING]
> These templates target the PD 2026 call, which is still not finalized. As such,
> they have **not been submitted** to the UEFISCDI yet and may be inelligible. However,
> we strive to keep as close as possible to the provided documents and will update
> the template as required going forward. Any suggestions for improvements and
> bug reports for inconsistencies are **very welcome**!

This repository contains templates for the
[Postdoctoral Research Grants](https://uefiscdi.gov.ro/proiecte-de-cercetare-postdoctorala-pd)
from UEFISCDI. The latest version targets the PD 2026 call and contains templates
for the forms in the manual annexes. In particular, we have

1. **Annex 3 A**: Identification Information (this is provided for book keeping and
   should not be submitted).
2. **Annex 3 B**: Project Description (main document).
3. **Annex 3.1**: CV.
4. **Annex 5.1-5.8**: Various forms and disclosures required for grant submission.

> [!WARNING]
> These are not all the required documents for the grant. Read the official
> manual carefully before submitting.

## Usage

The templates follow the guidelines given in the official grant manual as closely
as possible. To use them, we recommend to:

1. Copy all the LaTeX files and the `pncdi-pd.cls` file to some desired location.
2. Remove all the `-template` suffixes (potentially add name or project acronym instead).
3. Start filling in the documents with a close eye on the official requirements!
4. Once the documents are filled in, remember to remove the `draftproposal` option.

### Forms

The forms (i.e. the `pncdi-pd-annex-5X-template.tex` files) require minimal changes.
In particular:

1. In the `documentclass`, change `masculine` to your preferred gender. Once the
   form is filled out, also remove the `draftproposal` option (this will remove
   all the italic comments in the forms).
2. Fill in the `\placeholder` commands with your information.
3. Adding signatures probably requires printing or using some fancier electronic
   signature. Consult the official manual and instructions for this part.

### Project Description

The main project description can be found in `pncdi-pd-annex-3-b-template.tex`.
This has some main sections, but is generally very field dependent, so it is up
to the project director to include all the required information. We merely try to
help with the typography of it all!

The CV should be filled in through the `pncdi-pd-annex-31-cv-template.tex` document.

The `pncdi-pd-annex-3-a-template.tex` contains addititional metadata about the
project and should not be submitted. This information needs to be filled in on the
EVOC platform at submission time.

## Documentation

The `pncdi-pd` class contains all the requirements for the project templates. It
has some minimal options to control its behavior. The main document class options
are given below.

| Option                            | Description                           |
| :-                                | :-                                    |
| `draftproposal`                   | Adds helpful comments and other drafting helpers |
| `masculine`                       | Sets the gender in the grant forms to masculine |
| `feminine`                        | Sets the gender in the grant forms to feminine |
| `pncdiform`                       | Flag that marks the current document as a form |
| `pncdia`                          | Flag that marks the template for Annex 3 A |
| `pncdib`                          | Flag that marks the template for Annex 3 B |
| `pncdic`                          | Flag that marks the template for Annex 3.1 |
| `showframe`                       | Shows a frame for page margins (debug) |
| `layoutgrid`                      | Shows a grid on the page to check margins (debug) |

All the templates in this project are already correctly marked with e.g. `pncdiform`
and should not be changed. However, the gender should be chosen appropriately
for each document and form (the forms are meant for the project director, mentor,
and institution representative and could have different genders!). This is mostly
meant to avoid writings like `Subsemnatul/Subsemnata` and uses the command
`\gendered{<masculine>}{<feminine>}`.

The template defines the following commands.

| Command                           | Description                           |
| :-                                | :-                                    |
| `\pncdiauthor{<>}`                | Project director full name            |
| `\insertpncdiauthor`              | Retrieves the author name             |
| `\pncdititle{<>}`                 | Project full title                    |
| `\insertpncdititle`               | Retrieves the project title           |
| `\pncdiacronym{<>}`               | Project acronym                       |
| `\insertpncdiacronym`             | Retrieves the project acronym
| `\pncdiinstitution{<>}`           | The hosting instutition for the project |
| `\insertpncdiinstitution`         | Retrieves the host institution        |
| `\pncdiidentifier{<>}`            | Sets the grant call identifier        |
| `\insertpncdiidentifier`          | Retrieves the grant call identifier   |
| `\rodate`                         | A more locale specific formatted date |
| `\gendered{<m>}{<f>}`             | Choose one of the two word inflections |
| `\placeholder*[<w>]{<>}`          | Adds a little dotted placeholder for forms |
| `\comment{<>}`                    | Adds italic text based on `draftproposal` |

The `\pncdiidentifier` command should generally not be set by the user. Instead
we suggest updating the template in `pncdi-pd.cls`.

The `\placeholder` command is slightly more complex and requires additional
explanation. It can be used to achieve 3 results based on the options:

1. `\placeholder[10]{}`: adds a set of 10 uniformly spaced dots to signal a part
   of a form that needs to be filled in.
2. `\placehoder[10]{Content}`: ignores the `[10]` dots part (could even be removed)
   and just shows the contents.
3. `\placeholder*{Content}`: similar to the above, but makes the text bold.

The empty dotted placeholders (as provided here), use the first form. The user can
then fill them in using the second or third form, as desired.

## License

[Creative Commons Zero v1.0 Universal](https://creativecommons.org/public-domain/cc0/) (CC0-1.0).
