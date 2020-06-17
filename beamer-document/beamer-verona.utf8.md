---
title: "R Markdown 制作 beamer 幻灯片"
author: "黄湘云"
institute: "中国矿业大学（北京）"
date: "2020-06-13"
documentclass: ctexbeamer
output: 
  bookdown::pdf_book: 
    number_sections: yes
    toc: no
    base_format: rmarkdown::beamer_presentation
    latex_engine: xelatex
    citation_package: natbib
    keep_tex: no # yes for debug
    template: null
    theme: Verona 
    pandoc_args: !expr rmarkdown:::pandoc_lua_filters("latex-div.lua")
header-includes:
   - \logo{\includegraphics[height=0.8cm]{C:/PROGRA~1/R/R-40~1.0/doc/html/Rlogo}}
themeoptions: 
  - colorblocks
  - showheader
  - red
biblio-style: apalike
bibliography: 
  - packages.bib
classoption: "UTF8,fontset=adobe,zihao=false"
link-citations: yes
section-titles: false
biblio-title: 参考文献
colorlinks: yes
---



# 介绍 {#intro}

## 目录 {#outline}

1. Markdown

   1. John Gruber’s Markdown
   1. Pandoc’s Markdown
   1. Hugo's Markdown/Blackfriday’s Markdown 
   1. R Markdown

1. R Markdown

   1. Pandoc
   1. LaTeX
   1. CSS/JS/HTML
   1. Lua

1. Pandoc

   1. Haskell


## R 语言 {#sec:rlang}


::: {.quotation data-latex="[John Gruber]"}
A Markdown-formatted document should be publishable as-is, as plain text, 
without looking like it’s been marked up with tags or formatting instructions.  
:::


Markdown 提供一种简洁的格式语法，用来编辑 HTML、PDF 和 MS Word 文档。
介绍 R Markodwn 文档如何插入图片，更多详情见 <https://rmarkdown.rstudio.com> [@rmarkdown2018]。

R 语言的命名部分来源于最初的两位作者的姓名的首字母 Robert Gentleman 和 Ross Ihaka，
部分是由于贝尔实验室推出的 S 语言 [@base]。


## Markdown 语法 {#sec:markdown}

轻微强调 
:   这是倾斜的文字 _下划线表示强调_, and this is *星花表示强调*.

特别强调 
:   这是加粗的文字 **strong emphasis** and __with underscores__.

强烈强调
:   这是斜体加粗的文字 ***三个星花***

删除线 
:   This ~~is deleted text.~~

上下标 
:   H~2~O is a liquid.  2^10^ is 1024. C^137^ 是一种放射性元素


Table: (\#tab:insert-tab) 表格标题^[附有脚注]

| First Header | Second Header |
| :----------- | :------------ |
| Content Cell | Content Cell  |
| Content Cell | Content Cell  |



## Markdown 插图 {#sec:fig-markdown}

中括号、小括号、大括号分别对应图片标题、路径、属性

```markdown
![...](...){...}
```

![(\#fig:fig-markdown) 默认图片位置居左^[这里是脚注]](beamer-verona_files/figure-beamer/sleep-1.pdf){ width=50% }


## 睡眠数据 sleep {#sec:sleep}

\begin{figure}
\includegraphics[width=0.7\linewidth]{beamer-verona_files/figure-beamer/sleep-1} \caption{药物对睡眠时长的影响}(\#fig:sleep)
\end{figure}

## 压力数据 pressure {#sec:pressure}


\begin{figure}
\includegraphics[width=0.65\linewidth]{beamer-verona_files/figure-beamer/pressure-1} \caption{压力和温度的关系}(\#fig:pressure)
\end{figure}


## 设置主题 {#sec:setup-verona}
 
Ivan Valbusa 开发了 [Verona 主题的 Beamer 模版](https://bitbucket.org/rivanvx/beamer)，
目前 CTAN 上的版本是 0.2，文档说明见 <https://www.ctan.org/pkg/beamer-verona>
这个主题的宏包依赖很少！我很喜欢！

```r
tinytex::tlmgr_install('beamer-verona')
```


## 自定义的块 {#sec:custom-blocks}

::: {.quotation data-latex="[Donald E. Knuth, The \TeX book]"}
Gentle reader: This is a handbook about TEX, a new typesetting
system G intended for the creation of beautiful books—and
especially for books that contain a lot of mathematics.
:::


::: {.exampleblock data-latex="{提示}"}
提示
:::

. . .

::: {.alertblock data-latex="{警告}"}
警告
:::

. . .

::: {.block data-latex="{注意}"}
请读者注意
:::


## 运行环境 {#session-info .allowframebreaks}

制作此幻灯片，我们使用了  bookdown 包 [@bookdown2016]、 rmarkdown 包 [@rmarkdown2018] 和 knitr 包 [@knitr2015]，以及  R version 4.0.0 (2020-04-24) 其它软件和环境信息见下方


```r
xfun::session_info(c(
  "bookdown", "rmarkdown", "knitr"
), dependencies = TRUE)
```

```
R version 4.0.0 (2020-04-24)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 10 x64 (build 16299)

Locale:
  LC_COLLATE=Chinese (Simplified)_China.936 
  LC_CTYPE=Chinese (Simplified)_China.936   
  LC_MONETARY=Chinese (Simplified)_China.936
  LC_NUMERIC=C                              
  LC_TIME=Chinese (Simplified)_China.936    

Package version:
  base64enc_0.1.3 bookdown_0.19   digest_0.6.25   evaluate_0.14  
  glue_1.4.1      graphics_4.0.0  grDevices_4.0.0 highr_0.8      
  htmltools_0.4.0 jsonlite_1.6.1  knitr_1.28      magrittr_1.5   
  markdown_1.1    methods_4.0.0   mime_0.9        Rcpp_1.0.4.6   
  rlang_0.4.6     rmarkdown_2.2   stats_4.0.0     stringi_1.4.6  
  stringr_1.4.0   tinytex_0.23    tools_4.0.0     utils_4.0.0    
  xfun_0.14       yaml_2.2.1     

Pandoc version: 2.7.3
```


