% SPDX-FileCopyrightText: 2026 Alexandru Fikl <alexfikl@gmail.com>
% SPDX-License-Identifier: CC0-1.0

% <<< preamble

\def\fileversion{v2026.4}
\def\filedate{2026/07/18}
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
\PassOptionsToClass{a4paper, fontsize=11bp, parskip=false, footnotes=multiple}{scrartcl}

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
    % NOTE: the official docx file also has this bigger for some reason. It is what it is.
    bottom=3.25cm,
    left=2cm,
    right=2cm,
    headsep=0.75cm,
    footskip=1cm,
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
\if@pncdiform
    \RequirePackage[romanian]{babel}
    \selectlanguage{romanian}
\else
    \RequirePackage[english]{babel}
    \selectlanguage{english}
\fi

% >>>

% <<< commands

\NewDocumentCommand \pncdiauthor { m } {\def\pncdi@author{#1}}
\NewDocumentCommand \pncdimentor { m } {\def\pncdi@mentor{#1}}
\NewDocumentCommand \pncdititle { m } {\def\pncdi@title{#1}}
\NewDocumentCommand \pncdiacronym { m } {\def\pncdi@acronym{#1}}
\NewDocumentCommand \pncdiinstitution { m } {\def\pncdi@institution{#1}}
\NewDocumentCommand \pncdiidentifier { m } {\def\pncdi@identifier{#1}}

\NewDocumentCommand \insertpncdiauthor {} {\pncdi@author}
\NewDocumentCommand \insertpncdimentor {} {\pncdi@mentor}
\NewDocumentCommand \insertpncdititle {} {\pncdi@title}
\NewDocumentCommand \insertpncdiacronym {} {\pncdi@acronym}
\NewDocumentCommand \insertpncdiinstitution {} {\pncdi@institution}
\NewDocumentCommand \insertpncdiidentifier {} {\pncdi@identifier}

\NewDocumentCommand \rodate {} {\two@digits{\the\day}.\two@digits{\the\month}.\the\year}
\NewDocumentCommand \gendered { m m } {\if@masculine#1\else\if@feminine#2\else\textbf{NOGENDER}\fi\fi}

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

\NewDocumentCommand \pncdicheckbox {} {%
\mathord{\mbox{%
    \setlength{\fboxrule}{.4pt}%
    \setlength{\fboxsep}{0pt}%
    \fbox{\rule{0pt}{1.6ex}\hspace{1.6ex}}%
}}%
}
\NewDocumentCommand \pncdicheckboxselect {} {%
\mathord{\mbox{%
    \setlength{\fboxrule}{.4pt}%
    \setlength{\fboxsep}{0pt}%
    \fbox{\rule{0pt}{1.6ex}\makebox[1.6ex]{\Large\textbf{\texttimes}}}%
}}%
}

\if@draftproposal
    \newcount\timehh
    \timehh=\time \divide\timehh by 60
    \newcount\timemm
    \timemm=\time \count255=\timehh \multiply\count255 by -60 \advance\timemm by \count255

    \def\draftheader{
        \textcolor{black!50}{
        \textit{Draft of \today\ at
        \ifnum\timehh<10 0\fi\number\timehh
        \,:\,%
        \ifnum\timemm<10 0\fi\number\timemm}}}
\else
    \def\draftheader{\empty}
\fi

\if@draftproposal
    \NewDocumentCommand \comment { m } { \textit{#1}}

    \newenvironment{pncdiexplanation}{
        \begingroup
        \setlist{leftmargin=*, nosep}
        \setlength{\parskip}{0pt}%
        \itshape
    }{
        \endgroup
    }
\else
    \NewDocumentCommand \comment { m } {}
    \newenvironment{pncdiexplanation}{\setbox\z@\vbox\bgroup}{\egroup}
\fi

% >>>

% <<< required formatting

\definecolor{PNCDITableGray}{RGB}{217, 217, 217}
\definecolor{PNCDITableLightGray}{RGB}{242, 242, 242}
\definecolor{PNCDITableYellow}{RGB}{255, 255, 204}

% force spacing
\singlespacing
\setstretch{1.15}

% reduce list spacing a bit too
\setlist{
    itemsep=0.25\baselineskip,
    parsep=0pt,
    topsep=0.5\baselineskip,
    partopsep=0pt
}

\ifpdftex
    \usepackage[T1]{fontenc}
    \usepackage{mathptmx}
\else
    \usepackage{fontspec}
    \IfFontExistsTF{TeX Gyre Termes}{
        \usepackage{unicode-math}

        \setmainfont{TeX Gyre Termes}
        \setmathfont{TeX Gyre Termes Math}
    }{
        \PackageWarning{pncdi-pd}{TeX Gyre Termes not found, falling back to Latin Modern}
    }
\fi

% force serif fonts
\addtokomafont{disposition}{\rmfamily}
\setkomafont{descriptionlabel}{\normalfont\bfseries}

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
    linkcolor=UrlColor,
    % NOTE: these are here so we can pretend we were generated by Google Docs,
    % in case anybody asks, not nice, but it is what it is
    pdftitle={PD2026\_Cerere finantare\_sectiunea B},
    pdfproducer={Skia/PDF m152 Google Docs Renderer},
    pdfcreator={},
}
\renewcommand{\UrlFont}{\bfseries\ttfamily}

\if@pncdib
    \if@draftproposal
        \RequirePackage[mathlines]{lineno}
        \RenewDocumentCommand \linenumberfont {} {
            \normalfont\footnotesize\textcolor{black!50}
        }

        \AtBeginDocument{
            \if@draftproposal
                \linenumbers
            \fi
        }
    \fi
\fi

% >>>

% <<< page header/footer styles

\pncdiidentifier{PN-IV-RU-SC-PD-2026-1}

\clearpairofpagestyles
\pagestyle{scrheadings}

\if@pncdiform
    \cfoot{\normalfont \pncdi@identifier}
    \pagenumbering{gobble}
\fi

\if@pncdia
    \cfoot{\normalfont \pncdi@identifier}
    \pagenumbering{gobble}
\fi

\if@pncdib
    \cfoot{\normalfont \pncdi@identifier}
    \ofoot{\pagemark}
    \ihead{\draftheader}
\fi

\if@pncdic
    \cfoot{\normalfont \pncdi@identifier}
    \pagenumbering{gobble}
\fi

% >>>

% <<< section styles

% tighted sections a bit for more space
\RedeclareSectionCommand[beforeskip=0.5em, afterskip=0.5em, font=\normalsize\bfseries]{section}
\RedeclareSectionCommand[beforeskip=0.5em, afterskip=0.5em, font=\normalsize\bfseries]{subsection}
\RedeclareSectionCommand[beforeskip=0.5em, afterskip=0.5em, font=\normalsize\bfseries]{subsubsection}

\if@pncdia
    \renewcommand{\thesection}{A.\arabic{section}.}
\fi

\if@pncdib
    \renewcommand{\thesection}{B.\arabic{section}.}
\fi

\renewcommand*{\thesubsection}{\thesection\arabic{subsection}.}
\renewcommand*{\thesubsubsection}{\thesubsection\arabic{subsubsection}.}

% >>>

\endinput
