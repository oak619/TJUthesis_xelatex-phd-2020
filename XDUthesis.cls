\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{XDUthesis}[2015/01/01 XDU, Thesis document class, version 0.1.0]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   class and packages

%%%%%%%%%%%%%%%%%%%%
%% Options
%%%%%%%%%%%%%%%%%%%%

%% disable oneside option
\DeclareOption{oneside}{\OptionNotUsed}


%% print version or electronic version
\newif\ifXDU@Option@PrintVersion \XDU@Option@PrintVersiontrue
\DeclareOption{eversion}{\XDU@Option@PrintVersiontrue}
\DeclareOption{pversion}{\XDU@Option@PrintVersionfalse}

%% info
\newif\ifXDU@Option@info \XDU@Option@infotrue
\DeclareOption{noinfo}{\XDU@Option@infofalse}

%% ref
\newif\ifXDU@Option@ref@sort \XDU@Option@ref@sortfalse
\newif\ifXDU@Option@ref@compress \XDU@Option@ref@compressfalse
\DeclareOption{refsort}{\XDU@Option@ref@sorttrue}
\DeclareOption{refcompress}
  {\XDU@Option@ref@sorttrue\XDU@Option@ref@compresstrue}

%% others
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%
%% load class and packages
%%%%%%%%%%%%%%%%%%%%

%% book
%%
%\LoadClass[zihao=-4,UTF8,twoside,fontset=windows]{ctexbook}
\LoadClass[zihao=-4,UTF8,twoside,fontset=none]{ctexbook}
\RequirePackage[a4paper]{geometry}

%% calc
\RequirePackage{calc}

%% ifthen
\RequirePackage{ifthen}

\RequirePackage{multirow}
\RequirePackage{graphicx}
\RequirePackage{diagbox}
\RequirePackage{subfigure}
% \captionsetup{compatibility=false}
\RequirePackage{booktabs} %制作三线表
\RequirePackage{float} %禁止某个浮动体的浮动效果，可以使用 float 宏包提供的 H 位置选项。
\RequirePackage[justification=centering]{caption}
\RequirePackage{tikz}
\RequirePackage{color}
\usetikzlibrary{positioning} % LATEX and plain TEX
\RequirePackage{siunitx} %国际标准单位
\RequirePackage{eqnarray}
\RequirePackage{bm}


\RequirePackage[titles,subfigure]{tocloft}
% \renewcommand{\figurename}{图} \renewcommand{\tablename}{表}
% \newlength{\mylen}
% \renewcommand{\cftfigpresnum}{\figurename\enspace}
% \settowidth{\mylen}{\cftfigpresnum\cftfigaftersnum}
% \addtolength{\cftfignumwidth}{\mylen}

\renewcommand{\@dotsep}{1}
\renewcommand{\@pnumwidth}{0.5em}
\renewcommand{\@tocrmarg}{1.5em}
% \renewcommand{\l@section}{\@dottedtocline{1}{1.5em}{2.3em}}
% \renewcommand{\l@figure}{\@dottedtocline{1}{1.5em}{1.3em}}
% \setlength{\cftsecnumwidth}{1em}
\setlength{\cftfignumwidth}{0em}
% \setlength{\cfttabnumwidth}{1em}
% \renewcommand{\cftdot}{\ensuremath{\ast}}
% \setlength{\cftXindent}{1em}
% \cftsetindents{figure}{0em}{0.5em}
% \renewcommand{\cftXpresnum}{SOMETHING }
% \renewcommand{\numberwidth}{2em}
% \renewcommand{\l@section}{\@dottedtocline{1}{1.5em}{1.5em}}

% \RequirePackage{caption}

\RequirePackage{diagbox}

%% natbib
\ifXDU@Option@ref@sort
  \ifXDU@Option@ref@compress
    \RequirePackage[numbers,sort&compress,super,square]{natbib}
  \else
    \RequirePackage[numbers,sort,super,square]{natbib}
  \fi
