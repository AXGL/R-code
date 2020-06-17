library(rvest)
library(stringr)
library(XML)
library(xml2)
url<-'http://sports.sina.com.cn/nba/'
web<-read_html(url)
title<-html_nodes(web,'.item p a')%>%html_text
title
