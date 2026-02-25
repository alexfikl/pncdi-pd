% SPDX-FileCopyrightText: 2026 Alexandru Fikl <alexfikl@gmail.com>
% SPDX-License-Identifier: CC0-1.0

% <<< preamble

\def\fileversion{v1.0}
\def\filedate{2026/02/24}
\def\clsname{pncdi-pd}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{\clsname}[\filedate\ \fileversion\ PNCDI Postdoctoral (PD) Grants]

% >>>

% <<< declare options

% draft features
\newif\if@draftproposal \@draftproposalfalse
\DeclareOption{draftproposal}{\@draftproposaltrue}

% gendered
\newif\if@masculine \@masculinefalse
\DeclareOption{masculine}{\@masculinetrue}
\newif\if@feminine \@femininefalse
\DeclareOption{feminine}{\@femininetrue}

% part features
\newif\if@pncdiform \@pncdiformfalse
\DeclareOption{pncdiform}{\@pncdiformtrue}
\newif\if@pncdia \@pncdiafalse
\DeclareOption{pncdia}{\@pncdiatrue}
\newif\if@pncdib \@pncdibfalse
\DeclareOption{pncdib}{\@pncdibtrue}
\newif\if@pncdic \@pncdicfalse
\DeclareOption{pncdic}{\@pncdictrue}

% grid
\newif\if@layoutgrid \@layoutgridfalse
\DeclareOption{layoutgrid}{\@layoutgridtrue}
\newif\if@showframe \@showframefalse
\DeclareOption{showframe}{\@showframetrue}

% additional options passed to `scrartcl` class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\PassOptionsToClass{a4paper, fontsize=11bp, parskip=half, footnotes=multiple}{scrartcl}

\ProcessOptions
\LoadClass{scrartcl}

% >>>

% <<< required packages

% NOTE: load packages after the class was loaded since they may depend on it

\RequirePackage{iftex}
\RequirePackage{xparse}
\RequirePackage[table]{xcolor}
\RequirePackage[hypertexnames=false,breaklinks=true]{hyperref}

% geometry
\RequirePackage[
    top=2cm,
    bottom=2cm,
    left=2cm,
    right=2cm,
    footskip=1.15cm,
]{geometry}

% customize headers and footers
\RequirePackage{scrlayer-scrpage}
% set recommended spacing
\RequirePackage{setspace}

% for everybody's benefit
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{csquotes}
\RequirePackage[activate=true,final]{microtype}

% language
\RequirePackage[romanian]{babel}
\selectlanguage{romanian}

% >>>

% <<< commands

\NewDocumentCommand \pncdiauthor { m } {\def\pncdi@author{#1}}
\NewDocumentCommand \pncdititle { m } {\def\pncdi@title{#1}}
\NewDocumentCommand \pncdiinstitution { m } {\def\pncdi@institution{#1}}
\NewDocumentCommand \pncdiidentifier { m } {\def\pncdi@identifier{#1}}

\NewDocumentCommand \rodate {} {\the\day.\the\month.\the\year}

\NewDocumentCommand \gendered { m m } {\if@masculine #1\else \if@feminine #2 \else \textbf{??REF} \fi \fi}
\NewDocumentCommand \placeholder {s O{8} m} {%
\IfBlankTF{#3}{
    % no argument given
    \begingroup
    \count0=0
    \loop
        .\kern+0.2em
        \advance\count0 by 1
        \ifnum\count0<#2
        \repeat
    \endgroup
}{%
    % argument given
    \IfBooleanTF{#1}{\textbf{#3}}{#3}%
}%
}

\if@draftproposal
    \NewDocumentCommand \comment { m } {\textit{#1}}
\else
    \NewDocumentCommand \comment { m } {}
\fi

% >>>

% <<< required formatting

\definecolor{PNCDITableYellow}{RGB}{255, 255, 204}

\singlespacing
\setstretch{1.15}

\ifpdftex
    \usepackage[T1]{fontenc}
    \usepackage{mathptmx}
\else
    \usepackage{fontspec}
    \IfFontExistsTF{Times New Roman}{
        \setmainfont[Ligatures=Rare]{Times New Roman}}{
        \IfFontExistsTF{Nimbus Roman}{
            \setmainfont{Nimbus Roman}
        }{\PackageWarning{erc-stg}{No Times New Roman-type font could be found}}}
\fi

% force serif fonts
\addtokomafont{disposition}{\rmfamily}

% enable this to better check sizing
\if@showframe
    \RequirePackage{showframe}
\fi

\if@layoutgrid
    \RequirePackage[
        grid,
        gridunit=cm,
        gridcolor=gray!70,
        subgridcolor=gray!70,
        texcoord]{eso-pic}
\fi

\AtBeginDocument{
    % customize PDF bookmarks a bit
    \RequirePackage{bookmark}
    \bookmarksetup{numbered}
}

% make links a bit less intrusive
\definecolor{UrlColor}{HTML}{0072BD}
\hypersetup{
    colorlinks=true,
    urlcolor=UrlColor,
    citecolor=UrlColor,
    linkcolor=UrlColor
}
\renewcommand{\UrlFont}{\bfseries\ttfamily}

% >>>

% <<< page header/footer styles

\pncdiidentifier{PN-IV-RU-SC-PD-2026-1}

\if@pncdiform
    \clearpairofpagestyles
    \cfoot{\normalfont \pncdi@identifier}
    \pagenumbering{gobble}
\fi

\if@pncdia
    \clearpairofpagestyles
    \cfoot{\normalfont \pncdi@identifier}
    \pagenumbering{gobble}
\fi

% >>>

% <<< section styles

% tighted sections a bit for more space
\RedeclareSectionCommand[beforeskip=0.5em, afterskip=0.5em, font=\normalsize\bfseries]{section}
\RedeclareSectionCommand[beforeskip=0.5em, afterskip=0.5em, font=\normalsize\bfseries]{subsection}
\RedeclareSectionCommand[beforeskip=0.25em, afterskip=0.25em, font=\normalsize\bfseries]{subsubsection}

\if@pncdia
    \renewcommand{\thesection}{A.\arabic{section}.}
\fi

\if@pncdib
    \renewcommand{\thesection}{B.\arabic{section}.}
\fi

\renewcommand*{\thesubsection}{\thesection\arabic{subsection}.}

% >>>