\fi
\newcommand*{\citens}[2][]{%
  \begingroup
  \let\NAT@mbox=\mbox
  \let\@cite\NAT@citenum
  \let\NAT@space\NAT@spacechar
  \let\NAT@super@kern\relax
  \renewcommand\NAT@open{[}%
  \renewcommand\NAT@close{]}%
  \cite[#1]{#2}%
  \endgroup
}

%使得参考文献的引用变为右上角小标
% \newcommand{\upcite}[1]
% {\textsuperscript{\textsuperscript{\cite{#1}}}}

%% hyperref
\RequirePackage[pdfencoding=auto]{hyperref}

%% color
\ifXDU@Option@PrintVersion\relax\else
  \RequirePackage{color}
\fi

%% config file
\AtEndOfPackage{\makeatletter\input{XDUthesis.def}\makeatother}
\AtEndOfPackage{\makeatletter\input{XDUthesis.cfg}\makeatother}
\AtEndOfPackage{\makeatletter\renewcommand{\numberline}[1]{%
\settowidth\@tempdimb{#1\hspace{0.25em}}%
\ifdim\@tempdima<\@tempdimb%
  \@tempdima=\@tempdimb%
\fi
\hb@xt@\@tempdima{\@cftbsnum #1\@cftasnum\hfil}\@cftasnumb}\makeatother}
\AtEndOfPackage{\makeatletter\@addtoreset{equation}{chapter}\makeatother}
\AtEndOfPackage{\makeatletter \renewcommand{\figurename}{图} \renewcommand{\tablename}{表}
 \def\@caption#1[#2]#3{%
   \\
   \addcontentsline{\csname ext@#1\endcsname}{#1}%
                   {\protect\numberline{\csname #1name\endcsname\hskip0.5em\csname the#1\endcsname}%
                   {\ignorespaces #2}}%
   \begingroup
   \@parboxrestore
   \if@minipage
   \@setminipage
   \fi
   \normalsize
   \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\\
   \endgroup}
 \renewcommand*\l@figure{\@dottedtocline{1}{0em}{4em}}
 \let\l@table\l@figure \makeatother}
 


%%%%%%%%%%%%%%%%%%%%
%% setup packages

% [subrefformat=parens,labelformat=parens]

%%%%%%%%%%%%%%%%%%%%
%% setup
\ifXDU@Option@PrintVersion
  \hypersetup{
    CJKbookmarks,
    bookmarksnumbered,
    colorlinks,
    linkcolor     = black,
    anchorcolor   = black,
    citecolor     = black,
    urlcolor      = black,
    plainpages    = false,
    pdfstartview  = FitH
  }
\else
  \definecolor{XDU@hypercolor@darkgreen}{rgb}{0.1,0.5,0.1}
  \hypersetup{
    CJKbookmarks,
    bookmarksnumbered,
    colorlinks,
    linkcolor     = black,
    anchorcolor   = black,
    citecolor     = black,
    urlcolor      = black,
    plainpages    = false,
    pdfstartview  = FitH
  }
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   utilities

\DeclareRobustCommand{\XDU@toc@add}[1]
  {\phantomsection\addcontentsline{toc}{chapter}{#1}}

%% underline
\def\CJKunderlinecolor{}
\def\XDU@@underline[#1]#2{\CJKunderline {\hbox to #1{\hfill{#2}\hfill}}}
\DeclareRobustCommand{\XDU@underline}
  {\@ifnextchar[\XDU@@underline\CJKunderline }

\DeclareRobustCommand*{\XDU@bold}{\bfseries}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    font 字体设置
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{mathrsfs}
\RequirePackage{calrsfs}

\RequirePackage{titlesec}



\@ifpackageloaded{fontspec}{
    \PassOptionsToPackage{no-math}{fontspec}
}{
    \RequirePackage[no-math]{fontspec}
}
\setmainfont{Times New Roman}
\RequirePackage{mathspec}
\setmathsfont{Times New Roman}
%\usepackage{xeCJK}
% 设置文档正文字体为宋体
\setCJKmainfont[BoldFont=SimHei]{SimSun}
\setCJKmonofont{SimSun}     % 设置缺省中文字体
\setCJKfamilyfont{song}[AutoFakeBold=1]{SimSun}                             %宋体 song  
% \setCJKfamilyfont{song}[AutoFakeBold=true]{SimSun}                             %宋体 song  
\newcommand{\song}{\CJKfamily{song}} %宋体

%\setCJKfamilyfont{hei}{SimHei}                              %黑体  hei 
%\setCJKfamilyfont{hei}[AutoFakeBold=1]{SimHei}                              %黑体  hei  
\setCJKfamilyfont{hei}[AutoFakeBold=true]{SimHei}                              %黑体  hei  
\newcommand{\hei}{\CJKfamily{hei}} %黑体
% \setCJKfamilyfont{zhkai}{KaiTi}
\setCJKfamilyfont{kai}[AutoFakeBold=true]{KaiTi}
\newcommand{\kai}{\CJKfamily{kai}}      % 楷体

%% family
\DeclareRobustCommand*{\XDU@font@st}{\song}
\DeclareRobustCommand*{\XDU@font@ht}{\hei}
\DeclareRobustCommand*{\XDU@font@kt}{\kai}

%% size
\DeclareRobustCommand*{\XDU@font@zihao}[1]{\zihao{#1}\setlength{\baselineskip}{20pt}}

\renewcommand*{\baselinestretch}{1}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    document setting
%% 参考网址：https://en.wikibooks.org/wiki/LaTeX/Page_Layout
%% page ql head
%页边距
\setlength{\textwidth}{\paperwidth-6.34cm}% 3.57+2.77 = 6.34 + 0.8 = 7.14
\setlength{\textheight}{\paperheight-6cm}%
\setlength\marginparwidth{0cm}%
\setlength\marginparsep{0cm}%
\ifXDU@Option@PrintVersion
\setlength{\oddsidemargin}{3.17cm-1in-\hoffset}
\setlength{\evensidemargin}{3.17cm-1in-\hoffset}
\else
\setlength{\oddsidemargin}{3.57cm-1in-\hoffset}
\setlength{\evensidemargin}{2.77cm-1in-\hoffset}
\fi
%\setlength{\headheight}{31pt}%
%\setlength{\headheight}{10.5pt}%
\setlength{\headheight}{31pt}%
%\setlength{\headsep}{0pt}%
%\setlength{\headsep}{1cm-10.5pt}%
%\setlength{\headsep}{25.5pt}%
\setlength{\headsep}{1cm-\headheight}%
\setlength{\topmargin}{3cm-1in-\voffset-\headheight-\headsep}% voffset 正文的垂直偏移
\setlength{\footskip}{3cm-1.75cm}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    head and foot 页眉页脚

\RequirePackage{fancyhdr}
%% remove header from empty page

%\setlength{\headwidth}{\textwidth-4pt-4pt}%
%% label of even page header
\def\XDU@hdr@thesistitle
  {\XDU@label@university\XDU@value@degreemark\XDU@value@thesis}

\fancypagestyle{plain}{
  \pagestyle{fancy}
}

\pagestyle{fancy}
% %% the double line under header，页眉下划线
% \renewcommand{\headrulewidth}{0.5pt}
% \newcommand{\makeheadrule}{%
% \makebox[0pt][l]{\rule[9pt]{\headwidth}{0.5pt}}} %修改页眉又下划线，为单下划线
% % \makebox[0pt][l]{\rule[9pt]{\headwidth}{0.5pt}}%
% % \rule[8pt]{\headwidth}{0.5pt}}
% \renewcommand{\headrule}{%
% {\if@fancyplain\let\headrulewidth\plainheadrulewidth\fi
% \makeheadrule}}
% %\renewcommand{\headrule}{%
% %    {\if@fancyplain\let\headrulewidth\plainheadrulewidth\fi
% %    %\vskip 1pt% 
% %    \hrule\@height\headrulewidth\@width\headwidth
% %    \hrule\@height\headrulewidth\@width\headwidth
% %    \vskip-1\headrulewidth
% %    %\vskip-1pt
% %    }
% %}
\fancypagestyle{content}{
\fancyhf{}
\renewcommand{\headrulewidth}{0.5pt}
\setlength\headsep{5pt}
\fancyhead[CE]{{\XDU@font@st\XDU@font@zihao{5}\XDU@hdr@thesistitle}}
\fancyhead[CO]{{\XDU@font@st\XDU@font@zihao{5}\nouppercase\leftmark}}
\fancyfoot[C]{{\XDU@font@st\XDU@font@zihao{-5}\thepage}}
}
%% set header
\fancypagestyle{precontent}{
    % \renewcommand{\headrulewidth}{0pt}
    \fancyhead{}
    % \fancyhf{} % clear all header and footer fields
    \renewcommand\headrulewidth{0pt}
    % \fancyfoot[C]{{\XDU@font@st\XDU@font@zihao{-5}\thepage}}
%     \renewcommand{\makeheadrule}{%
% \makebox[0pt][l]{\rule[9pt]{\headwidth}{0.5pt}}} %修改页眉又下划线，为单下划线
}
% \pagestyle{content}
% \pagestyle{fancy}
%% par skip
%\parskip 0pt plus 6pt minus 0pt

%% section level 目录深度
\setcounter{secnumdepth}{4}

%% chapter
\ctexset { chapter = { 
                        name={\XDU@chapter@prenumber,\XDU@chapter@afternumber }, 
                        number={\chinese {chapter}}, 
                        format={\centering \XDU@font@ht \XDU@font@zihao {3}}, 
                        nameformat={}, 
                        numberformat={},
                        aftername={\quad },
                        titleformat={}, 
                        beforeskip={12pt}, 
                        afterskip={18pt},
                        indent={0pt} 
                    } 
}

%% chapter without number
\DeclareRobustCommand{\XDU@nchapter}[1]{\chapter*{#1}\markboth{#1}{}}

%% section
\ctexset { section = {
                      name={,}, 
                      number={\thesection }, 
                      format={\raggedright \XDU@font@ht \XDU@font@zihao {4}}, 
                      nameformat={},
                      numberformat={}, 
                      aftername={\quad }, 
                      titleformat={}, 
                      beforeskip={12pt plus 0pt minus 0pt}, 
                      afterskip={0pt}, 
                      indent={0pt} 
                     } 
}

%% subsection
\ctexset { subsection = {
                         name={,}, 
                         number={\thesubsection},
                         format={\raggedright \XDU@font@ht \XDU@font@zihao {-4}},
                         nameformat={}, 
                         numberformat={}, 
                         aftername={\quad }, 
                         titleformat={},
                         beforeskip={12pt plus 0pt minus 0pt}, 
                         afterskip={0pt}, 
                         indent={0em} 
                        } 
}

%% subsubsection
\ctexset { subsubsection = { 
                            name={,}, 
                            number={\thesubsubsection},
                            format={\raggedright \XDU@font@st \XDU@font@zihao {-4}}, 
                            nameformat={},
                            numberformat={}, 
                            aftername={\quad }, 
                            titleformat={}, 
                            beforeskip={12pt plus 0pt minus 0pt}, 
                            afterskip={0pt}, indent={0em} 
                           } 
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    figure and table

%% figure name
\ctexset { figurename={\XDU@font@zihao {5}\XDU@label@figure@cap } }
\renewcommand{\thefigure}{\arabic{chapter}-\arabic{figure}} % 使图编号为 7-1 的格式
%% table name
\ctexset { tablename={\XDU@font@zihao {5}\XDU@label@table@cap } } 
\newcommand{\tabincell}[2]{\begin{tabular}{@{}#1@{}}#2\end{tabular}} %转行
\renewcommand{\thetable}{\arabic{chapter}-\arabic{table}}%使表编号为 7-1 的格式
\renewcommand{\theequation}{\arabic{chapter}-\arabic{equation}}%使公式编号为 7-1 的格式

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    chinese  cover 封面
%% ql first
\DeclareRobustCommand{\XDU@make@cover}
{%天津大学博士学位论文字样
  {\setlength{\parindent}{0pt}\thispagestyle{empty}%
  % \quad
  \vspace*{17pt}
  % \vspace{1cm}
    \begin{center}
      \renewcommand{\baselinestretch}{1.25}
    %  \fontsize{17pt}{\baselineskip}\selectfont  \XDU@hdr@thesistitle 
    %  \vskip 10pt
     \normalfont\XDU@font@st\XDU@font@zihao{2}\setlength{\baselineskip}{30pt}
     {\XDU@bold\XDU@value@thesis@title}\\ 
     \vspace{1cm}
     \normalfont\XDU@font@st\XDU@font@zihao{-2}
     {\XDU@bold\XDU@evalue@thesis@title}

     \vskip 80pt

     \XDU@font@zihao{4}\setlength{\baselineskip}{30pt}%
     \newlength{\linelength}
     \setlength{\linelength}{6cm}
     \XDU@font@st{一级学科：~}\XDU@font@st\XDU@underline[\linelength]{\makebox[\linelength][l]{\XDU@value@author@major}}\\%
     \XDU@font@st{研究方向：~}\XDU@font@st\XDU@underline[\linelength]{\makebox[\linelength][l]{我的研究方向}}\\%
    %  \setlength{\linelength}{4cm}
     \XDU@font@st{作者姓名：~}\XDU@font@st\XDU@underline[\linelength]{\makebox[\linelength][l]{\XDU@value@author@name}}\\%
    %  \setlength{\linelength}{4cm}
     \XDU@font@st{指导教师：~}\XDU@font@st\XDU@underline[\linelength]{\makebox[\linelength][l]{\XDU@value@advisor@name~\XDU@value@advisor@title}}%
 
     \vskip 20pt

     % Please add the following required packages to your document preamble:
% \usepackage{multirow}
\begin{table}[H]
  \renewcommand{\arraystretch}{1.2}%更改行距倍数
  \centering
  % \resizebox{\linewidth}{!}{
  \begin{tabular}{|c|c|c|c|}
  \hline
  答辩日期                & \multicolumn{3}{c|}{2021年5月27日}     \\ \hline
  答辩委员会               & 姓名  & 职称  & 工作单位                    \\ \hline
  主席                  & 钱三  & 教授  & 清华大学                    \\ \hline
  \multirow{6}{*}{委员} & 孙四  & 教授  & 北京航空航天大学 \\ \cline{2-4} 
                      & 王五  & 教授  & 天津大学                    \\ \cline{2-4} 
                      & 赵六  & 教授  & 天津大学                    \\ \cline{2-4} 
                      & 牛七 & 教授  & 天津大学                    \\ \cline{2-4} 
                      & 马八 & 教授  & 天津大学              \\ \cline{2-4} 
                      & 刘九 & 研究员 & 天津大学                    \\ \hline
  \end{tabular}
  % }
  \end{table}

    %  \begin{center}
      \setlength{\baselineskip}{25pt}
     \XDU@value@author@school \\
     \makebox[10em][c]{二〇二一\ 年\ 六\ 月}
    %  \end{center}
    \end{center}
    %空行
    % \normalfont\XDU@font@st\XDU@font@zihao{2}\setlength{\baselineskip}{30pt}%
    % %中英文标题
    % \makebox[\textwidth]{\rule{0pt}{2cm}}
    % \rule[-3.2cm]{0pt}{3.2cm}\parbox[t]{\textwidth}{%
    % \begin{center}%
    %   \vspace{-2cm}
    %     {\XDU@bold\XDU@value@thesis@title}\\ \vspace{2cm}
    %     {\XDU@bold\XDU@evalue@thesis@title}
    % \end{center}%
    % } 
    %学科专业、作者、导师信息
    % \makebox[\textwidth]{\rule{0pt}{3.5cm}}
    % \rule[-3.2cm+15pt]{0pt}{3.2cm}\hspace{3cm}\parbox[t]{9cm}{%
    % \XDU@font@zihao{4}\setlength{\baselineskip}{30pt}%
    % \newlength{\linelength}
    % \setlength{\linelength}{5cm}
    % \XDU@font@st{学科专业：~}\XDU@font@st\XDU@underline[\linelength]{\XDU@value@author@major}\\%
    % \setlength{\linelength}{5cm}
    % \XDU@font@st{研\hspace{1.75mm}究\hspace{1.75mm} 生：~}\XDU@font@st\XDU@underline[\linelength]{\XDU@value@author@name}\\%
    % \setlength{\linelength}{5cm}
    % \XDU@font@st{指导老师：~}\XDU@font@st\XDU@underline[\linelength]{\XDU@value@advisor@name~\XDU@value@advisor@title}%

    % \vspace{4cm}
    % \begin{center}
    % \XDU@value@author@school \\
    % \makebox[10em][c]{2021\ 年\ 06\ 月}
    % \end{center}
    
    % }
\clearpage\thispagestyle{empty}\setlength{\parindent}{2\ccwd}\cleardoublepage}}

%中文标题页声明
\DeclareRobustCommand{\XDU@make@title}
  {{\cleardoublepage\setlength{\parindent}{0pt}\thispagestyle{empty}%

    \normalfont\XDU@font@st\renewcommand{\baselinestretch}{1.2}\zihao{5}%
    \rule{0pt}{1.35cm}\parbox[b]{4.5cm}{
        \XDU@bold\XDU@label@cover@UDC\XDU@underline[73pt]{\XDU@value@thesis@UDC}\par%
        \vspace{2pt}%
        \XDU@bold\XDU@label@cover@classification\XDU@underline[73pt]{\XDU@value@thesis@classification}%
    }
    \hfill\parbox[b]{4.5cm}{
        \XDU@bold\XDU@label@cover@studentNo\XDU@underline[83pt]{\XDU@value@thesis@studentNo}\par%
        \vspace{2pt}%
        \XDU@bold\XDU@label@cover@confidential\XDU@underline[83pt]{\XDU@value@thesis@confidential}%
    }

\renewcommand{\baselinestretch}{1}%
    \vspace{2.05cm}%
    \makebox[\textwidth]{\rule{0pt}{4.5cm}\shortstack[c]{
        \XDU@bold\XDU@font@ht\XDU@font@zihao{1}\setlength{\baselineskip}{30pt}\XDU@label@university\\%
        \vspace{60pt} \\%
        \XDU@bold\XDU@font@st\XDU@font@zihao{-1}\setlength{\baselineskip}{30pt}\XDU@value@degreemark\XDU@value@thesis%
    }}
    \rule{0pt}{2.7cm}%
    \rule[-3.2cm]{0pt}{3.2cm}\parbox[t]{\textwidth}{
    \begin{center}%
     \XDU@bold\XDU@font@zihao{2}\setlength{\baselineskip}{30pt}\XDU@value@thesis@title%
    \end{center}%
    }

    \vspace{2.5cm}%
    \hspace{4.5cm}\parbox{10.5cm}{
        \XDU@font@st\XDU@font@zihao{4}\setlength{\baselineskip}{32pt}%
        {\XDU@bold\XDU@label@cover@author}\XDU@value@author@name\\%
        {\XDU@bold\XDU@label@cover@major}\XDU@value@author@major\\%
        {\XDU@bold\XDU@label@cover@submajor}\XDU@value@author@submajor\\%
        {\XDU@bold\XDU@label@cover@degree}\XDU@value@degree\\%
        {\XDU@bold\XDU@label@cover@advisor}\XDU@value@advisor@name~\XDU@value@advisor@title\\%
        {\XDU@bold\XDU@label@cover@school}\XDU@value@school\\%
        {\XDU@bold\XDU@label@cover@submit@date}\XDU@value@thesis@submit@date%
    }
   \clearpage\thispagestyle{empty}%
   \renewcommand{\baselinestretch}{1}%
   \setlength{\parindent}{2\ccwd}\cleardoublepage}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    english  cover
%中文标题页声明
\DeclareRobustCommand{\XDU@make@titleenglish}
  {{\cleardoublepage\setlength{\parindent}{0pt}\thispagestyle{empty}%
    \normalfont\XDU@font@st%

    \rule[-3.5cm]{0pt}{3.5cm}\parbox[t]{\textwidth}{%
    \XDU@font@zihao{2}\setlength{\baselineskip}{30pt}%
    \begin{center}%
        {\XDU@bold\XDU@evalue@thesis@title}%
    \end{center}%
    }
    \rule{0pt}{2.5cm}%
    \rule[-5.5cm]{0pt}{5.5cm}\parbox[t]{\textwidth}{%
    \XDU@font@zihao{3}\setlength{\baselineskip}{30pt}%
    \begin{center}%
A\space\XDU@evalue@papertype\space submitted to\\\XDU@elabel@university\\%
in partial fulfillment of the requirements \\ for the degree of\space\XDU@evalue@degree%
\\ in\space\XDU@evalue@author@major%
    \end{center}%
    }
    \rule{0pt}{7.2cm}%
    \rule[-4.5cm]{0pt}{4.5cm}\parbox[t]{\textwidth}{%
    \XDU@font@zihao{3}\setlength{\baselineskip}{30pt}%
    \begin{center}%
By \\%
\XDU@evalue@author@name\\%
\XDU@elabel@cover@advisor\XDU@evalue@advisor@name~~{Title:}\XDU@evalue@advisor@title\\%
\XDU@evalue@thesis@submit@date\\%
    \end{center}%
    }
   \clearpage\thispagestyle{empty}%
   \setlength{\parindent}{2\ccwd}\cleardoublepage}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    statement and copyright
%独创性声明
\DeclareRobustCommand{\XDU@make@statementandcopyright}
  {{\cleardoublepage\setlength{\parindent}{0pt}\thispagestyle{empty}%
  \quad
  % \vspace{5pt}
  \normalfont\XDU@font@st%
   \begin{center}%
    % \vskip 20pt%
   \XDU@font@zihao{-2}%
     \XDU@label@stat@statement%独创性声明字样
   \end{center}%
   \vskip 20pt
   \XDU@font@zihao{-4}%
   \hspace*{2em}\setlength{\parindent}{2\ccwd}\XDU@value@stat@statement\setlength{\parindent}{0pt}%独创性声明内容
  \vskip 40pt%
   \hspace*{2em}\XDU@lable@stat@auther\hspace* {2em}%学位论文作者签名字样 
    \hfill \XDU@lable@stat@date\hspace*{1em} %签字日期字样
  \vskip 100pt%
   \begin{center}%
     \bfseries\XDU@font@zihao{-2}%
     \XDU@lable@stat@copyright%学位论文版权使用授权书字样
   \end{center}%
   \vskip 40pt%
   \XDU@font@zihao{-4}%
   \hspace*{2em}\setlength{\parindent}{2\ccwd}\XDU@value@stat@copyright\setlength{\parindent}{0pt}%学位论文版权使用授权书内容
  \vskip 60pt%
   \normalfont\XDU@font@st\XDU@font@zihao{-4}%
   \hspace*{2em}\XDU@lable@stat@auther\hspace*{1em}%%学位论文作者签名字样 
    \hfill \XDU@lable@stat@advisor\hspace*{8em}%
  \vskip 20pt%
   \hspace*{2em}\XDU@lable@stat@date\hspace*{1em}%
    \hfill \XDU@lable@stat@date\hspace*{1em}%
  \vskip \stretch{1}%
  \clearpage\thispagestyle{empty}%
  \setlength{\parindent}{2\ccwd}\cleardoublepage}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    abstract
%%中文摘要
%% chinese abstract
\newenvironment{abstract}
  {\XDU@toc@add{\XDU@toc@abstract}%
  \begin{center}
     {\XDU@font@st\XDU@bold\XDU@font@zihao{2}\XDU@label@abstract}
  \end{center}
   \XDU@font@zihao{-4}}
  {\cleardoublepage}

%% chinese keywords 关键词
\DeclareRobustCommand{\keywords}[1]
  {{\setlength{\parindent}{2em}\vspace{20pt}%
   \normalfont\XDU@font@ht\XDU@font@zihao{4}%
   \XDU@label@keywords%
   \normalfont\XDU@font@st\XDU@font@zihao{-4}%
   {#1}\setlength{\parindent}{2\ccwd}}}

%% english abstract 英文摘要
\newenvironment{englishabstract}
  {\XDU@toc@add{\XDU@etoc@abstract}\XDU@nchapter{\XDU@elabel@abstract}%
   \vspace{-2ex}\setlength{\parindent}{0pt}\normalfont\XDU@font@zihao{-4}%
   \setlength{\parindent}{0pt}}
  {\cleardoublepage}

%% english keywords
\DeclareRobustCommand{\englishkeywords}[1]
  {{\setlength{\parindent}{2em}\vspace{2ex}%
   \normalfont\XDU@font@st\bfseries\XDU@font@zihao{4}%
   \XDU@elabel@keywords~%
   \normalfont\XDU@font@st\XDU@font@zihao{-4}%
   {#1}\setlength{\parindent}{2\ccwd}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    content 字号
    \renewcommand{\cftdot}{\ldots}
    \renewcommand{\cftdotsep}{0.1}
    \setlength{\cftbeforechapskip}{0pt}
    \setlength{\cftbeforesecskip}{0pt}
    \setlength{\cftbeforesubsecskip}{0pt}
    \renewcommand{\cftchapfont}{\XDU@font@ht\XDU@font@zihao{-4}}
    \renewcommand{\cftsecfont}{\XDU@font@st\XDU@font@zihao{-4}}
    \renewcommand{\cftsubsecfont}{\XDU@font@st\XDU@font@zihao{-4}}
    \renewcommand{\cftchapleader}{\cftdotfill{\cftchapdotsep}}
    \renewcommand{\cftchapdotsep}{\cftdotsep}
    \renewcommand{\cftchappagefont}{\XDU@font@st\XDU@font@zihao{-4}}
    \renewcommand{\cftsecpagefont}{\XDU@font@zihao{-4}}
    \renewcommand{\cftsubsecpagefont}{\XDU@font@zihao{-4}}
    \renewcommand{\cftfigfont}{\XDU@font@st\XDU@font@zihao{-4}}
    \renewcommand{\cftloftitlefont}{\XDU@font@st\XDU@font@zihao{-4}}
    \renewcommand{\cftfigpagefont}{\XDU@font@st\XDU@font@zihao{-4}}
    \renewcommand{\cfttabfont}{\XDU@font@st\XDU@font@zihao{-4}}
    \renewcommand{\cftlottitlefont}{\XDU@font@st\XDU@font@zihao{-4}}
    \renewcommand{\cfttabpagefont}{\XDU@font@st\XDU@font@zihao{-4}}

    \setlength{\abovecaptionskip}{0pt}
    \setlength{\belowcaptionskip}{0pt}
    %%\renewcommand{\captionlabeldelim}{\ ~}%去冒号
    \DeclareCaptionLabelSeparator{twospace}{\ ~}
    \captionsetup{labelsep=twospace} 
    \renewcommand{\captionfont}{\XDU@font@st\XDU@font@zihao{5}\linespread{1.25}\selectfont}

%% list of figures 图清单
\ctexset { listfigurename={\XDU@label@listoffigures } }
\DeclareRobustCommand{\XDU@listoffigures}
  {\XDU@toc@add{\XDU@toc@listoffigures}%
  % \listoffigures
    {%
    \let\oldnumberline\numberline%
    \renewcommand{\numberline}{\figurename~\oldnumberline}%
    \listoffigures%
    }
}

%% list of tables 表清单
\ctexset { listtablename={\XDU@label@listoftables } } 
\DeclareRobustCommand{\XDU@listoftables}
  {\XDU@toc@add{\XDU@toc@listoftables}%
    {%
    \let\oldnumberline\numberline%
    \renewcommand{\numberline}{\tablename~\oldnumberline}%
    \listoftables%
    }   
    }

%取消图片索引和表格索引中不同章节的间距
\newcommand*{\noaddvspace}{\renewcommand*{\addvspace}[1]{}}
\addtocontents{lof}{\protect\noaddvspace}
\addtocontents{lot}{\protect\noaddvspace} 

%% list of Symbols
\newenvironment{symbollist}
  {\setlength{\parindent}{0pt}\XDU@toc@add{\XDU@toc@symbollist@title}%
  \titleformat{\chapter}[display]{\bfseries \fontsize{22pt}{0pt}\centering
}{\thechapter}{1em}{}{}
\titlespacing{\chapter}{0pt}{8pt}{18pt}
   \XDU@nchapter{\XDU@label@symbollist@title}\setlength{\parindent}{2\ccwd}%
   \begin{list}{}
    {\setlength{\topsep}{0pt}\setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}
    \setlength{\parindent}{0pt}
     \setlength{\leftmargin}{2em}}}
  {\end{list}\setlength{\parindent}{2\ccwd}\cleardoublepage}

%原字母环境
%item无法加粗字体，现删掉了\normalfont\XDU@font@st\XDU@font@zihao{-4}
%   \newenvironment{symbollist}
%    \XDU@nchapter{\XDU@label@symbollist@title}\setlength{\parindent}{2\ccwd}%
%    \begin{list}{}
%     {\setlength{\topsep}{0pt}\setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}
%     \setlength{\parindent}{0pt}\normalfont\XDU@font@st\XDU@font@zihao{-4}
%      \setlength{\leftmargin}{0.5\labelwidth}}}
%   {\end{list}\setlength{\parindent}{2\ccwd}\cleardoublepage}

%% list of abbreviations
\newenvironment{abbreviationlist}
  {\setlength{\parindent}{0pt}\XDU@toc@add{\XDU@toc@abbreviationlist@title}%
  \titleformat{\chapter}[display]{\bfseries \fontsize{22pt}{0pt}\centering
}{\thechapter}{1em}{}{}
\titlespacing{\chapter}{0pt}{8pt}{18pt}
   \XDU@nchapter{\XDU@label@abbreviationlist@title}\setlength{\parindent}{2\ccwd}%
   \begin{list}{}
    {\setlength{\topsep}{0pt}\setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}
    \setlength{\parindent}{0pt}\normalfont\XDU@font@st\XDU@font@zihao{-4}
     \setlength{\leftmargin}{0.5\labelwidth}}}
  {\end{list}\setlength{\parindent}{2\ccwd}\cleardoublepage}

%% content
\ctexset { contentsname={\XDU@label@content } }
\DeclareRobustCommand{\XDU@tableofcontents}
  {
  \addcontentsline{toc}{chapter}{目录}  
  \tableofcontents}
%\renewcommand{\cftdotsep}{0.3pt}
%\newcommand\mydot[1]{\scalebox{#1}{.}}
%\renewcommand\cftdot{\mydot{1}} % change the size of dots
%\renewcommand\cftdotsep{0.3} % change the space between dots

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    referrence
\RequirePackage{url}
\renewcommand{\UrlFont}{\XDU@font@zihao{5}}
\ctexset { bibname={\XDU@label@ref@title } }
\bibliographystyle{gbt7714-2005}

\renewenvironment{thebibliography}[1]
  {\XDU@toc@add{\XDU@toc@ref@title}%
   \XDU@nchapter{\bibname}%
   \XDU@font@zihao{5}%
   \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
   \list{\@biblabel{\@arabic\c@enumiv}}%
    {\setlength{\topsep}{0pt}\setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}
    \settowidth\labelwidth{\@biblabel{#1}}%
     \leftmargin\labelwidth\advance\leftmargin\labelsep%
     \@openbib@code\usecounter{enumiv}\let\p@enumiv\@empty%
     \renewcommand\theenumiv{\@arabic\c@enumiv}}%
   \sloppy\clubpenalty4000\@clubpenalty\clubpenalty%
   \widowpenalty4000\sfcode`\.\@m}
  {\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
   \endlist
   \cleardoublepage
   }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    thanks

\renewenvironment{thanks}
  {\XDU@toc@add{\XDU@toc@thanks}%
   \XDU@nchapter{\XDU@label@thanks}}
  {\cleardoublepage}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    resume

%% environment
\newenvironment{resume}
  {\setlength{\parindent}{0pt}\XDU@toc@add{\XDU@toc@resume@title}%
   \XDU@nchapter{\XDU@label@resume@title}%
   \renewcommand{\thesection}{\arabic{section}}\setlength{\parindent}{2\ccwd}}
  {\cleardoublepage}

%% resume list
\newcounter{XDU@counter@resumelistcounter}
\newenvironment{resumelist}[1]
  {{\subsection*{\textbf{#1}}\setlength{\parindent}{2\ccwd}}%
   \begin{list}{[\arabic{XDU@counter@resumelistcounter}]}
    {\usecounter{XDU@counter@resumelistcounter}
     \setcounter{XDU@counter@resumelistcounter}{0}
     \setlength{\topsep}{0pt}\setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}
     \setlength{\parindent}{0pt}\normalfont\XDU@font@st\XDU@font@zihao{-4}
     \setlength{\leftmargin}{2\labelwidth}}}
  {\end{list}}

\newenvironment{resumelist*}
  {\begin{list}{}
    {\setlength{\topsep}{0pt}\setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}
    \setlength{\parindent}{0pt}\normalfont\XDU@font@st\XDU@font@zihao{-4}
     \setlength{\leftmargin}{\labelwidth}}}
  {\end{list}}

%% resume list item
\DeclareRobustCommand{\resumelistitem}{\item{}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    thesis structure

%% front matter
\DeclareRobustCommand{\XDUfrontmatter}
  {\XDU@make@cover%
   %\XDU@make@title%不显示中文标题页
   %\XDU@make@titleenglish%不显示英文标题页
   \XDU@make@statementandcopyright%
   \frontmatter\pagenumbering{Roman}%
   \setlength{\baselineskip}{20pt}
   \pagestyle{precontent} %开启正文前页眉页脚样式(fancyhdr宏包)
   }

%% premain matter
\DeclareRobustCommand{\XDUpremainmatter}
  {\XDU@listoffigures\cleardoublepage%
   \XDU@listoftables\cleardoublepage%
  }
%% main matter
\DeclareRobustCommand{\XDUmainmatter}
  {\XDU@tableofcontents\cleardoublepage%
   \mainmatter
   \pagestyle{content} %开启正文页眉页脚样式(fancyhdr宏包)
   }
% \frontmatter：关闭章节序号， 页码使用罗马数字;\mainmatter：开启章节序号计数，重置页码，页码使用阿拉伯数字;\appendix：重置章节序号计数， 章节序号使用字母，对页码没有影响；\backmatter：关闭章节序号，对页码没有影响。

% 作者：张瑜
% 链接：https://www.zhihu.com/question/56203547/answer/829181566
% 来源：知乎
% 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
%% back matter
\DeclareRobustCommand{\XDUbackmatter}[1]
  {\backmatter{}#1{}}
